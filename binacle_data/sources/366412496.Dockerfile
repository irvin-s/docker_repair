FROM microsoft/aspnetcore:1.1.2

WORKDIR /app
COPY . .

ENTRYPOINT ["dotnet", "AbpODataDemo.Web.Host.dll"]
