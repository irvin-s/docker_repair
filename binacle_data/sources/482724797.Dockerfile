FROM thiagobarradas/magento:1.9.3.7-php7.0
MAINTAINER Embeddables Team <embeddables@mundipagg.com>

WORKDIR /app
COPY . .modman/magento
RUN wget -q --no-check-certificate -O - https://raw.github.com/colinmollenhour/modman/master/modman-installer | bash