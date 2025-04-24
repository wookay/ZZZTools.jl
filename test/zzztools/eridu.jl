module test_zzztools_eridu

using Test
using ZZZTools

anby = Eridu.find(Character, (Id = 1011,))
@test anby.data.Name == "Anby"
@test anby isa Character

miyabi = Eridu.find(Character, (Id = 1091,))
miyabi.data.Name == "Miyabi"

@test Eridu.find(Character, (Id = 0,)) === nothing

penguinboo = Eridu.find(Bangboo, (Id = 53001,))
@test penguinboo.data.Name == "Penguinboo"

woodpecker_electro = Eridu.find(Equipment, (Id = 31000,))
@test woodpecker_electro.data.Name == "Woodpecker Electro"

tyrfing = Eridu.find(Monster, (Id = 10000,))
@test tyrfing.data.Name == "Tyrfing"

pleniluna = Eridu.find(Weapon, (Id = 12001,))
@test pleniluna.data.Name == "[Lunar] Pleniluna"

end # module test_zzztools_eridu
