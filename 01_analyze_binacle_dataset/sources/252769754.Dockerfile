FROM microsoft/dotnet:2.0-sdk AS builder  
  
RUN mkdir -p /root/src/app/amiweb  
WORKDIR /root/src/app/amiweb  
  
COPY AmiWeb.csproj .  
COPY Directory.Build.props .  
COPY nuget.config .  
RUN dotnet restore ./AmiWeb.csproj  
  
COPY . .  
RUN dotnet publish -c Release -o published -r linux-x64  
  
FROM microsoft/dotnet:2.0.0-runtime-deps  
  
WORKDIR /app  
COPY \--from=builder /root/src/app/amiweb/published .  
RUN mkdir videos  
  
ENV ASPNETCORE_ENVIRONMENT Docker  
ENV ASPNETCORE_URLS=http://+:5000  
EXPOSE 5000  
CMD [ "./AmiWeb" ]  

