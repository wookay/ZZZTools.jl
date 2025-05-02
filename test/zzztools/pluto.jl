using Jive
@If !haskey(ENV, "CI") module test_zzztools_pluto

using Test
using ZZZTools # Weapon
using .ZZZTools: GO
using PlutoUI: Resource
using Jive

circle = GO.get_discs_circle("WoodpeckerElectro", "Woodpecker Electro")
@test circle isa Resource

big = GO.get_wengines_big("LunarPleniluna", "[Lunar] Pleniluna")
@test big isa Resource

anby = Character(Id = 1011)

if isdefined(Jive, :sprint_html)
@test startswith(sprint_html(anby), "<div")
end # if sprint_html

end # module test_zzztools_pluto
