FROM caseyfw/php  
COPY . /code/web  
ENV cacheDir /cache  
RUN mkdir /cache && chown apache:apache /cache  

