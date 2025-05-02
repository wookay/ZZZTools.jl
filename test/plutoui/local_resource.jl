module test_plutoui_local_resource

using Test
using Markdown
using PlutoUI

@test md"" isa Markdown.MD

resource = LocalResource(@__FILE__)
@test resource isa Resource
@test startswith(resource.src, "data:text/julia;base64,")
@test resource.mime == MIME"text/julia"()
@test resource.html_attributes == ()

end # module test_plutoui_local_resource
