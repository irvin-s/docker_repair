FROM microsoft/dotnet:2.0.0

WORKDIR /list

COPY /list .

ENTRYPOINT ["dotnet", "lisapi.dll"]