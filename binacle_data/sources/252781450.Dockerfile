FROM nginx  
  
# MAINTAINER Pooya Parsa <pooya@pi0.ir>  
EXPOSE 80  
CMD entrypoint  
COPY app/entrypoint /bin  
  
COPY app/nginx.conf /etc/nginx/nginx.conf  
COPY app/proxy.conf /etc/nginx/proxy.conf  
COPY app/template.conf /etc/nginx/template.conf  

