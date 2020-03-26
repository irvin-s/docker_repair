FROM debian:jessie

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    mysql-client \
    adduser \
    php5-cli \
    php5-mysql \
    php5-curl

# installation nginx
RUN mkdir -p /usr/share/nginx/www/jeedom

WORKDIR /usr/share/nginx/www/jeedom

# téléchargement de l'archive

RUN wget --no-check-certificate -O jeedom.zip https://github.com/jeedom/core/archive/master.zip && unzip jeedom.zip
RUN mv core-master/* .

# ajout au préalable d'un dossier tmp
RUN mkdir -p ./tmp

# définition des droits utilisateur/groupes/autres de manière récursif
RUN chmod 755 -R /usr/share/nginx/www/jeedom

# délégation des droits pour l'utilisateur www-data de manière récursif
RUN chown -R www-data:www-data /usr/share/nginx/www/jeedom

# ajout de l'utilisateur www-data au group dialout (pour piloter la connexion 3G éventuelle)
RUN adduser www-data dialout

# on copie le fichier de configuration d'exemple 
RUN cp ./core/config/common.config.sample.php ./core/config/common.config.php

VOLUME /usr/share/nginx/www/jeedom/

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]



