module test_zzztools_eridu_findall

using Test
using ZZZTools

agents = Eridu.findall(Stun in Character)
@test length(agents) == 7
@test last(agents) == Character(Id = 1361)

agents = Eridu.findall(Ether in Character)
@test length(agents) == 4
@test last(agents) == Character(Id = 1331)

agents = Eridu.findall(OR(Fire, Ice) in Character)
@test length(agents) == 12
@test last(agents) == Character(Id = 1321)

agents = Eridu.findall(AND(Stun, Fire) in Character)
@test length(agents) == 2
@test last(agents) == Character(Id = 1161)

end # module test_zzztools_eridu_findall
