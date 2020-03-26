# Build SDK image
FROM microsoft/dotnet:2.2-sdk AS build-env
WORKDIR /app

COPY *.sln .
COPY ./src ./src
COPY ./tests ./tests
RUN dotnet restore
RUN dotnet publish ./src/WebSite/WebSite.csproj -c Release -o ./out

# Build runtime image
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/src/WebSite/out .
ENTRYPOINT ["dotnet", "WebSite.dll"]