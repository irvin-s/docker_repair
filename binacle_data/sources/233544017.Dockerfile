FROM armv7/armhf-ubuntu
RUN apt-get update;apt-get install wget -y
RUN wget https://dl.minio.io/server/minio/release/linux-amd64/minio
RUN chmod +x minio
CMD ./minio server /tmp
