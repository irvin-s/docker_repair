FROM microsoft/dotnet:1.1.1-runtime  
MAINTAINER Eduardo Sousa <ecsousa@gmail.com>  
  
RUN mkdir -p /dotnetapp  
  
COPY ./run.sh /  
  
WORKDIR /dotnetapp  
  
ENTRYPOINT /run.sh  
  
ONBUILD COPY . /dotnetapp  

