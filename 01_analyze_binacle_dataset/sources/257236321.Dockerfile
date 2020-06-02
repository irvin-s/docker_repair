FROM microsoft/dotnet:2.2-sdk AS build
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y nodejs build-essential
WORKDIR /src
COPY CollAction/CollAction.csproj CollAction/
RUN dotnet restore CollAction/CollAction.csproj
COPY . .
WORKDIR /src/CollAction
RUN npm install # Needed because the project npm install in production mode won't install the devDependencies (webpack etc.)
RUN NODE_ENV=production dotnet build CollAction.csproj --no-restore -c Release -o /app
RUN dotnet publish CollAction.csproj --no-build -c Release -o /app

FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "CollAction.dll"]
