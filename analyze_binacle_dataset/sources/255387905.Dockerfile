FROM ubuntu:18.04
LABEL maintainer="Kane Blueriver <kxxoling@gmail.com>"

ARG NB_USER=clojure
ARG NB_UID=1000
ENV HOME /home/${NB_USER}
ENV NOTEBOOK_PATH $HOME/notebooks
ENV PORT 8888
ENV CLOJUPYTER_PATH $HOME/clojupyter
ENV LEIN_ROOT 1

USER root
RUN apt update && apt install -yq \
        python-pip \
        python-dev \
        build-essential \
        curl \
        git-core \
        default-jre && \
    curl -o /etc/ssl/certs/java/cacerts https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/openjdk-9-slim-cacerts && \
    curl -o /usr/local/bin/lein https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod +x /usr/local/bin/lein && \
    lein self-install && \
    pip install jupyter && \
    adduser --disabled-password \
        --gecos "Default user" \
        --uid ${NB_UID} \
        --home ${HOME} \
        ${NB_USER} && \
    chown -R ${NB_USER}:${NB_USER} ${HOME}

USER ${NB_USER}
WORKDIR ${HOME}
RUN mkdir -p $NOTEBOOK_PATH && \
    git clone https://github.com/clojupyter/clojupyter.git $CLOJUPYTER_PATH

# Install clpjupyter
WORKDIR $CLOJUPYTER_PATH
RUN make && \
    make install && \
    rm -rf $CLOJUPYTER_PATH

WORKDIR $NOTEBOOK_PATH

EXPOSE $PORT
VOLUME $NOTEBOOK_PATH
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]
