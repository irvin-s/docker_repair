FROM dockette/php71

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV DEPLOYER_VERSION=5.0.3
ENV DEPLOYER_BIN=/usr/local/bin/dep

# INSTALLATION
RUN apt update && apt dist-upgrade -y && \
    # DEPENDENCIES #############################################################
    apt install -y wget curl git openssh-client && \
    # DEPLOYER #################################################################
    curl -LO https://deployer.org/releases/v${DEPLOYER_VERSION}/deployer.phar && \
    mv deployer.phar ${DEPLOYER_BIN} && \
    chmod +x ${DEPLOYER_BIN} && \
    # CLEAN UP #################################################################
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

# WORKDIR
WORKDIR /srv

# COMMAND
CMD ["/usr/local/bin/dep"]
