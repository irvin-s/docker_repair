FROM microsoft/dotnet:1.1.2-sdk-jessie  
COPY /myapp /myapp  
RUN dotnet restore ./myapp && \  
dotnet build -c release ./myapp && \  
dotnet publish -c release -o pubdir ./myapp  
ENV ASPNETCORE_URLS http://+:80  
ENTRYPOINT ["dotnet", "/myapp/pubdir/myapp.dll"]  
EXPOSE 80  

