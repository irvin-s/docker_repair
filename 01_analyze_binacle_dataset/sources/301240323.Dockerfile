FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY . .
ENTRYPOINT ["dotnet", "MarginTrading.Client.dll"]
