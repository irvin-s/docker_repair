FROM gorghoa/php7

WORKDIR /app

RUN composer  create-project --no-scripts --no-dev api-platform/api-platform ./ v2.0.0-alpha.1 \
    && rm -Rf src/AppBundle/Entity/*

RUN  composer require api-platform/schema-generator

COPY ./parameters.yml ./app/config/parameters.yml
COPY ./schema.yml ./app/config/schema.yml

RUN php ./vendor/bin/schema generate-types src/ app/config/schema.yml

COPY ./start.sh ./start.sh
RUN chmod +x ./start.sh

CMD ["bash", "/app/start.sh"]
