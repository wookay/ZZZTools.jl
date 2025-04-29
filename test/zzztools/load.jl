module test_zzztools_eridu_load

using Test
using ZZZTools

anby = Eridu.load(Character(Id = 1011))
@test anby.Name == "Anby"
@test anby isa NamedTuple

miyabi = Eridu.load(Character(Id = 1091))
miyabi.Name == "Miyabi"

@test Eridu.load(Character(Id = 0)) === nothing

penguinboo = Eridu.load(Bangboo(Id = 53001))
@test penguinboo.Name == "Penguinboo"

woodpecker_electro = Eridu.load(Equipment(Id = 31000))
@test woodpecker_electro.Name == "Woodpecker Electro"

tyrfing = Eridu.load(Monster(Id = 10000))
@test tyrfing.Name == "Tyrfing"

pleniluna = Eridu.load(Weapon(Id = 12001))
@test pleniluna.Name == "[Lunar] Pleniluna"

end # module test_zzztools_eridu_load
