# module ZZZTools

using LogicalOperators: AbstractLogicalOperator, AND, OR

struct ZzzQuery{T}
    logical::AbstractLogicalOperator
end

export WeaponType, Attack, Stun, Anomaly, Support, Defense
@enum WeaponType::UInt8 begin
    Attack  = 1
    Stun    = 2
    Anomaly = 3
    Support = 4
    Defense = 5
end

export HitType, Slash, Strike, Pierce
@enum HitType::UInt8 begin
    Slash  = 101
    Strike = 102
    Pierce = 103
end

export ElementType, Physical, Fire, Ice, Electric, Ether
@enum ElementType::UInt8 begin
    Physical = 200
    Fire     = 201
    Ice      = 202
    Electric = 203
    Ether    = 205
end

abstract type ZzzAsset end

struct Bangboo <: ZzzAsset
    Id::Int
    Bangboo(; Id::Int) = new(Id)
end

struct Character <: ZzzAsset
    Id::Int
    Character(; Id::Int) = new(Id)
end

struct Equipment <: ZzzAsset
    Id::Int
    Equipment(; Id::Int) = new(Id)
end

struct Monster <: ZzzAsset
    Id::Int
    Monster(; Id::Int) = new(Id)
end

struct Weapon <: ZzzAsset
    Id::Int
    Weapon(; Id::Int) = new(Id)
end

# module ZZZTools
