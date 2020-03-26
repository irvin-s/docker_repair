FROM microsoft/aspnetcore:1.1.2

WORKDIR /app
COPY . .

ENTRYPOINT ["dotnet", "Todo.MainProject.Web.Host.dll"]