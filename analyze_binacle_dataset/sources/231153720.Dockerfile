FROM ubuntu:14.04

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates wget bash git openssh-client perl \
    curl ruby ruby-dev python realpath psmisc make && \
    apt-get clean

ENV JQ_VERSION=1.5 GCLOUD_SDK_VERSION=192.0.0

# Import stedolan PGP key (jq)
RUN wget -nv https://raw.githubusercontent.com/stedolan/jq/master/sig/jq-release.key && \
    gpg --import jq-release.key && \
    gpg --fingerprint 0x71523402 | grep 'Key fingerprint = 4FD7 01D6 FA9B 3D2D F5AC  935D AF19 040C 7152 3402' && \
    if [ "$?" != "0" ]; then echo "Invalid PGP key!"; exit 1; fi

# Install jq
RUN cd /tmp && \
    wget -nv https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux64 && \
    wget -nv https://raw.githubusercontent.com/stedolan/jq/master/sig/v$JQ_VERSION/jq-linux64.asc && \
    gpg --verify jq-linux64.asc jq-linux64 && \
    chmod +x jq-linux64 && \
    mv jq-linux64 /usr/local/bin/jq

# Install Google Cloud CLI
RUN wget -q -O /usr/gcloud.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GCLOUD_SDK_VERSION-linux-x86_64.tar.gz && \
    ( \
      echo 'f8220a7f8c4d45644ab422feabc36ad4d80834fc1b21a48d8d7901ea8184d4b5' /usr/gcloud.tar.gz | \
      sha256sum -c - \
    ) && \
    tar -C /usr/ -xzvf /usr/gcloud.tar.gz && \
    /usr/google-cloud-sdk/install.sh --usage-reporting false --path-update false --command-completion false -q

RUN echo source /usr/google-cloud-sdk/path.bash.inc > /root/.bashrc
