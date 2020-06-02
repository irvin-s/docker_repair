# Container for Nginx
#
# Version   0.0.1

FROM pvgomes/nginx:latest

COPY ./symfony2biso-dev.conf /etc/nginx/sites-available/
COPY ./symfony2biso-prod.conf /etc/nginx/sites-available/

RUN ln -nfs /etc/nginx/sites-available/symfony2biso-dev.conf /etc/nginx/sites-enabled/symfony2biso-dev.conf \
    && ln -nfs /etc/nginx/sites-available/symfony2biso-prod.conf /etc/nginx/sites-enabled/symfony2biso-prod.conf \
    && rm sites-enabled/domain.conf

EXPOSE 80

ENTRYPOINT ["nginx"]
