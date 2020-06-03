FROM microsoft/dotnet:2.1.0-aspnetcore-runtime
WORKDIR app/
COPY . .
EXPOSE 5040
ENTRYPOINT ["dotnet", "Lykke.Service.ExchangeConnector.dll"]
