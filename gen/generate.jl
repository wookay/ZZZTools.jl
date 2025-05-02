# generate

using ZZZTools

function generate_agent_full_names()
    agent_full_names = Dict{Int, String}()

    for sym in keys(Eridu.cached(Character))
        Id = Eridu.parseInt(sym)
        c = Character(Id = Id)
        agent = Eridu.load(c)
        partnerInfo = agent.PartnerInfo
        if haskey(partnerInfo, :FullName)
            setindex!(agent_full_names, partnerInfo.FullName, Id)
        end
    end

    contents = string("# generated\n",
        "agent_full_names = ", agent_full_names
    )
    filename = "agent_full_names.jl"
    write(normpath(@__DIR__, filename), contents)
end
