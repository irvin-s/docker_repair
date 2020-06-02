######################################################
#
# Cyverse CLI Image
# Tag: cyverse-cli
#
# https://github.com/iPlantCollaborativeOpenSource/cyverse-sdk
#
# This container a Cyverse-branded, customized Agave CLI
#
# docker run -it -v $HOME/.agave:/root/.agave cyverse/cyverse-cli bash
#
######################################################

FROM ubuntu:trusty
MAINTAINER Matthew Vaughn <vaughn@tacc.utexas.edu>

RUN apt-get -y update && \
    apt-get -y install -y  git \
                        vim.tiny \
                        curl \
                        python \
                        python-pip && \
    apt-get -y clean

RUN curl -L -sk -o /usr/local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64" \
    && chmod a+x /usr/local/bin/jq

ADD cyverse-cli /usr/local/agave-cli
ENV PATH $PATH:/usr/local/agave-cli/bin

# RUN echo export PS1=\""\[\e[32;4m\]agave-cli\[\e[0m\]:$AGAVE_TENANT:$AGAVE_USERNAME@\h:\w$ "\" >> /root/.bashrc

# Set user's default env. This won't get sourced, but is helpful
RUN echo HOME=/root >> /root/.bashrc && \
    echo AGAVE_CACHE_DIR=/root/.agave >> /root/.bashrc && \
    echo PROMPT_COMMAND=/usr/local/agave-cli/bin/prompt_command >> /root/.bashrc && \
    echo export PS1=\"\\h:\\w\$ \" >> /root/.bashrc && \
    usr/local/agave-cli/bin/tenants-init -t iplantc.org

# Runtime parameters. Start a shell by default
VOLUME /root/.agave
CMD "/bin/bash"
