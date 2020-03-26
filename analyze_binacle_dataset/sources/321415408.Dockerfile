# build image
FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /app

COPY . .
RUN dotnet restore Hub/Hub.csproj

COPY . .
RUN dotnet publish Hub/Hub.csproj --output /out/ --configuration Release

# runtime image
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT [ "dotnet", "Hub.dll" ]

EXPOSE 80
