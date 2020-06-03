FROM ubuntu
MAINTAINER Mihai Criveti

# ADD AND RUN
RUN apt-get update \
    && apt-get install -y wget bzip2 \
    && wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/conda-install.sh \
    && bash /tmp/conda-install.sh -b -p $HOME/anaconda3 > /tmp/conda-install.log 2>&1 \
    && rm /tmp/conda-install.sh \
    && echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.bashrc \
    && . ~/.bashrc \
    && pip install jupyter redis \
    && apt-get clean

# PERSISTENCE
VOLUME ["/notebooks"]

# WORKDIR
WORKDIR /notebooks

# COMMAND and ENTRYPOINT:
CMD ["/root/anaconda3/bin/jupyter","notebook","--allow-root","--ip=0.0.0.0","--port=9000"]

# NETWORK
EXPOSE 9000

