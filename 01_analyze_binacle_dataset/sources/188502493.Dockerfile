FROM tianon/rawdns

COPY config/rawdns.json /etc/rawdns.json

ENTRYPOINT  ["rawdns", "/etc/rawdns.json"]
