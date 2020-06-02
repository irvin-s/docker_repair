FROM ubuntu:16.04
LABEL maintainer="Rollin Thomas <rcthomas@lbl.gov>"

# Base Ubuntu packages

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN \
    apt-get update          &&  \
    apt-get --yes upgrade   &&  \
    apt-get --yes install       \
        bzip2                   \
        curl                    \
        tzdata                  \
        vim

# Timezone to Berkeley

ENV TZ=America/Los_Angeles
RUN \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime  &&  \
    echo $TZ > /etc/timezone

# Python 3 Miniconda

RUN \
    curl -s -o /tmp/miniconda3.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh    &&  \
    bash /tmp/miniconda3.sh -f -b -p /opt/anaconda3         &&  \
    rm -rf /tmp/miniconda3.sh                               &&  \
    /opt/anaconda3/bin/conda update --yes conda             &&  \
    /opt/anaconda3/bin/pip install --no-cache-dir               \
        pika==0.13.1

ENV PATH=/opt/anaconda3/bin:$PATH

WORKDIR /srv

ADD monitor.py .
ADD docker-entrypoint.sh .

RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["python", "monitor.py"]
