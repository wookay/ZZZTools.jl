# module ZZZTools

function Base.show(io::IO, asset::T) where T <: ZzzAsset
    print(io, nameof(T))
    print(io, "(Id = ", asset.Id, ")")
end

function Base.show(io::IO, mime::MIME"text/plain", c::Character)
    T = typeof(c)
    print(io, nameof(T))
    print(io, "(Id = ", c.Id)
    if c.Id > 0
        print(io, ", ")
        agent = Eridu.cached(T)[Symbol(c.Id)]
        print(io, agent.EN)
        print(io, ": ")
        print(io, WeaponType(agent.type))
        print(io, " ")
        Base.show(io, mime, ElementType(agent.element))
        print(io, " ")
        print(io, HitType(agent.hit))
    end
    print(io, ")")
end

function Base.show(io::IO, mime::MIME"text/plain", weapon::Weapon)
    T = typeof(weapon)
    print(io, nameof(T))
    print(io, "(Id = ", weapon.Id)
    if weapon.Id > 0
        print(io, ", ")
        w = Eridu.cached(T)[Symbol(weapon.Id)]
        print(io, w.EN)
        print(io, ": ")
        print(io, WeaponType(w.type))
    end
    print(io, ")")
end

function Base.show(io::IO, mime::MIME"text/plain", equipment::Equipment)
    T = typeof(equipment)
    print(io, nameof(T))
    print(io, "(Id = ", equipment.Id)
    if equipment.Id > 0
        print(io, ", ")
        a = Eridu.cached(T)[Symbol(equipment.Id)]
        print(io, a.EN.name)
    end
    print(io, ")")
end

function Base.show(io::IO, mime::MIME"text/plain", asset::ZzzAsset)
    T = typeof(asset)
    print(io, nameof(T))
    print(io, "(Id = ", asset.Id)
    if asset.Id > 0
        print(io, ", ")
        a = Eridu.cached(T)[Symbol(asset.Id)]
        print(io, a.EN)
    end
    print(io, ")")
end

function Base.show(io::IO, mime::MIME"text/plain", element::ElementType)
    if Physical === element
        printstyled(io, element, color = :light_yellow)
    elseif Fire === element
        printstyled(io, element, color = :light_red)
    elseif Ice === element
        printstyled(io, element, color = :light_cyan)
    elseif Electric === element
        printstyled(io, element, color = 33)
    elseif Ether === element
        printstyled(io, element, color = :light_magenta)
    else
        print(io, element)
    end
end

# module ZZZTools
