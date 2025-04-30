module test_zzztools_eridu

using Test
using ZZZTools
using .Eridu: ZzzQuery

query = ZzzQuery{Character}(AND())
@test query isa ZzzQuery{Character}
@test query.logical isa AND

end # module test_zzztools_eridu
