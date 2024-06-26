#!/usr/bin/env julia
using Bonito
using WGLMakie
using DGGS
using HTTP
using URIs
using Serialization

# Pre-calculate Cell id raster
level = 10
resolution = 1024
longitudes = range(-180, 180, length=resolution * 2)
latitudes = range(-90, 90, length=resolution)
cell_ids_mat = transform_points(longitudes, latitudes, level)

WGLMakie.activate!(; resize_to=:body)

# run on every request
app = App() do request::HTTP.Request
    # request.url.query is empty, use request.target instead
    query_params = request.target |> URI |> queryparams

    dggs = query_params["path"] |> GridSystem
    plt = plot(Val(:geo), dggs[level], cell_ids_mat, longitudes, latitudes)

    DOM.div(plt, style=Styles(
        CSS("body", "margin" => "0", "padding" => "0")
    ))
end

# Need proxy see https://github.com/SimonDanisch/Bonito.jl/issues/217
server = Bonito.Server(app, "0.0.0.0", 80, proxy_url=ENV["DGGS_PROXY_URL"])

@info "Server started"
wait(server)