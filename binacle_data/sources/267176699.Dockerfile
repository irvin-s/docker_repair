FROM node:latest
WORKDIR /stajs
COPY stajs.zip /stajs/stajs.zip
COPY *.sh /stajs/
RUN apt-get update && apt-get install -y sudo
RUN ./install_stajs.sh
EXPOSE 3000
ENTRYPOINT ./start_stajs.sh
