FROM phpmyadmin/phpmyadmin:4.7

RUN apk update && apk upgrade && \
    apk add --no-cache curl

RUN curl https://files.phpmyadmin.net/themes/fallen/0.5/fallen-0.5.zip --output /www/themes/fallen.zip && \
    unzip /www/themes/fallen.zip -d /www/themes && \
    rm /www/themes/fallen.zip