FROM cl0sey/dotnet-mono-node-docker:1.0-sdk  
  
WORKDIR /app  
  
# This Dockerfile is optimised to reduce layer size  
# If you want to cache the package restore, uncomment the following:  
#  
# ADD project*.json /app/  
# RUN dotnet restore  
ADD . /app  
  
RUN dotnet restore \  
&& dotnet publish --configuration Release -o /publish \  
&& rm -Rf /app \  
&& rm -Rf ~/.nuget \  
&& rm -Rf ~/.local/share/NuGet  
  
EXPOSE 5000  
WORKDIR /publish  
  
CMD ["mono", "app.exe"]  

