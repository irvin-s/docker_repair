# Builder image
FROM microsoft/aspnetcore-build:2.0-jessie AS builder

# Make a cached layer for Nuget packages
WORKDIR /vue-template
COPY src/vue-template.csproj .
RUN dotnet restore

# Make use of Docker layering: new layer
COPY src/ .
RUN ls -lhaF

# Let .NET CLI install NPM packages, otherwise version mismatches will occur
RUN dotnet publish -c Release -o out


# Runtime image
FROM microsoft/aspnetcore:2.0-jessie

LABEL maintainer "Phil Hawkins"

WORKDIR /vue-template
COPY --from=builder /vue-template/out/ .

ENTRYPOINT ["dotnet", "/vue-template/vue-template.dll"]
