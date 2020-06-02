FROM microsoft/aspnetcore-build AS builder  
  
WORKDIR /source  
  
# caches restore result by copying csproj file separately  
COPY *.csproj .  
RUN dotnet restore  
  
# copies the rest of your code  
COPY . .  
  
RUN dotnet publish --output /app/  
  
FROM microsoft/aspnetcore  
WORKDIR /app  
COPY \--from=builder /app .  
ENTRYPOINT ["dotnet", "WebMail.dll"]

