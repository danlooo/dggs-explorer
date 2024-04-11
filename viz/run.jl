#!/usr/bin/env julia
using Bonito
using WGLMakie
using DGGS
using HTTP
using URIs
using Serialization

WGLMakie.activate!(; resize_to=:body)

# run on every request
app = App() do request::HTTP.Request
    # request.url.query is empty, use request.target instead
    query_params = request.target |> URI |> queryparams

    dggs = query_params["path"] |> GridSystem
    plt = plot(dggs)

    DOM.div(plt, style=Styles(
        CSS("body", "margin" => "0", "padding" => "0")
    ))
end

# Need proxy see https://github.com/SimonDanisch/Bonito.jl/issues/217
server = Bonito.Server(app, "0.0.0.0", 80, proxy_url=ENV["DGGS_PROXY_URL"])

@info "Server started"
wait(server)
