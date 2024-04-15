using Oxygen
using HTTP
using SwaggerMarkdown

@get "/greet" function (req::HTTP.Request)
    return "hello world!"
end

serve(; host="0.0.0.0", port=80)
