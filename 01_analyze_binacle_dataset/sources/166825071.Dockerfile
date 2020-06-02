FROM ubuntu:16.04

WORKDIR /tmp
ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 2
ENV LIBVIPS_VERSION_PATCH 3
ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH

RUN \
  # Install dependencies
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  automake build-essential curl \
  gobject-introspection gtk-doc-tools libglib2.0-dev libjpeg-turbo8-dev \
  libpng12-dev libwebp-dev libtiff5-dev libexif-dev libxml2-dev swig libmagickwand-dev libpango1.0-dev \
  libmatio-dev libopenslide-dev libcfitsio3-dev && \

  # Build libvips
  curl -O http://www.vips.ecs.soton.ac.uk/supported/$LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR/vips-$LIBVIPS_VERSION.tar.gz && \
  tar zvxf vips-$LIBVIPS_VERSION.tar.gz && \
  cd vips-$LIBVIPS_VERSION && \
  ./configure --enable-debug=no --without-python --without-orc --without-fftw --without-gsf $1 && \
  make && \
  make install && \
  ldconfig && \

  # Clean up
  apt-get remove -y curl automake build-essential && \
  apt-get autoremove -y && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
		curl \
		git \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.7.1
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 43ad621c9b014cde8db17393dc108378d37bc853aa351a6c74bf6432c1bbd182

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN curl https://glide.sh/get | sh

COPY . $GOPATH/src/github.com/plimble/ivy
WORKDIR $GOPATH/src/github.com/plimble/ivy

RUN glide install && \
    ./run.sh -b

CMD ["./app"]
