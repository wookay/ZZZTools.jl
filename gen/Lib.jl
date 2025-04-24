using JSON2
json_read(path) = JSON2.read(Base.read(path, String))

hakushin_data_dir = get(ENV, "ZZZ_HAKUSHIN_DATA_DIR", normpath(@__DIR__, "zzz-hakushin-data"))
if isdir(hakushin_data_dir)
    ZZZ_HAKUSHIN_DATA_DIR = hakushin_data_dir
else
    @info :__DIR__  @__DIR__
    @info :pwd      pwd()
    run(Cmd(`git clone https://github.com/Genshin-Optimizer/zzz-hakushin-data.git`))
    ZZZ_HAKUSHIN_DATA_DIR = normpath(pwd(), "zzz-hakushin-data")
end
