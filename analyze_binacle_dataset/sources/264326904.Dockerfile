FROM alpine
VOLUME /data
WORKDIR /minio
RUN mkdir /root/.minio
ADD ./config.json /root/.minio/
RUN apk update;apk add curl -y
RUN curl -O https://dl.minio.io/server/minio/release/linux-amd64/archive/minio
RUN chmod +x  minio
CMD ./minio server /data
