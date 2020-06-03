FROM php:7.1.4-apache  
  
# 1) On active le mod php pour virer les ".php" en fin d'url  
RUN a2enmod rewrite  
  
# 2) On installe wget  
RUN apt-get update && apt-get -y install wget git  
  
# 3) On balances les sources dans le container  
COPY . /var/www/html/  
  
# 4) On change le dossier courant  
WORKDIR /var/www/html/  
  
# 5) On choppe composer version 1.4.2 et on installe les libraries  
RUN wget https://getcomposer.org/download/1.4.2/composer.phar  
RUN php composer.phar install  
  
# 6) On fout mysql machin  
RUN docker-php-ext-install pdo pdo_mysql  

