FROM perl:latest
RUN curl -L https://cpanmin.us | perl - -M https://cpan.metacpan.org -n Mojolicious
ENV MOJO_LISTEN http://*:8080
ADD . /app
EXPOSE 8080
WORKDIR /app
RUN chmod +x main.pl
CMD ["./main.pl", "daemon"]