FROM swaggerapi/swagger-codegen-cli  
ADD drone-entrypoint.sh /bin/  
ENTRYPOINT /bin/drone-entrypoint.sh  

