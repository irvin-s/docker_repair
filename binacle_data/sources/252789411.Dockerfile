FROM microsoft/dotnet:1.0-sdk-projectjson  
  
COPY TREmberDeployable/project.json /app/  
  
WORKDIR /app  
  
RUN ["dotnet", "restore"]  
  
COPY TREmberDeployable /app  
  
EXPOSE 5000  
ENTRYPOINT ["dotnet", "run"]  

