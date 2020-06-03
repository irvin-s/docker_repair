FROM microsoft/dotnet:2.1-sdk
WORKDIR /app
CMD ["dotnet", "Game.Engine.dll"]
COPY . /app
