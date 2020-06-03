FROM centos
RUN useradd -d /opt/minio -g root minio
WORKDIR /opt/minio
ADD entrypoint.sh .
RUN curl -o minio https://dl.minio.io/server/minio/release/linux-amd64/minio.RELEASE.2018-06-29T02-11-29Z && \
    chmod +x minio && \
    mkdir config && \
    mkdir data  && \
    chown minio:root -R . && chmod 777 -R .
USER minio
VOLUME /opt/minio/config
VOLUME /opt/minio/data
EXPOSE 9000
ENTRYPOINT [ "./entrypoint.sh" ]