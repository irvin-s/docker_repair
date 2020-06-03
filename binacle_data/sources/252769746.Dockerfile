FROM armlfs/php  
COPY . .  
RUN composer install  
CMD exec tini php artisan serve --host=0.0.0.0 --port=80  

