FROM nginx  
  
# copy nginx config to the container image  
ADD ./conf/django.conf /etc/nginx/conf.d/  
# Set the timezone  
RUN echo "Asia/Tokyo" > /etc/timezone  
RUN dpkg-reconfigure -f noninteractive tzdata  
# for kubernetes  
RUN mkdir /src  

