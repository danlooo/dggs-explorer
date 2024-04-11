using Oxygen
using HTTP
using SwaggerMarkdown

@get "/greet" function (req::HTTP.Request)
    return "hello world!"
end

serve(; port=80)