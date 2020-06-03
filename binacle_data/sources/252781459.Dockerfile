FROM iojs  
  
WORKDIR /src  
  
COPY ./auth_utils /auth/utils  
COPY ./ /src  
  
RUN npm install  
  
EXPOSE 3000  
ENV ACCOUNTIP 10.132.89.72:31007  
ENV DEBUG accountinfo  
  
CMD node --es_staging --harmony_arrow_functions bin/www  

