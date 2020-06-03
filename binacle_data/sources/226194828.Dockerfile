# build image
FROM microsoft/aspnetcore-build:2.0 as build
WORKDIR /app

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish --output /out/ --configuration Release

# runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT [ "dotnet", "docker-tutorial.dll" ]