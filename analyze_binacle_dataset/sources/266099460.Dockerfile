FROM ubuntu
LABEL maintainer "joe.sylve@gmail.com"

# Update and install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        ca-certificates \
        xz-utils \
        git \
        build-essential \
    && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Download and unpack compilers
RUN mkdir -p /opt/compilers
WORKDIR /opt/compilers
RUN curl -sL https://s3.amazonaws.com/compiler-explorer/opt/gcc-7.3.0.tar.xz | tar Jxf - && \
    curl -sL https://s3.amazonaws.com/compiler-explorer/opt/gcc-8.1.0.tar.xz | tar Jxf - && \
    curl -sL https://s3.amazonaws.com/compiler-explorer/opt/clang-6.0.0.tar.xz | tar Jxf -

# Create user and create working directories 
RUN useradd -m ceuser && \
    mkdir -p /opt/compiler-explorer && \
    chown ceuser /opt/compiler-explorer

USER ceuser

# Install node and update npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash && \
    . ~/.profile && \
    nvm install 8 && \
    npm install npm -g

# Do the initial checkout of the source and install prereqs
WORKDIR /opt/compiler-explorer
RUN git clone --single-branch --branch release \
    https://github.com/mattgodbolt/compiler-explorer.git . && \
    . ~/.profile && \
    make prereqs

# Copy the config files
USER root
COPY *.properties /opt/compiler-explorer/etc/config/
RUN chown -R ceuser /opt/compiler-explorer/etc/config/

# Copy the startup script
COPY run-ce.sh /
RUN chmod +x /run-ce.sh

# Set startup entrypoint
USER ceuser
EXPOSE 10240
ENTRYPOINT /run-ce.sh

