FROM microsoft/dotnet:2.0-sdk AS builder  
  
RUN mkdir -p /root/src/app/amiidentitydev  
WORKDIR /root/src/app/amiidentitydev  
  
COPY AmiIdentityDev.csproj .  
RUN dotnet restore ./AmiIdentityDev.csproj  
  
COPY . .  
RUN dotnet publish -c Release -o published -r linux-x64  
  
FROM microsoft/dotnet:2.0.0-runtime-deps  
  
WORKDIR /app  
COPY \--from=builder /root/src/app/amiidentitydev/published .  
  
ENV ASPNETCORE_ENVIRONMENT Docker  
ENV ASPNETCORE_URLS=http://+:7000  
EXPOSE 7000  
CMD [ "./AmiIdentityDev" ]  

