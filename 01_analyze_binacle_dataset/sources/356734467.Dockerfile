
FROM pdonorio/py3api
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.it>"

# Install dependencies
RUN apt-get update && apt-get install -y \
    libfuse2 \
    && apt-get clean

# ADD services which are not so common

###############################
# IRODS

# Environments
ENV IRODSVERSION 4.1.8
ENV IRODSFTP "ftp://ftp.renci.org/pub/irods/releases/$IRODSVERSION/ubuntu14"
ENV IRODSPKG "icommands"
ENV IRODSDEB $IRODSFTP/irods-${IRODSPKG}-${IRODSVERSION}-ubuntu14-x86_64.deb

# Icommands
WORKDIR /tmp

RUN wget -q $IRODSDEB \
    && dpkg -i irods*.deb \
    && rm *.deb

###############################
# OTHERS?

RUN echo "echo 'Run Flask server with the command:'" >> /root/.bashrc
RUN echo "echo './boot devel'" >> /root/.bashrc
