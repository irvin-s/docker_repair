FROM fstyle/caffe-ssd

RUN pip install \
    jupyter \
    lmdb \
    opencv-contrib-python \
    && rm -rf ~/.cache/pip

RUN ln -s /usr/bin/python /usr/bin/python3

# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -yq --no-install-recommends \
    bzip2 \
    ca-certificates \
    locales \
    netcat \
    sudo \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV SHELL=/bin/bash \
    NB_USER=aurora \
    NB_UID=1000 \
    NB_GID=2000 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Create aurora user with UID=1000 and in the 'aurora' group
RUN groupadd -g $NB_GID $NB_USER \
    && useradd -m -s $SHELL -N -u $NB_UID -g $NB_GID $NB_USER \
    && echo '%'$NB_USER 'ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 8888
WORKDIR /workspace

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# Install Aurora job submit tool
ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi

# Configure container startup
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]
