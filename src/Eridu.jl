module Eridu # ZZZTools

include(normpath(@__DIR__, "../gen/Lib.jl"))

function load(x::T)::Union{Nothing, NamedTuple} where T
    path = normpath(ZZZ_HAKUSHIN_DATA_DIR, lowercase(String(nameof(T))), string(x.Id, ".json"))
    if isfile(path)
        data = json_read_path(path)
        data
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

using Meringues # Recipe

function _find_expr(f_expr::Expr, expr::Expr)::Tuple{Expr, Symbol}
    syrup = Recipe.dissolve(expr)
    find_expr = Expr(:call,
                     f_expr,
                     syrup.starch,
                     Expr(:call, :(Eridu.cached), syrup.slurry))
    (find_expr, syrup.slurry)
end

function _find(f_expr::Expr, expr::Expr)::Union{Nothing, <: ZzzAsset}
    (find_expr, T_sym) = _find_expr(f_expr, expr)
    Id_sym::Union{Nothing, Symbol} = Core.eval(@__MODULE__, find_expr)
    if Id_sym === nothing
        return nothing
    else
        T = getfield(Eridu, T_sym)
        return T(Id = parseInt(Id_sym))
    end
end

function findfirst(expr::Expr)::Union{Nothing, <: ZzzAsset}
    _find(:(Base.findfirst), expr)
end

function findlast(expr::Expr)::Union{Nothing, <: ZzzAsset}
    _find(:(Base.findlast), expr)
end

function findall(expr::Expr)::Vector{<: ZzzAsset}
    f_expr = :(Base.findall)
    (find_expr, T_sym) = _find_expr(f_expr, expr)
    T = getfield(Eridu, T_sym)
    return map(Core.eval(@__MODULE__, find_expr)) do Id_sym
        T(Id = parseInt(Id_sym))
    end
end

function findall(query::ZzzQuery{T})::Vector{T} where T <: ZzzAsset
    tbl = cached(T)
    Id_syms = Base.findall(tbl) do c
        if query.logical isa AND
            all(f -> f(c), query.logical.elements)
        elseif query.logical isa OR
            any(f -> f(c), query.logical.elements)
        end
    end
    map(Id_syms) do Id_sym
        T(Id = parseInt(Id_sym))
    end
end

function findall(::Type{T})::Vector{T} where T <: ZzzAsset
    Id_syms = (collect ∘ keys ∘ cached)(T)
    map(Id_syms) do Id_sym
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
