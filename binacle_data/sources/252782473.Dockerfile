FROM microsoft/aspnet:1.0.0-rc1-update1-coreclr  
ADD . /app-cache  
WORKDIR app-cache  
RUN "dnu" "restore"  

