# De qué imagen parte el Dockerfile  
# La descargamos ayer (por defecto busca la que tiene la etiqueta latest)  
FROM node  
# Carpeta raiz donde queramos que vaya la aplicación en el contenedor  
WORKDIR /apitechu  
# Copia de archivos de la carpeta local a la de trabajo del contenedor  
# cuando esté corriendo  
ADD . /apitechu  
# Instalo los paquetes necesarios a partir del package.json  
# Con esto y con lo del .dockerignore hago paquetes más pequeños  
RUN npm install  
# Volumnen de la imagen, al ejecutar le decimos en que carpeta del host mapea  
VOLUME ["/logs"]  
# Qué puerto abre la imagen Docker (recordemos que es 3000)  
EXPOSE 3000  
# Comando que va a ejecutar cuando arranque el contenedor (npm start)  
CMD ["npm", "start"]  

