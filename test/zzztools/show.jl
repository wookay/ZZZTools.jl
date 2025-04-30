module test_zzztools_show

using Test
using ZZZTools
using Jive

if false
f = sprint_colored
println(join(f.((Physical, Fire, Ice, Electric, Ether)), ", "))
(println ∘ f)(Character(Id = 1361))
(println ∘ f)(Weapon(Id = 12001))
(println ∘ f)(Monster(Id = 10000))
(println ∘ f)(Equipment(Id = 31000))
(println ∘ f)(Bangboo(Id = 53001))
end

@test join(sprint_plain.((Physical, Fire, Ice, Electric, Ether)), ", ") == "Physical, Fire, Ice, Electric, Ether"
@test sprint_plain(Character(Id = 1361))  == "Character(Id = 1361, Trigger: Stun Electric Pierce)"
@test sprint_plain(Weapon(Id = 12001))    == "Weapon(Id = 12001, [Lunar] Pleniluna: Attack)"
@test sprint_plain(Monster(Id = 10000))   == "Monster(Id = 10000, Tyrfing)"
@test sprint_plain(Equipment(Id = 31000)) == "Equipment(Id = 31000, Woodpecker Electro)"
@test sprint_plain(Bangboo(Id = 53001))   == "Bangboo(Id = 53001, Penguinboo)"

end # module test_zzztools_show
