# Imagen base  
FROM node:latest  
  
# Directorio de la app  
WORKDIR /apitechu  
  
# Copia de archivos desde el directorio actual a destino ("/apitechu")  
ADD . /apitechu  
  
# Dependencias  
RUN npm install  
  
# Puerto expuesto por el contenedor  
EXPOSE 3000  
# Comando de inicio  
CMD ["npm", "start"]  

