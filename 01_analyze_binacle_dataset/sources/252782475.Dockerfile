FROM microsoft/aspnet:latest  
ADD . /app-cache  
WORKDIR app-cache  
RUN "dnu" "restore"  

