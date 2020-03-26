FROM caseyfw/php  
WORKDIR /web  
COPY composer.lock ./  
COPY composer.json ./  
RUN composer install  
COPY . ./  

