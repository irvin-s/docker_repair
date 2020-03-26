FROM pseiffert/composer

COPY . /app/symfony
VOLUME /app/symfony
WORKDIR /app/symfony

ENTRYPOINT ["php", "app/console"]
