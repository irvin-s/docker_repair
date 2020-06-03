# Oh the hack-manity! Make nsenter available to the service by start from
# the nsenter "installer" image.
FROM jpetazzo/nsenter

# Get docker, python, pip installed inorder to use tornado and bcrypt
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb http://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install --no-install-recommends -yf python-pip docker-engine python-dev libffi-dev && \
    apt-get clean
RUN pip install tornado bcrypt

# Put the nsenter bits in the PATH
RUN mv /docker-enter /usr/local/bin && \
    mv /nsenter /usr/local/bin && \
    mv /importenv /usr/local/bin

# Add the volume manager source
RUN mkdir -p /srv/volman
COPY main.py /srv/volman/
COPY attach_work.sh /srv/volman/

WORKDIR /srv/volman

ENTRYPOINT ["/srv/volman/main.py"]
