FROM ubuntu
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git curl wget python make g++ htop

# Forbidden path outside the build context: ../public ()
COPY docker/fs /

RUN configure-lap.docker

# Forbidden path outside the build context: ../public ()
COPY public /www/public

CMD ["/bin/bash", "-c", "trap 'kill %1' INT; apache2ctl -DFOREGROUND & wait -n"]
EXPOSE 80 3306
WORKDIR /www
