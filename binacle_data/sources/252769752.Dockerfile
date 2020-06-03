FROM microsoft/dotnet:2.0-sdk AS builder  
  
RUN mkdir -p /root/src/app/amimedia  
WORKDIR /root/src/app/amimedia  
  
COPY AmiMedia.csproj .  
COPY nuget.config .  
COPY Directory.Build.props .  
RUN dotnet restore ./AmiMedia.csproj  
  
COPY . .  
RUN dotnet publish -c Release -o published -r linux-x64  
  
FROM microsoft/dotnet:2.0.0-runtime-deps  
  
WORKDIR /app  
COPY \--from=builder /root/src/app/amimedia/published .  
  
ENV ASPNETCORE_ENVIRONMENT Docker  
ENV ASPNETCORE_URLS=http://+:3001  
EXPOSE 3001  
CMD [ "./AmiMedia" ]  

