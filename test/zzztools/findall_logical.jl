module test_zzztools_eridu_findall_logical

using Test
using ZZZTools

chars = Eridu.findall(Stun in Character)
@test length(chars) == 7
@test last(chars) == Character(Id = 1361)

chars = Eridu.findall(Ether in Character)
@test length(chars) == 4
@test last(chars) == Character(Id = 1331)

chars = Eridu.findall(OR(Fire, Ice) in Character)
@test length(chars) == 12
@test last(chars) == Character(Id = 1321)

chars = Eridu.findall(AND(Stun, Fire) in Character)
@test length(chars) == 2
@test last(chars) == Character(Id = 1161)

end # module test_zzztools_eridu_findall_logical
