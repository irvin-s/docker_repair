FROM registry.spin.nersc.gov/das/jupyter-dev-nersc.deploy-18-10:latest
MAINTAINER Rollin Thomas <rcthomas@lbl.com>

# JupyterHub components

RUN \
    pip install git+https://github.com/NERSC/sshspawner.git

# Some dummy users

RUN \
    adduser -q --gecos "" --disabled-password torgo     && \
    echo torgo:the-master-would-not-approve | chpasswd

RUN \
    adduser -q --gecos "" --disabled-password master    && \
    echo master:you-have-failed-us-torgo | chpasswd

WORKDIR /srv
ADD docker-entrypoint.sh .
ADD jupyterhub_config.py .
RUN chmod +x docker-entrypoint.sh
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

CMD ["jupyterhub", "--debug"]
ENTRYPOINT ["./docker-entrypoint.sh"]
