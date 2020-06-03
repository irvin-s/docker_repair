FROM microsoft/aspnetcore

WORKDIR /list

COPY . /list

ENTRYPOINT ["dotnet", "LisAPI.dll"]