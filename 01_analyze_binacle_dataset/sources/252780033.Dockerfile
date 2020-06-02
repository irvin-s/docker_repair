FROM nginx:1.13.8-alpine  
ENV PAGE_TITLE=ReDoc  
ENV SPEC_URL=swagger.yaml  
ENV REDOC_OPTIONS=  
COPY run.sh /run.sh  
CMD ["/run.sh"]  
COPY . /usr/share/nginx/html/  

