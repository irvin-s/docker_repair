#####################################################  
#  
#This Docker file lets two projects(dependency) build,  
#all thanks to dotnet core coolness  
#File belongs to: Cornel de Lange  
#28 Feb 2018  
#  
#################################################  
FROM microsoft/aspnetcore-build:2.0 AS build-env  
#Copy everything in the twin project folders to app  
#not sure yet why I have to use a folder called app  
COPY . /app  
WORKDIR /app/FaultAPI  
#The 2 project are connected in the FaultAPI.csproj file  
#FaultAPI declares the dependency there for FaultsRepo  
#Dotnet Core does its build magic from there from FaultsAPI.dll  
RUN dotnet restore  
RUN dotnet publish -c Release -o out  
  
# Build runtime image  
FROM microsoft/aspnetcore:2.0  
WORKDIR /app/FaultAPI  
EXPOSE 80  
COPY --from=build-env /app/FaultAPI/out .  
ENTRYPOINT ["dotnet", "FaultAPI.dll"]  
####################################################

