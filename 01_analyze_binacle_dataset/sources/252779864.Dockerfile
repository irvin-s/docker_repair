FROM microsoft/dotnet:2.0-sdk  
EXPOSE 5000 80  
RUN ls  
WORKDIR /fitlight_server  
RUN ls  
COPY fitlight_server.csproj .  
RUN dotnet restore  
COPY . .  
RUN ls  
RUN dotnet publish -c Release -o out  
ENTRYPOINT ["dotnet", "out/fitlight_server.dll"]  

