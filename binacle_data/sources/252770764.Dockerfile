FROM microsoft/aspnetcore:1.0.1  
ENTRYPOINT ["dotnet", "dotnetcoreWeb.dll"]  
ARG source=publish  
WORKDIR /app  
EXPOSE 5000  
COPY $source ./  

