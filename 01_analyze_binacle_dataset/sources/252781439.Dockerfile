FROM microsoft/dotnet  
  
RUN mkdir -p /dotnetapp  
COPY . /dotnetapp  
  
WORKDIR /dotnetapp  
RUN dotnet restore  
  
WORKDIR /dotnetapp/src/NetExpress  
  
ENTRYPOINT ["dotnet", "run", "--urls", "http://*:5000"]  
  

