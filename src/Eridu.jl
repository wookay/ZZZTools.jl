module Eridu # ZZZTools

include(normpath(@__DIR__, "../gen/Lib.jl"))

function load(x::T)::Union{Nothing, NamedTuple} where T
    path = normpath(ZZZ_HAKUSHIN_DATA_DIR, lowercase(String(nameof(T))), string(x.Id, ".json"))
    if isfile(path)
        data = json_read(path)
        data
    else
        nothing
    end
end

using LogicalOperators: AND, OR, AbstractLogicalOperator

struct ZzzQuery{T}
    logical::AbstractLogicalOperator
end

parseInt(sym::Symbol) = parse(Int, String(sym))

function findall(query::ZzzQuery{T}) where T
    tbl = cached(T)
    Id_syms = Base.findall(tbl) do c
        if query.logical isa AND
            all(f -> f(c), query.logical.elements)
        elseif query.logical isa OR
            any(f -> f(c), query.logical.elements)
        end
    end
    map(Id_syms) do sym
        T(Id = parseInt(sym))
    end
end

_tbl_dict = Dict{Type, NamedTuple}()

function cached(::Type{T}) where T
    if haskey(_tbl_dict, T)
        return getindex(_tbl_dict, T)
    else
        path = normpath(ZZZ_HAKUSHIN_DATA_DIR, lowercase(string(nameof(T), ".json")))
        if isfile(path)
            data = json_read(path)
            setindex!(_tbl_dict, data, T)
            return data
        else
            return nothing
        end
    end
end

using ..ZZZTools: WeaponType, ElementType, HitType
using ..ZZZTools: Character

function Base.in(and::AND, ::Type{T})::ZzzQuery{T} where T
    conds = map(and.elements) do el
        only(Base.in(el, T).logical.elements)
    end
    ZzzQuery{T}(AND(conds...))
end

function Base.in(or::OR, ::Type{T})::ZzzQuery{T} where T
    conds = map(or.elements) do el
        only(Base.in(el, T).logical.elements)
    end
    ZzzQuery{T}(OR(conds...))
end

function Base.in(weapon::WeaponType, ::Type{T})::ZzzQuery{T} where T
    ZzzQuery{T}(AND((c::NamedTuple) -> c.type == UInt8(weapon)))
end

function Base.in(element::ElementType, ::Type{T})::ZzzQuery{T} where T
    ZzzQuery{T}(AND((c::NamedTuple) -> c.element == UInt8(element)))
end

function Base.in(hit::HitType, ::Type{T})::ZzzQuery{T} where T
    ZzzQuery{T}(AND((c::NamedTuple) -> c.hit == UInt8(hit)))
end

end # module ZZZTools.Eridu
