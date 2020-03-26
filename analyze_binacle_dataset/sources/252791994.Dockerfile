from node:alpine  
  
add . /reveal  
workdir /reveal  
  
expose 80  
run npm install  
cmd npm start -- --port=80  

