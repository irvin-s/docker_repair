#FROM microsoft/aspnetcore:2.0  
#ARG source  
#WORKDIR /app  
#EXPOSE 80  
#COPY ${source:-obj/Docker/publish} .  
#ENTRYPOINT ["dotnet", "QuerieSystemAPI.dll"]  
#################################################  
FROM microsoft/aspnetcore-build:2.0 AS build-env  
WORKDIR /app  
# Copy csproj and restore as distinct layers  
COPY *.csproj ./  
RUN dotnet restore  
# Copy everything else and build  
COPY . ./  
RUN dotnet publish -c Release -o out  
# Build runtime image  
FROM microsoft/aspnetcore:2.0  
WORKDIR /app  
#Added this to help docker cloud expose .  
EXPOSE 80  
COPY --from=build-env /app/out .  
ENTRYPOINT ["dotnet", "QuerieSystemAPI.dll"]  
####################################################

