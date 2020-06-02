FROM microsoft/dotnet:2.1.0-aspnetcore-runtime
WORKDIR /app
COPY . .
ENTRYPOINT ["dotnet", "MarginTrading.OrderHistoryBroker.dll"]
