FROM alpine:3.8
RUN apk update -U
RUN apk add go go-tools go-doc git make musl-dev musl musl-utils
RUN adduser -s /opt/bin/si-i2p-plugin -S -H -D sii2pplugin sii2pplugin
COPY . /opt/
RUN chown -R sii2pplugin /opt
WORKDIR /opt/
RUN make release && chmod a+x /opt/bin/si-i2p-plugin
RUN apk del go go-tools go-doc git make musl-dev musl musl-utils
USER sii2pplugin
CMD /opt/bin/si-i2p-plugin \
    -proxy-addr=0.0.0.0 \
    -proxy-port=44443 \
    -ah-addr=sam-jumphelper \
    -ah-port=7854 \
    -bridge-addr=sam-host \
    -bridge-port=7656 \
    -in-tunnels=8 \
    -out-tunnels=8 \
    -in-backups=5 \
    -out-backups=5 \
    -internal-ah=false \
    -lifespan=20 \
    -addressbook=/opt/etc/si-i2p-plugin/addresses.csv \
    #-verbose=true \
    #-conn-debug=true \
    #-avoidance=true \
    #
