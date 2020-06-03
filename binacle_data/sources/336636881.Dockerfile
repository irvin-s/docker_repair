FROM microsoft/aspnetcore:latest

WORKDIR /app
COPY . .

ENTRYPOINT ["dotnet", "AbpTemplate.Web.Host.dll"]
