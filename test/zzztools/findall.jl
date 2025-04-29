using Jive
@useinside Main module test_zzztools_eridu_findall

using Test
using ZZZTools

agents = Eridu.findall(Stun in Character)

# "WeaponType": { "2": "Stun" }, "ElementType": { "203": "Electric" }
anby = first(Eridu._tbl_dict[Character])
# type = 2, element = 203
@test anby.type    == 2
@test anby.element == 203

#agents = Eridu.findall(Fire in Character)
#agents = Eridu.findall((Fire, Ice) in Character)
#agents = Eridu.findall((Stun, Fire) in Character)

end # module test_zzztools_eridu_findall
