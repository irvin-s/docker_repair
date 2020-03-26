FROM devalias/composer-pcntl AS build-env  
RUN apk update && apk add bzip2-dev && docker-php-ext-install bz2  
# RUN docker-php-ext-install pcntl  
RUN git clone https://github.com/govCMS/govCMS.git && \  
cd govCMS && \  
git checkout 7.x-2.15  
  
WORKDIR /app/govCMS  
RUN composer install --prefer-dist --working-dir=build  
RUN build/bin/phing -f build/phing/build.xml build  
  
WORKDIR /app/govCMS/docroot  
CMD ["sh"]  
  
# FROM alpine  
# COPY --from=build-env /app/govCMS/docroot /govCMS  

