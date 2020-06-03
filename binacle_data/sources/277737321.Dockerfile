FROM microsoft/dotnet:2.0-sdk-jessie AS builder

WORKDIR /src/DockerSamples.WebApplicationFirewall.App
COPY src/DockerSamples.WebApplicationFirewall.App/DockerSamples.WebApplicationFirewall.App.csproj .
RUN dotnet restore

COPY src/ /src
RUN dotnet publish

# app image
FROM microsoft/dotnet:2.0-runtime-jessie

EXPOSE 80
ENV Proxy:ListenPort="80" \
    Proxy:TargetServer="web-app" \
    Proxy:TargetPort="80"

WORKDIR /dotnetapp  
CMD ["dotnet", "DockerSamples.WebApplicationFirewall.App.dll"]  

COPY --from=builder /src/DockerSamples.WebApplicationFirewall.App/bin/Debug/netcoreapp2.0/publish .

