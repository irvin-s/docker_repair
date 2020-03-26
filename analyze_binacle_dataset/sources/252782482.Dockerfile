FROM cl0sey/dotnet-mono-node-docker  
  
WORKDIR /app  
  
ADD package.json /app/package.json  
RUN npm install --production  
  
ADD bower.json /app/bower.json  
RUN bower install --allow-root  
  
ADD project*.json /app/  
RUN dotnet restore  
  
ADD . /app  
  
RUN dotnet publish --configuration Release  
  
EXPOSE 5000  
CMD ["mono", "bin/Release/net451/ubuntu.14.04-x64/publish/app.exe"]  

