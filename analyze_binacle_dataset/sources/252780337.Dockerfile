FROM microsoft/aspnetcore:2.0 AS base  
WORKDIR /app  
EXPOSE 80  
FROM microsoft/aspnetcore-build:2.0 AS builder  
WORKDIR /src  
COPY ./ /src  
RUN dotnet restore  
WORKDIR /src  
RUN dotnet build -c Release -o /app  
  
FROM builder AS publish  
RUN dotnet publish -c Release -o /app  
  
FROM base AS production  
WORKDIR /app  
COPY \--from=publish /app .  
ENTRYPOINT ["dotnet", "acr-patch-sample-webapi.dll"]  

