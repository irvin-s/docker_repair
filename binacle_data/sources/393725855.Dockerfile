FROM microsoft/dotnet:1.0.0-core
WORKDIR /app
ENTRYPOINT ["dotnet", "VSCodeDebugging.dll"]
COPY . /app
