FROM microsoft/aspnetcore:1.0.1
WORKDIR /app
COPY bin/Release/PublishOutput /app
EXPOSE 80
ENTRYPOINT ["dotnet", "IdentityManagementApi.dll"]