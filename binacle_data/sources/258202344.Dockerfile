FROM alpine:3.8
RUN apk update && apk add go go-tools make musl-dev musl musl-utils git
RUN apk upgrade
RUN addgroup -g 132 iupd
RUN adduser -g i2pd -D i2pd
RUN git clone https://github.com/eyedeekay/jumphelper /opt/work
WORKDIR /opt/work
RUN make deps server && cp ./bin/jumphelper /bin/jumphelper
COPY misc/addresses.csv /var/lib/i2pd/addressbook/addresses.csv
RUN chown -R i2pd:i2pd /var/lib/i2pd/addressbook/addresses.csv /opt/work
USER i2pd
VOLUME /opt/work
CMD jumphelper -host="0.0.0.0" \
    -share=false \
    -i2p=false \
    -tunname="sam-jumphelper" \
    -port="7854" \
    -samhost=sam-host \
    -samport="7656" \
    -hostfile=/var/lib/i2pd/addressbook/addresses.csv \
    -subs "http://joajgazyztfssty4w2on5oaqksz6tqoxbduy553y34mf4byv6gpq.b32.i2p/export/alive-hosts.txt"
