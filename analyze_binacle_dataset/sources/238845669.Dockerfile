FROM golang:1.9.4

MAINTAINER christophe.larsonneur@hpe.com

ARG UID
ARG GID

ENV GLIDE_VERSION 0.13.2
ENV GLIDE_DOWNLOAD_URL=https://github.com/Masterminds/glide/releases/download/v${GLIDE_VERSION}/glide-v${GLIDE_VERSION}-linux-amd64.tar.gz \
    GLIDE_HOME=/go/.glide/${GLIDE_VERSION}

RUN curl -fsSL "$GLIDE_DOWNLOAD_URL" -o glide.tar.gz \
    && tar -xzf glide.tar.gz \
    && mv linux-amd64/glide /usr/bin/ \
    && rm -r linux-amd64 \
    && rm glide.tar.gz
# Create a directory inside the container to store all our application and then
# make it the working directory.
RUN groupadd -g $GID developer \
    && useradd -m -u $UID -g $GID developer \
    && install -d -o developer -g developer -m 755 /go/src \
    && install -d -o developer -g developer -m 755 $GLIDE_HOME

COPY go-static /usr/local/go/bin
COPY entrypoint.sh /bin/entrypoint.sh

WORKDIR /go/src

ENTRYPOINT [ "/bin/entrypoint.sh" ]