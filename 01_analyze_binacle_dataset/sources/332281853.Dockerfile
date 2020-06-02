FROM microsoft/dotnet:2.1-sdk
COPY . ./
RUN ["dotnet", "publish", "-c", "Release"]
WORKDIR ./bin/Release/netcoreapp2.1/publish

CMD ["dotnet", "Game.Registry.dll"]
