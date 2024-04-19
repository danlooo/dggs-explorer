using DGGS
using Serialization

# Pre-calculate Cell id raster
level = 10
resolution = 2048
longitudes = range(-180, 180, length=resolution * 2)
latitudes = range(-90, 90, length=resolution)
cell_ids_mat = transform_points(longitudes, latitudes, level)

cache = Dict(
    :level => level,
    :resolution => resolution,
    :longitudes => longitudes,
    :latitudes => latitudes,
    :cell_ids_mat => cell_ids_mat
)

serialize("cache.jl.dat", cache)