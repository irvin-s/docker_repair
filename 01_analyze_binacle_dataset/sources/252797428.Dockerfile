FROM cmc333333/processing:3.1.1  
COPY [".", "/app/src/ImageEditor/"]  
WORKDIR /app/src/  
  
CMD ["--sketch=ImageEditor", "--run"]  

