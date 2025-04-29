file_read_counter = Dict{String, Int}()
function Base.read(filename::String, T::Type{String})::T
    contents = open(io -> read(io, T), filename)
    if haskey(file_read_counter, filename)
        setindex!(file_read_counter, getindex(file_read_counter, filename) + 1, filename)
    else
        setindex!(file_read_counter, 1, filename)
    end
    # @info filename, T, length(contents)
    contents
end

using JSON2
json_read(path) = JSON2.read(Base.read(path, String))

hakushin_data_dir = get(ENV, "ZZZ_HAKUSHIN_DATA_DIR", normpath(@__DIR__, "zzz-hakushin-data"))
if isdir(hakushin_data_dir)
    ZZZ_HAKUSHIN_DATA_DIR = hakushin_data_dir
else
    if haskey(ENV, "CI")
        run(Cmd(`git clone --depth=1 https://github.com/Genshin-Optimizer/zzz-hakushin-data.git gen/zzz-hakushin-data`))
        ZZZ_HAKUSHIN_DATA_DIR = normpath(@__DIR__, "zzz-hakushin-data")
    else
        printstyled("need zzz-hakushin-data\n", color = :red)
    end
end
