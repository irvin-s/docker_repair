# build image
FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /app

COPY . .
RUN dotnet restore WebSubClient/WebSubClient.csproj

COPY . .
RUN dotnet publish WebSubClient/WebSubClient.csproj --output /out/ --configuration Release

# runtime image
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build /out .
ENV ASPNETCORE_ENVIRONMENT=Docker
ENTRYPOINT [ "dotnet", "WebSubClient.dll" ]

EXPOSE 80
