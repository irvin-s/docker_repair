FROM debian:stretch
MAINTAINER Martin Raiber <martin@urbackup.org>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg &&\
    echo '-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
Version: GnuPG v1.4.5 (GNU/Linux)\n\
\n\
mQGiBE0l/ngRBACDijN2ucVRAzQY2UW4F8dll6hfXSdGq5zCyQ9CU7H6BLEwi15I\n\
NBNP1LPJHtrXV1dgk/p4OUDNndlRbxPUwbnzZLwryc1xzioRSC206ZckfrbwB5oU\n\
yGkuxhoRDIkpwesJIM1GAriEOXKVZOUM3t6e2ejqZAw3bIwi6R0HoEK1xwCg4MRy\n\
1WhR8HN6rEpiyOVY8tYA/8UD/00QUC3i/DkrTZkU2AxCa0xDZuKL/HJd7DedTd+7\n\
uy27TsvcK2ly3rnq4NR8gdnUInH+maQB1rmtxa7FyOWwLr8zTwe6fCofgcSEdsgE\n\
zZi+SvDWwFfXbuQc8r1Ep8NlIzjnxZYAYlclWe2sxAL7hXKtEuSbTQIanScduFM4\n\
mOTSA/99pFgcmR61tY9ulx1wrbOZuROCbF20JNwaUZcl6qUSCcxyxDe+7fFVWHI7\n\
T6ptq99g15lf+ffRVVNFeQlufoPGPyen3JFbKDqsSx0vWG0aza6MaTKdH7y6itZq\n\
2CxbteVEjjNurIJhd6yvwQH1+njucMqJ1lFLsp0ZQowgUE4sNLQ2aG9tZTp1cm9u\n\
aSBPQlMgUHJvamVjdCA8aG9tZTp1cm9uaUBidWlsZC5vcGVuc3VzZS5vcmc+iGYE\n\
ExECACYFAlh+MUoCGwMFCQ924tIGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRC/\n\
scF/Ilz8hcQLAKDFOmsXkZgaowH7iupliaxAqsJVUACgscyahnMUFrL60teLtPOQ\n\
G7J6CJ2IRgQTEQIABgUCTSX+eAAKCRA7MBG3a51lIxeYAJ9qxVL7hrlbzhLkauWH\n\
ClXc9mDhBwCgmHEzkcQYjJgDx1DfqauiVS89Ce0=\n\
=6f/s\n\
-----END PGP PUBLIC KEY BLOCK-----' | apt-key add -

RUN echo 'deb http://download.opensuse.org/repositories/home:/uroni/Debian_9.0/ /' > /etc/apt/sources.list.d/urbackup-server.list &&\
    apt-get update &&\
    echo "urbackup-server urbackup/backuppath string /backups" | debconf-set-selections &&\
    export DEBIAN_FRONTEND=noninteractive &&\
    apt-get install -y --no-install-recommends --allow-unauthenticated urbackup-server btrfs-tools &&\
    rm -rf /var/lib/apt/lists/*

COPY start /usr/bin/start

EXPOSE 55413/tcp 55414/tcp 55415/tcp 35623/udp

VOLUME [ "/backups", "/var/urbackup", "/var/log", "/usr/share/urbackup" ]
ENTRYPOINT ["/usr/bin/start"]
CMD ["run"]
