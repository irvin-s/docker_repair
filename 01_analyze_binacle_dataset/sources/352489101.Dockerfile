#docker run -it --rm \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v /tmp/.X11-unix:/tmp/.X11-unix \
#   -v ${HOME}/.config/Postman/:/root/.config/Postman \
#   -e DISPLAY=unix$DISPLAY \
#   gianarb/postman $@
FROM debian:sid
LABEL maintainer "Gianluca Arbezzano <gianarb92@gmail.com>"

WORKDIR /usr
RUN apt-get update && \
    apt-get install -y libnss3 libasound2 \
    libgconf-2-4 libxtst6 \
    ca-certificates wget libxss1 libgtk2.0-0 && \
    update-ca-certificates && \
    wget https://dl.pstmn.io/download/latest/linux64 && \
    tar xzvf ./linux64 && \
    rm ./linux64

CMD ["/usr/Postman/Postman"]
