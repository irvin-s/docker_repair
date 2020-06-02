FROM microsoft/dotnet:latest  
  
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -  
RUN apt-get install -y nodejs  
  
COPY . /app  
WORKDIR /app/src/PhotoGallery  
  
RUN npm install -g bower gulp typescript typings tsd \  
&& npm install \  
&& typings install \  
&& bower install --allow-root \  
&& gulp build-spa \  
&& dotnet restore  
  
EXPOSE 5000  
ENV ASPNETCORE_URLS http://*:5000  
ENTRYPOINT ["dotnet", "run"]

