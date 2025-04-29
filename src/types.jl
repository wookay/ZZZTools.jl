# module ZZZTools

export WeaponType, Attack, Stun, Anomaly, Support, Defense
@enum WeaponType begin
    Attack  = 1
    Stun    = 2
    Anomaly = 3
    Support = 4
    Defense = 5
end

export HitType, Slash, Strike, Pierce
@enum HitType begin
    Slash  = 101
    Strike = 102
    Pierce = 103
end

export ElementType, Physical, Fire, Ice, Electric, Ether
@enum ElementType begin
    Physical = 200
    Fire     = 201
    Ice      = 202
    Electric = 203
    Ether    = 205
end

struct Bangboo
    Id::Int
    Bangboo(; Id::Int) = new(Id)
end

struct Character
    Id::Int
    Character(; Id::Int) = new(Id)
end

struct Equipment
    Id::Int
    Equipment(; Id::Int) = new(Id)
end

struct Monster
    Id::Int
    Monster(; Id::Int) = new(Id)
end

struct Weapon
    Id::Int
    Weapon(; Id::Int) = new(Id)
end

# module ZZZTools
