FROM debian:wheezy

MAINTAINER vhb <vctrhb@gmail.com>

RUN apt-get update --quiet \
        && apt-get install --yes \
            --no-install-recommends \
            --no-install-suggests \
            boinc-client python psmisc \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
#RUN boinc &
ADD boinc.sh /bin/

CMD []

ENTRYPOINT ["/bin/boinc.sh"]
