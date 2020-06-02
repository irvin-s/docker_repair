FROM cmc333333/processing:3.1.1  
COPY [".", "/app/src/VisualDJTube/"]  
WORKDIR /app/src/  
  
CMD ["--sketch=VisualDJTube", "--run"]  

