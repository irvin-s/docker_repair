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

# Add flask and gunicorn

RUN \
    curl -s -o /tmp/miniconda3.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh    &&  \
    bash /tmp/miniconda3.sh -f -b -p /opt/anaconda3         &&  \
    rm -rf /tmp/miniconda3.sh                               &&  \
    echo "python 3.7.*" >> /opt/anaconda3/conda-meta/pinned &&  \
    /opt/anaconda3/bin/conda update --yes conda             &&  \
    /opt/anaconda3/bin/conda install --yes                      \
        flask           \
        gunicorn                                            &&  \
    /opt/anaconda3/bin/conda clean --yes --all

ENV PATH=/opt/anaconda3/bin:$PATH

# Application

WORKDIR /srv
ADD app.py /srv/
ADD templates /srv/templates
ADD static /srv/static

CMD ["gunicorn", "app:app", "-b", ":8000", "--name", "app", "--workers=4", "--log-file=-"]
