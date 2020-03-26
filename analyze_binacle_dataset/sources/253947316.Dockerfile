ARG branch=unknown

FROM registry.spin.nersc.gov/das/jupyter-base-${branch}:latest
LABEL maintainer="Rollin Thomas <rcthomas@lbl.gov>"
WORKDIR /srv

# Additional Ubuntu packages

RUN \
    apt-get --yes install   \
        csh                 \
        dvipng              \
        ksh                 \
        ldap-utils          \
        libnss-ldapd        \
        libpam-ldap         \
        nscd                \
        openssh-server      \
        supervisor          \
        tcsh                \
        texlive-xetex       \
        zsh

ADD packages3.txt /tmp/packages3.txt
RUN \
    /opt/anaconda3/bin/conda update --yes conda                 && \
    /opt/anaconda3/bin/conda install --yes anaconda             && \
    /opt/anaconda3/bin/conda install --file /tmp/packages3.txt  && \
    /opt/anaconda3/bin/ipython kernel install                   && \
    /opt/anaconda3/bin/conda clean --yes --all

# Python 2 Anaconda and additional packages

ADD packages2.txt /tmp/packages2.txt
RUN \
    wget -q -O /tmp/miniconda2.sh https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh  && \
    bash /tmp/miniconda2.sh -f -b -p /opt/anaconda2             && \
    rm /tmp/miniconda2.sh                                       && \
    /opt/anaconda2/bin/conda update --yes conda                 && \
    /opt/anaconda2/bin/conda install --yes anaconda             && \
    /opt/anaconda2/bin/conda install --file /tmp/packages2.txt  && \
    /opt/anaconda2/bin/ipython kernel install                   && \
    /opt/anaconda2/bin/conda clean --yes --all

# For ssh auth API

ADD NERSC-keys-api /usr/lib/nersc-ssh-keys/
RUN chmod a+x /usr/lib/nersc-ssh-keys/NERSC-keys-api

# For sshd

RUN \
    mkdir -p /var/run/sshd  && \
    echo "AuthorizedKeysCommand /usr/lib/nersc-ssh-keys/NERSC-keys-api" >> /etc/ssh/sshd_config && \
    echo "AuthorizedKeysCommandUser nobody" >> /etc/ssh/sshd_config && \
    echo "TrustedUserCAKeys /etc/user_ca.pub"  >> /etc/ssh/sshd_config

# For PAM/LDAP

COPY etc/ /etc/

# GPFS

RUN \
    mkdir /global                               && \
    ln -sf /global/u1 /global/homes             && \
    ln -sf /global/project /project             && \
    ln -s /global/common/datatran /usr/common   && \
    echo "datatran" > /etc/clustername

# JupyterHub/lab features

RUN \
    pip install --no-cache-dir ipympl                               && \
    jupyter nbextension enable --sys-prefix --py widgetsnbextension && \
    jupyter labextension install            \
        @jupyterlab/hub-extension           \
        @jupyter-widgets/jupyterlab-manager \
        jupyter-matplotlib                  \
        @jupyterlab/toc                     \
        jupyterlab_bokeh

RUN \
    /opt/anaconda2/bin/jupyter nbextension enable --sys-prefix --py widgetsnbextension

# Get port script

ADD get_port.py /opt/anaconda3/bin/

# Supervisord to launch sshd and nslcd

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
