
FROM microsoft/aspnetcore

WORKDIR /app

COPY . /app

EXPOSE 5061

ENTRYPOINT ["dotnet", "GB28181.Service.dll"]
