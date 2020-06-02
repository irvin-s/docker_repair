FROM perl:latest
RUN cpanm Dancer2
ADD . /app
EXPOSE 8080
WORKDIR /app
CMD ["plackup", "-r", "bin/app.psgi", "--port", "8080"]