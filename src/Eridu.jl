module Eridu # ZZZTools

include(normpath(@__DIR__, "../gen/Lib.jl"))

function find(::Type{T}, nt::@NamedTuple{Id::Int})::Union{Nothing, T} where T
    path = normpath(ZZZ_HAKUSHIN_DATA_DIR, lowercase(String(nameof(T))), string(nt.Id, ".json"))
    if isfile(path)
        data = json_read(path)
        T(data)
    else
        nothing
    end
end

end # module ZZZTools.Eridu
