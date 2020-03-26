FROM jenkins
USER root

# Update repos
RUN apt-key update && apt-get update && apt-get -y --force-yes upgrade

# Install android AAPT dependencies
RUN apt-get -y --force-yes install make lib32stdc++6 lib32z1 g++

# Debian config for Infer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            build-essential \
            curl \
            git \
            groff \
            libgmp-dev \
            libmpc-dev \
            libmpfr-dev \
            m4 \
            ocaml \
            python-software-properties \
            rsync \
            software-properties-common \
            unzip \
            zlib1g-dev

# Install OPAM for Infer
RUN curl -sL \
      https://github.com/ocaml/opam/releases/download/1.2.2/opam-1.2.2-x86_64-Linux \
      -o /usr/local/bin/opam && \
    chmod 755 /usr/local/bin/opam
RUN opam init -y --comp=4.01.0 && \
    opam install -y extlib.1.5.4 atdgen.1.6.0 javalib.2.3.1 sawja.1.5.1

# Download Infer
RUN INFER_VERSION=$(curl -s https://api.github.com/repos/facebook/infer/releases \
      | grep -e '^[ ]\+"tag_name"' \
      | head -1 \
      | cut -d '"' -f 4); \
    cd /opt && \
    curl -sL \
      https://github.com/facebook/infer/releases/download/${INFER_VERSION}/infer-linux64-${INFER_VERSION}.tar.xz | \
    tar xJ && \
    rm -f /infer && \
    ln -s ${PWD}/infer-linux64-$INFER_VERSION /infer

# Build Infer
RUN cd /infer && ./build-infer.sh java

# Final docker user is going to be jenkins
USER jenkins

# Setup Infer environment variable
ENV PATH /infer/infer/bin/:$PATH