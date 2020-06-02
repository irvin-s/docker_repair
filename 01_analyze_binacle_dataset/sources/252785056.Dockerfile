FROM microsoft/aspnetcore:1.1.0  
MAINTAINER codeyu  
  
# Set ASP.NET Core environment variables  
ENV ASPNETCORE_URLS="http://*:6000"  
ENV ASPNETCORE_ENVIRONMENT="Production"  
# Copy files to app directory  
COPY /release /app  
  
# Set working directory  
WORKDIR /app  
  
# Open port  
EXPOSE 6000/tcp  
  
# Run  
ENTRYPOINT ["dotnet", "SportsStore.dll"]

