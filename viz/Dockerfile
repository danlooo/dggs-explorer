FROM julia:1.10.0

WORKDIR /work
COPY Project.toml .
COPY Manifest.toml .
RUN julia --project="." --threads auto -e "import Pkg; Pkg.instantiate()"
COPY run.jl .

ENV DGGS_PROXY_URL="http://localhost:80"

EXPOSE 80
CMD julia --project="."  --threads auto run.jl