FROM jordi/ab 

VOLUME /var/www

COPY ./tests /tests
WORKDIR /tests

CMD ["bash", "loadtest.sh"]

