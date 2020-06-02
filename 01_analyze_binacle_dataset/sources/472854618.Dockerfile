FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /app
EXPOSE 5000
COPY ${source:-obj/Docker/publish} .
ENTRYPOINT ["dotnet", "QuickstartIdentityServer.dll"]