# module ZZZTools

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

using Markdown         # @md_str
using HypertextLiteral # @htl
using PlutoUI          # LocalResource Resource

# genshin-optimizer
# https://github.com/frzyc/genshin-optimizer
function get_character_interknot(name::String)::Union{Nothing, Resource}
    path = normpath(@__DIR__, "../gen/genshin-optimizer/libs/zzz/assets/src/gen/chars/$name/interknot.png")
    if isfile(path)
        return LocalResource(path, :width => 20, :height => 20, :title => name)
    else
        return nothing
    end
end

function Base.show(io::IO, mime::MIME"text/html", c::Character)
    Base.show(io, mime, @htl("""<div>"""))
    T = Character
    agent = Eridu.cached(T)[Symbol(c.Id)]
    resource = get_character_interknot(agent.EN)
    if resource isa Resource
        Base.show(io, mime, resource)
        Base.show(io, mime, md"")
    end
    Base.show(io, MIME"text/plain"(), c)
    Base.show(io, mime, @htl("""</div>"""))
end

# module ZZZTools
