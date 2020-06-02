FROM microsoft/aspnetcore-build:2.0 AS build-env
WORKDIR /app

# Copiar csproj e restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Build da aplicacao
COPY . ./
RUN dotnet publish -c Release -o out

# Build da imagem
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SiteHeroisMarvel.dll"]