using Jive
@useinside Main module test_zzztools_eridu_findall

using Test
using ZZZTools

# "Name": "Anby",
# "WeaponType": { "2": "Stun" },
# "ElementType": { "203": "Electric" },
# "HitType": { "101": "Slash" }

# type = 2, element = 203, hit = 101
anby = first(Eridu.cached(Character))
@test anby.type    == UInt8(Stun)     # 2
@test anby.element == UInt8(Electric) # 203
@test anby.hit     == UInt8(Slash)    # 101
@test WeaponType(anby.type)     == Stun     # 2
@test ElementType(anby.element) == Electric # 203
@test HitType(anby.hit)         == Slash    # 101
@test anby.EN      == "Anby"

agents = Eridu.findall(Stun in Character)
@test length(agents) == 7
@test last(agents) == Character(Id = 1361)

agents = Eridu.findall(Ether in Character)
@test length(agents) == 4
@test last(agents) == Character(Id = 1331)

pleniluna = Eridu.cached(Weapon)[Symbol("12001")]
@test pleniluna.EN == "[Lunar] Pleniluna"
@test WeaponType(pleniluna.type) == Attack # 1

tyrfing = Eridu.cached(Monster)[Symbol("10000")]
@test tyrfing.EN == "Tyrfing"

woodpecker_electro = Eridu.cached(Equipment)[Symbol("31000")]
@test woodpecker_electro.EN.name == "Woodpecker Electro"

penguinboo = Eridu.cached(Bangboo)[Symbol("53001")]
@test penguinboo.EN == "Penguinboo"

agents = Eridu.findall(OR(Fire, Ice) in Character)
@test length(agents) == 12
@test last(agents) == Character(Id = 1321)

agents = Eridu.findall(AND(Stun, Fire) in Character)
@test length(agents) == 2
@test last(agents) == Character(Id = 1161)

end # module test_zzztools_eridu_findall
