module test_zzztools_eridu_findfirst

using Test
using ZZZTools

expr = :( c::Character -> c.EN == "Anby" )
@test Eridu.findfirst(expr) == Character(Id = 1011)

expr = :( c::Character -> c.EN == "Venti" )
@test Eridu.findfirst(expr) === nothing

expr = :( weapon::Weapon -> weapon.EN == "[Lunar] Pleniluna" )
@test Eridu.findfirst(expr) === Weapon(Id = 12001)

expr = :( monster::Monster -> monster.EN == "Tyrfing" )
@test Eridu.findfirst(expr) === Monster(Id = 10000)

expr = :( equipment::Equipment -> equipment.EN.name == "Woodpecker Electro" )
@test Eridu.findfirst(expr) === Equipment(Id = 31000)

expr = :( bangboo::Bangboo -> bangboo.EN == "Penguinboo" )
@test Eridu.findfirst(expr) === Bangboo(Id = 53001)

end # module test_zzztools_eridu_findfirst
