module Eridu # ZZZTools

include(normpath(@__DIR__, "../gen/Lib.jl"))

function load(x::T)::Union{Nothing, NamedTuple} where T
    path = normpath(ZZZ_HAKUSHIN_DATA_DIR, (lowercase ∘ String ∘ nameof)(T), string(x.Id, ".json"))
    if isfile(path)
        json_read_path(path)
    else
        nothing
    end
end

parseInt(sym::Symbol)::Int = parse(Int, String(sym))

using ..ZZZTools: ZzzQuery, ZzzAsset
using ..ZZZTools: AbstractLogicalOperator, AND, OR
using ..ZZZTools: WeaponType, ElementType, HitType
using ..ZZZTools: Character, Weapon, Monster, Equipment, Bangboo

_tbl_dict = Dict{Type{<: ZzzAsset}, NamedTuple}()

function cached(::Type{T})::Union{Nothing, NamedTuple} where T <: ZzzAsset
    if haskey(_tbl_dict, T)
        return getindex(_tbl_dict, T)
    else
        path = normpath(ZZZ_HAKUSHIN_DATA_DIR, lowercase(string(nameof(T), ".json")))
        if isfile(path)
            data = json_read_path(path)
            setindex!(_tbl_dict, data, T)
            return data
        else
            return nothing
        end
    end
end

using Meringues # Recipe Syrup

function _find_expr(f_expr::Expr, sugar::Expr)::Syrup
    syrup::Syrup = Recipe.dissolve(sugar)
    find_expr = Expr(:call,
                     f_expr,
                     syrup.starch,
                     Expr(:call, :(Eridu.cached), syrup.slurry))
    Syrup(find_expr, syrup.slurry)
end

function findall(sugar::Expr)::Vector{<: ZzzAsset}
    f_expr = :(Base.findall)
    choco::Syrup = _find_expr(f_expr, sugar)
    (find_expr::Expr, T_sym::Symbol) = (choco.starch, choco.slurry)
    T = getfield(Eridu, T_sym)
    return map(Core.eval(@__MODULE__, find_expr)) do Id_sym
        T(Id = parseInt(Id_sym))
    end
end

function _find(f_expr::Expr, sugar::Expr)::Union{Nothing, <: ZzzAsset}
    choco::Syrup = _find_expr(f_expr, sugar)
    (find_expr::Expr, T_sym::Symbol) = (choco.starch, choco.slurry)
    Id_sym::Union{Nothing, Symbol} = Core.eval(@__MODULE__, find_expr)
    if Id_sym === nothing
        return nothing
    else
        T = getfield(Eridu, T_sym)
        return T(Id = parseInt(Id_sym))
    end
end

function findfirst(sugar::Expr)::Union{Nothing, <: ZzzAsset}
    _find(:(Base.findfirst), sugar)
end

function findlast(sugar::Expr)::Union{Nothing, <: ZzzAsset}
    _find(:(Base.findlast), sugar)
end

function findall(query::ZzzQuery{T})::Vector{T} where T <: ZzzAsset
    ∀ = if query.logical isa AND
        all
    elseif query.logical isa OR
        any
    else
        (_, _) -> false
    end
    Id_syms = Base.findall(cached(T)) do c
        λ = f -> f(c)
        ∀(λ, query.logical.elements)
    end
    map(Id_syms) do Id_sym::Symbol
        T(Id = parseInt(Id_sym))
    end
end

function findall(::Type{T})::Vector{T} where T <: ZzzAsset
    Id_syms = (collect ∘ keys ∘ cached)(T)
    map(Id_syms) do Id_sym::Symbol
        T(Id = parseInt(Id_sym))
    end
end

### Base.in
function Base.in(logical::AbstractLogicalOperator, ::Type{T})::ZzzQuery{T} where T <: ZzzAsset
    conds = map(logical.elements) do el
        only(Base.in(el, T).logical.elements)
    end
    Op = typeof(logical)
    ZzzQuery{T}(Op.name.wrapper(conds...))
end

function Base.in(weapon::WeaponType, ::Type{T})::ZzzQuery{T} where T <: ZzzAsset
    ZzzQuery{T}(AND((c::NamedTuple) -> c.type == UInt8(weapon)))
end

function Base.in(element::ElementType, ::Type{T})::ZzzQuery{T} where T <: ZzzAsset
    ZzzQuery{T}(AND((c::NamedTuple) -> c.element == UInt8(element)))
end

function Base.in(hit::HitType, ::Type{T})::ZzzQuery{T} where T <: ZzzAsset
    ZzzQuery{T}(AND((c::NamedTuple) -> c.hit == UInt8(hit)))
end

end # module ZZZTools.Eridu
