FROM microsoft/aspnetcore:2.0 AS base
WORKDIR /app
EXPOSE 80
COPY . .
ENTRYPOINT ["dotnet", "HelloWorld.Api.dll"]
  