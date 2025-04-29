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

struct ZzzQuery{T}
end

function findall(query::ZzzQuery{T}) where T
    cached_table(T)
end

_tbl_dict = Dict{Type, NamedTuple}()

function cached_table(::Type{T}) where T
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

using ..ZZZTools: WeaponType, ElementType
using ..ZZZTools: Character

function Base.in(prop::NTuple{N, Union{WeaponType, ElementType}}, ::Type{T})::ZzzQuery{T} where {N, T}
    ZzzQuery{T}()
end

function Base.in(prop::WeaponType, ::Type{T})::ZzzQuery{T} where T
    ZzzQuery{T}()
end

function Base.in(prop::ElementType, ::Type{T})::ZzzQuery{T} where T
    ZzzQuery{T}()
end

end # module ZZZTools.Eridu
