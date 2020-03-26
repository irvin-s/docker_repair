FROM debian:jessie
MAINTAINER pavik - https://github.com/pavik

ENV COLX_USER=colx

ENV COLX_URL_LATEST=https://github.com/ColossusCoinXT/ColossusCoinXT/releases/latest \
 COLX_URL_DOWNLOAD=https://github.com/ColossusCoinXT/ColossusCoinXT/releases/download \
 COLX_CONF=/home/$COLX_USER/.ColossusXT/ColossusXT.conf

RUN apt-get -qq update && \
apt-get install -yq wget ca-certificates pwgen curl && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
export COLX_URL=`curl -Ls -o /dev/null -w %{url_effective} $COLX_URL_LATEST` && \
export COLX_VERSION=`echo $COLX_URL | grep -oP 'tag\/v(.+?)$' | sed -E 's/tag\/v//'` && \
wget $COLX_URL_DOWNLOAD/v$COLX_VERSION/colx-$COLX_VERSION-x86_64-linux-gnu.tar.gz -O /tmp/colx.tar.gz && \
mkdir -p /opt && \
cd /opt && \
tar xvzf /tmp/colx.tar.gz && \
rm /tmp/colx.tar.gz && \
ln -sf colx-$COLX_VERSION colx && \
ln -sf /opt/colx/bin/colxd /usr/local/bin/colxd && \
ln -sf /opt/colx/bin/colx-cli /usr/local/bin/colx-cli && \
ln -sf /opt/colx/bin/colx-tx /usr/local/bin/colx-tx && \
adduser --uid 1000 --system ${COLX_USER} && \
mkdir -p /home/${COLX_USER}/.ColossusXT/ && \
chown -R ${COLX_USER} /home/${COLX_USER} && \
echo "success: $COLX_CONF"

USER colx
RUN printf "listen=1\nserver=1\ntxindex=1\nrpcuser=*Your\$Username*\nrpcpassword=*Your\$Password*\nrpcport=51473\nport=51572\nrpcallowip=127.0.0.1\n" > $COLX_CONF && \
    sed -i -e 's/\*Your$Username\*/colx/g' ${COLX_CONF} && \
    sed -i -e 's/\*Your$Password\*/'`pwgen 32 1`'/g' ${COLX_CONF} && \
    echo "success"

EXPOSE 51572
VOLUME ["/home/colx/.ColossusXT"]
WORKDIR /home/colx

ENTRYPOINT ["/usr/local/bin/colxd"]