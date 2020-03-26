FROM alpine:latest

LABEL maintainer="Alexander Zinchenko <alexander@zinchenko.com>"

ENV URL_NORDVPN_API="https://api.nordvpn.com/server" \
    URL_RECOMMENDED_SERVERS="https://nordvpn.com/wp-admin/admin-ajax.php?action=servers_recommendations" \
    URL_OVPN_FILES="https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip" \
    MAX_LOAD=70 \
    RANDOM_TOP=0

RUN \
    echo "**** install packages ****" && \
    apk --no-cache --no-progress add bash curl unzip tar iptables ip6tables jq openvpn && \
    echo "**** add s6 overlay ****" && \
    curl -o /tmp/s6-overlay.tar.gz -L \
        "https://github.com/just-containers/s6-overlay/releases/download/v1.22.0.0/s6-overlay-amd64.tar.gz" && \
    tar xfz /tmp/s6-overlay.tar.gz -C / && \
    echo "**** create folders ****" && \
    mkdir -p /vpn \
    mkdir -p /ovpn \
    echo "**** cleanup ****" && \
    apk del --purge tar && \
    rm -rf /tmp/*

COPY root/ /

VOLUME ["/ovpn/"]

ENTRYPOINT ["/init"]
