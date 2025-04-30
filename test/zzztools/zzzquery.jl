module test_zzztools_zzzquery

using Test
using ZZZTools.Eridu
using         .Eridu: ZzzQuery
using ZZZTools

ZzzQuery{Character}
anby = Eridu.cached(Character)[Symbol("1011")]
@test anby.EN                   == "Anby"
@test WeaponType(anby.type)     == Stun # 2
@test ElementType(anby.element) == Electric # 203
@test HitType(anby.hit)         == Slash # 101

ZzzQuery{Weapon}
pleniluna = Eridu.cached(Weapon)[Symbol("12001")]
@test pleniluna.EN == "[Lunar] Pleniluna"
@test WeaponType(pleniluna.type) == Attack # 1

ZzzQuery{Monster}
tyrfing = Eridu.cached(Monster)[Symbol("10000")]
@test tyrfing.EN == "Tyrfing"

ZzzQuery{Equipment}
woodpecker_electro = Eridu.cached(Equipment)[Symbol("31000")]
@test woodpecker_electro.EN.name == "Woodpecker Electro"

ZzzQuery{Bangboo}
penguinboo = Eridu.cached(Bangboo)[Symbol("53001")]
@test penguinboo.EN == "Penguinboo"

end # module test_zzztools_zzzquery
