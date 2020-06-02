FROM microsoft/aspnet:1.0.0-rc1-update1  
ADD /src /app  
WORKDIR /app  
RUN ["dnu", "restore"]  
EXPOSE 5004  
ENTRYPOINT sleep 10000000 | dnx . kestrel  

