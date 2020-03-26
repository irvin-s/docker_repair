FROM microsoft/dotnet:2.1-sdk AS build  
WORKDIR /app  
  
COPY *.sln .  
COPY EventHubsMirror/*.csproj ./EventHubsMirror/  
RUN dotnet restore  
  
COPY . .  
WORKDIR /app/EventHubsMirror  
RUN dotnet publish -c Release -o out  
  
FROM microsoft/dotnet:2.1-runtime AS runtime  
WORKDIR /app  
COPY \--from=build /app/EventHubsMirror/out ./  
ENTRYPOINT ["dotnet", "EventHubsMirror.dll"]  

