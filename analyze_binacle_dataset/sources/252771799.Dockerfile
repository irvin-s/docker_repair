#----------------------------------------------  
# CONTAINER DE BUILD  
#----------------------------------------------  
FROM microsoft/aspnetcore-build:2.0 AS build  
COPY . .  
WORKDIR src/Ativa.API  
RUN dotnet build -c Release -o /app  
  
#----------------------------------------------  
# CONTAINER DE PUBLISH  
#----------------------------------------------  
FROM build AS publish  
RUN dotnet publish -c Release -o /app  
  
#----------------------------------------------  
# CONTAINER BASE DA IMAGEM  
#----------------------------------------------  
FROM microsoft/aspnetcore:2.0  
WORKDIR /app  
EXPOSE 80  
COPY \--from=publish /app .  
ENTRYPOINT ["dotnet", "Ativa.API.dll"]  

