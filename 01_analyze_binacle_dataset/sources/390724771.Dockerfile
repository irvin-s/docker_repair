FROM perl:5.24.0

WORKDIR /app
COPY cpanfile /app

RUN cpanm --with-develop --installdeps --notest .
VOLUME /app/local

CMD cp -r /app /work && cd /work && minil build && minil test
