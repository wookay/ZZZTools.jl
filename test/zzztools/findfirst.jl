module test_zzztools_eridu_findfirst

using Test
using ZZZTools

expr = :( c::Character -> c.EN == "Anby" )
agent = Eridu.findfirst(expr)
@test agent == Character(Id = 1011)

expr = :( c::Character -> c.EN == "Venti" )
@test Eridu.findfirst(expr) === nothing

end # module test_zzztools_eridu_findfirst
