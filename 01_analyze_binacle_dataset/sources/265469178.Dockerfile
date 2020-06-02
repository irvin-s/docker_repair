FROM thiagobarradas/opencart:3.0.2.0-php7.1
MAINTAINER Embeddables Team <embeddables@mundipagg.com>

WORKDIR /app
COPY . .modman/opencart
RUN wget -q --no-check-certificate -O - https://raw.github.com/colinmollenhour/modman/master/modman-installer | bash

