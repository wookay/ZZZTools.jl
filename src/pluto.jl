# module ZZZTools

"""
genshin-optimizer

https://github.com/frzyc/genshin-optimizer
"""
module GO # ZZZTools

using PlutoUI          # LocalResource Resource

function _get_local_resource(subpath::String, title::String)::Union{Nothing, Resource}
    path = normpath(@__DIR__, "../gen/genshin-optimizer/libs/zzz/assets/src/gen/$(subpath)")
    if isfile(path)
        return LocalResource(path, :width => 20, :height => 20, :title => title)
    else
        return nothing
    end
end

function get_chars_interknot(dir_name::String, title::String)::Union{Nothing, Resource}
    subpath = "chars/$(dir_name)/interknot.png"
    _get_local_resource(subpath, title)
end

function get_discs_circle(dir_name::String, title::String)::Union{Nothing, Resource}
    subpath = "discs/$(dir_name)/circle.png"
    _get_local_resource(subpath, title)
end

function get_wengines_big(dir_name::String, title::String)::Union{Nothing, Resource}
    subpath = "wengines/$(dir_name)/big.png"
    _get_local_resource(subpath, title)
end

end # module ZZZTools.GO


using Markdown         # @md_str
using HypertextLiteral # @htl
using PlutoUI          # Resource

function _show_html_asset(io::IO, mime::MIME"text/html", asset::T, resource::Union{Nothing, Resource}) where {T <: ZzzAsset}
    Base.show(io, mime, @htl("""<div>"""))
    if resource isa Resource
        Base.show(io, mime, resource)
        Base.show(io, mime, md"")
    end
    Base.show(io, MIME"text/plain"(), asset)
    Base.show(io, mime, @htl("""</div>"""))
end

function Base.show(io::IO, mime::MIME"text/html", c::Character)
    T = Character
    agent = Eridu.cached(T)[Symbol(c.Id)]
    title = agent.EN
    dir_name = agent.EN
    resource = GO.get_chars_interknot(dir_name, title)
    _show_html_asset(io, mime, c, resource)
end

function Base.show(io::IO, mime::MIME"text/html", equipment::Equipment)
    T = Equipment
    disc = Eridu.cached(T)[Symbol(equipment.Id)]
    title = disk.EN.name
    dir_name = replace(title, " " => "")
    resource = GO.get_discs_circle(dir_name, title)
    _show_html_asset(io, mime, c, resource)
end

function Base.show(io::IO, mime::MIME"text/html", weapon::Weapon)
    T = Weapon
    wengine = Eridu.cached(T)[Symbol(weapon.Id)]
    title = wengine.EN
    Empty = ""
    dir_name = replace(title, " " => Empty, "[" => Empty, "]" => Empty)
    resource = GO.get_wengines_big(dir_name, title)
    _show_html_asset(io, mime, weapon, resource)
end

# module ZZZTools
