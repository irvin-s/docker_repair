#imagen base  
FROM node:latest  
  
# Directorio de la app  
WORKDIR /app  
  
#copio archivos, puedes poner tambien copy.  
ADD . /app  
  
#Dependencias  
RUN npm install  
RUN apt-get update  
RUN apt-get install -y vim  
  
#Puerto  
EXPOSE 3000  
#comando (npm start o run start)  
CMD ["npm", "start"]  

