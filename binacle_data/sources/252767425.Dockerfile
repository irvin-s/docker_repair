# imagen de la que inicio  
FROM node:slim  
  
# Carpeta de la app  
WORKDIR /miapp  
  
#copia los archivos a la carpeta creada anteriormente  
ADD . /miapp  
  
#Paquetes necesarios  
RUN npm install  
  
#Puerto que expongo  
EXPOSE 3000  
# Ejecuta comando de inicio  
CMD ["npm", "start"]  

