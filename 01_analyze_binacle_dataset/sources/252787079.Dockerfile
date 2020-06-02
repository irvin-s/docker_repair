FROM microsoft/dotnet as build  
WORKDIR /docker  
RUN dotnet new mvc --name HelloMVC  
WORKDIR /docker/HelloMVC  
RUN dotnet build  
RUN dotnet publish  
  
FROM microsoft/aspnetcore  
WORKDIR /publish  
COPY \--from=build /docker/HelloMVC/bin/Debug/netcoreapp2.0/publish .  
EXPOSE 80  
CMD [ "dotnet", "HelloMVC.dll"]  

