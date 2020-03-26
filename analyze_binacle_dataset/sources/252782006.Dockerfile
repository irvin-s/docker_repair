FROM microsoft/dotnet:1.1.2-runtime  
  
MAINTAINER chsword  
ENV ASPNETCORE_URLS http://*:80  
ENV ASPNETCORE_ENVIRONMENT Development  
ENV PORT 80  
WORKDIR /app  
COPY out .  
ENTRYPOINT ["dotnet", "random-avatar.dll"]

