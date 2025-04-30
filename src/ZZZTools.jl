module ZZZTools

export Bangboo, Character, Equipment, Monster, Weapon
include("types.jl")

export Eridu
include("Eridu.jl")

# LogicalOperators
using .Eridu: AND, OR
export AND, OR

end # module ZZZTools
