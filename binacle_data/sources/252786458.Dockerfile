#####################################################  
#  
#This Docker file Build the project in the subfolder,  
#File belongs to: Cornel de Lange  
#9 March 2018  
#  
##################################################  
FROM microsoft/aspnetcore-build:2.0 AS build-env  
#Copy everything in the project folders to app  
COPY . /app  
WORKDIR /app/EatFaultAPI  
  
RUN dotnet restore  
#Test this  
RUN dotnet ef migrations add InitialCreate  
RUN dotnet ef database update  
#Test end  
RUN dotnet publish -c Release -o out  
  
COPY UserIdentity.db /app/EatFaultAPI/out  
  
# Build runtime image  
FROM microsoft/aspnetcore:2.0  
WORKDIR /app/EatFaultAPI  
EXPOSE 80  
COPY --from=build-env /app/EatFaultAPI/out .  
ENTRYPOINT ["dotnet", "EatFaultAPI.dll"]  
####################################################

