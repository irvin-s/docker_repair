
#FROM microsoft/dotnet:aspnetcore-runtime
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /root/  
COPY win10-x64/ ./
#COPY win10-x64/wwwroot ./wwwroot
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000/tcp
CMD ["StankinsData.exe"]  
