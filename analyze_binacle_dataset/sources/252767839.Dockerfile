FROM microsoft/dotnet:2.1-sdk AS build-env  
WORKDIR /app  
  
# Copy csproj and restore as distinct layers  
COPY InfluxGateway/*.csproj ./  
RUN dotnet restore  
  
# Copy everything else and build  
COPY InfluxGateway/ ./  
RUN dotnet publish -c Release -o out  
  
# Build runtime image  
FROM microsoft/dotnet:2.1-aspnetcore-runtime-alpine  
LABEL maintainer=anthony@relle.co.uk  
  
WORKDIR /app  
COPY \--from=build-env /app/out .  
ENTRYPOINT ["dotnet", "InfluxGateway.dll"]  
  
# Set these to specify the influx instance  
ENV influx_username= influx_password= influx_url= influx_database=  

