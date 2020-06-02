FROM microsoft/aspnetcore-build:2.0.0-nanoserver AS Build  
  
WORKDIR /app  
  
COPY . .  
  
RUN dotnet publish -c Release -o /release ./SreBot/SreBot.csproj  
  
FROM microsoft/aspnetcore:2.0.0-nanoserver  
WORKDIR /app  
  
ENV ASPNETCORE_URLS http://+:80  
EXPOSE 80  
COPY \--from=Build /release .  
  
ENTRYPOINT ["dotnet", "SreBot.dll"]

