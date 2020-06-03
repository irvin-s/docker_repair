##plantilla que se toma como base  
FROM node:boron  
##directorio base para cargar el contenedor  
WORKDIR /myapp  
##copia el contenido actual en el directorio  
ADD . /myapp  
##paquetes necesarios  
RUN npm install  
##puerto que expongo  
EXPOSE 3000  
##comandos de inicio  
CMD ["npm","start"]  

