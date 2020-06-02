FROM microsoft/aspnetcore
WORKDIR /app
COPY src/WebApi/bin/Release/netcoreapp1.1/publish/ .
ENTRYPOINT ["dotnet", "WebApi.dll"]