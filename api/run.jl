using Oxygen
using HTTP
using URIs
using SwaggerMarkdown
using DGGS
using WGLMakie
using ColorSchemes
using FileIO

@get "/cell/{lon}/{lat}/{level}" function (req::HTTP.Request, lon::Float64, lat::Float64, level::Int)
    return DGGS._transform_points(lon, lat, level)[1, 1]
end

@get "/coordinate/{q2di_n}/{q2di_i}/{q2di_j}/{level}" function (req::HTTP.Request, q2di_n::Float64, q2di_i::Float64, q2di_j::Int, level::Int)
    coord = DGGS.transform_points([Q2DI(q2di_n, q2di_i, q2di_j)], level)[1]
    return Dict(:lat => coord[2], :lon => coord[1])
end

@get "/collections/{path}/{level}/map" function (req::HTTP.Request, path::String, level::Int)
    cell_cube = GridSystem(unescapeuri(path))[level]

    cell_cube.data |> axes |> length == 3 || return HTTP.Response(500, "Data cube must contain only spatial DGGS dimensions")

    longitudes = range(-180, 180, length=1024)
    latitudes = range(-90, 90, length=512)
    cell_ids_mat = transform_points(longitudes, latitudes, cell_cube.level)
    geo_cube = GeoCube(cell_cube; longitudes, latitudes, cell_ids_mat)

    color_scale = ColorScale(ColorSchemes.viridis, 0, 1)
    image = map(x -> DGGS.color_value(x, color_scale), geo_cube.data.data[1:length(longitudes), length(latitudes):-1:1]')

    io = IOBuffer()
    save(Stream(format"PNG", io), image)

    response_headers = [
        "Content-Type" => "image/png",
        # "cache-control" => "max-age=23117, stale-while-revalidate=604800, stale-if-error=604800"
    ]
    response = HTTP.Response(200, response_headers, io.data)
    return response
end

serve(; host="0.0.0.0", port=80)