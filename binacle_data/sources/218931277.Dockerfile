FROM ubuntu

ADD zurmo /zurmo/zurmo
ADD index.php /zurmo/index.php

RUN chown -R www-data /zurmo

VOLUME /zurmo
