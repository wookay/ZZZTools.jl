using Jive
@useinside Main module test_zzztools_eridu_findall

using Test
using ZZZTools

agents = Eridu.findall(Stun in Character)

# "Name": "Anby",
# "WeaponType": { "2": "Stun" },
# "ElementType": { "203": "Electric" },
# "HitType": { "101": "Slash" }

anby = first(Eridu.cached(Character))
# type = 2, element = 203
@test anby.type    == 2
@test anby.element == 203
@test anby.hit     == 101
@test anby.EN      == "Anby"
@test WeaponType(anby.type) == Stun # 2
@test ElementType(anby.element) == Electric # 203
@test HitType(anby.hit) == Slash # 101

#agents = Eridu.findall(Fire in Character)
#agents = Eridu.findall((Fire, Ice) in Character)
#agents = Eridu.findall((Stun, Fire) in Character)

end # module test_zzztools_eridu_findall
