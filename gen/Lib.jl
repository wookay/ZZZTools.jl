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
