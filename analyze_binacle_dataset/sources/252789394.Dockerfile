FROM microsoft/aspnetcore-build AS build  
  
WORKDIR /Docker  
  
COPY . .  
  
RUN dotnet restore  
  
RUN dotnet publish --output /output --configuration Release  
  
FROM microsoft/aspnetcore  
  
WORKDIR /app  
  
COPY \--from=build /output .  
  
ENTRYPOINT [ "dotnet", "Docker.dll" ]  

