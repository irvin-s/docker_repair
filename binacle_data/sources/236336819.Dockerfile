FROM alpine:latest
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories
ENV kcptun_latest="https://github.com/xtaci/kcptun/releases/latest" \
    KCPTUN_DIR=/kcp
RUN set -ex && \
    apk add --no-cache curl jq && \
    apk add --no-cache  --virtual TMP wget && \
    [ ! -d ${KCPTUN_DIR} ] && mkdir -p ${KCPTUN_DIR} && cd ${KCPTUN_DIR} && \
    kcptun_latest_release=`curl -s ${kcptun_latest} | cut -d\" -f2` && \
    kcptun_latest_download=`curl -s ${kcptun_latest} | cut -d\" -f2 | sed 's/tag/download/'` && \
    kcptun_latest_filename=`curl -s ${kcptun_latest_release} | sed -n '/<strong>kcptun-linux-amd64/p' | cut -d">" -f2 | cut -d "<" -f1` && \
    wget ${kcptun_latest_download}/${kcptun_latest_filename} -O ${KCPTUN_DIR}/${kcptun_latest_filename} && \
    tar xzf ${KCPTUN_DIR}/${kcptun_latest_filename} -C ${KCPTUN_DIR}/ && \
    mv ${KCPTUN_DIR}/client_linux_amd64 ${KCPTUN_DIR}/client && \
    rm -f ${KCPTUN_DIR}/server_linux_amd64 ${KCPTUN_DIR}/${kcptun_latest_filename} && \
    chown root:root ${KCPTUN_DIR}/* && \
    chmod 755 ${KCPTUN_DIR}/* && \
    ln -s ${KCPTUN_DIR}/* /bin/ && \
    apk --no-cache del --virtual TMP && \
    rm -rf /var/cache/apk/* ~/.cache /tmp/libsodium

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && crontab -l | { cat; echo "*/1 * * * * sh /entrypoint.sh"; } | crontab -
#ENTRYPOINT crond -f
ENTRYPOINT  sh /entrypoint.sh ; crond -f
EXPOSE 4440
