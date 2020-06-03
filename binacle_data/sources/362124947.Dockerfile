FROM        ubuntu:14.04

# Last build date - this can be updated whenever there are security updates so
# that everything is rebuilt
ENV         security_updates_as_of 2015-11-03


# Install security updates and required packages
RUN         apt-get -qy update && \
            apt-get -y install apt-transport-https software-properties-common wget zip && \
            add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /" && \
            apt-get -qy update && \
            apt-get -qy upgrade && \
            apt-get -y --force-yes install clusterhq-flocker-cli && \
            apt-get remove --purge -y $(apt-mark showauto) python3.4 && \
            apt-get -y install apt-transport-https software-properties-common && \
            apt-get -y --force-yes install clusterhq-flocker-cli && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /app

ENV         PATH /opt/flocker/bin:$PATH

ADD         . /app

WORKDIR     /app

# Install requirements from the project's setup.py
RUN         /opt/flocker/bin/pip install --no-cache-dir .
CMD         ["flocker-certificate-service"]
