FROM microsoft/aspnetcore:1.1.2

WORKDIR /app
COPY . .

ENTRYPOINT ["dotnet", "Todo.DemoPlugin.Web.Host.dll"]