FROM cmc333333/processing:2.2.1  
COPY [".", "/app/src/FieldGoal/"]  
WORKDIR /app/src/  
  
CMD ["--sketch=FieldGoal", "--output=/tmp/fg", "--run"]  

