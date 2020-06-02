FROM node:6  
  
RUN npm install -g swagger2aglio && \  
npm install -g jayschema && \  
npm install -g swagger-cli && \  
npm install -g swagger-tools && \  
npm install -g ajv-cli && \  
npm install -g swagger-schema-official && \  
npm install -g json-refs && \  
npm install -g swagger-manage-extensions  
  
RUN mkdir /app/  
RUN mkdir /app/indir/  
RUN mkdir /app/outdir/  
  
COPY . /app  
  
#No entrypoint - invoke required utility directly  

