FROM microsoft/aspnetcore:1.1.2

WORKDIR /app
COPY . .

ENTRYPOINT ["dotnet", "MicroServices.Web.Host.dll"]