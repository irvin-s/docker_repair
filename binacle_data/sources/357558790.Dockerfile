FROM maven:3.3.9-jdk-8

RUN apt-get update
RUN apt-get -y install sudo

RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		bison \
		flex \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.6.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 e40c36ae71756198478624ed1bb4ce17597b3c19d243f3f0899bb5740d56212a

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

RUN curl -L https://github.com/ArthurHlt/generate-sql-data/releases/download/v1.0.0/generate-sql-data_linux_amd64 -o generate-sql-data \
    && chmod +x generate-sql-data \
    && mv generate-sql-data /usr/bin

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

RUN curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary" -o cf.tgz \
    && tar -xvf cf.tgz \
    && chmod +x cf \
    && mv cf /usr/bin

RUN curl -L "https://github.com/Orange-OpenSource/db-dumper-cli-plugin/releases/download/v1.4.1/db-dumper_linux_amd64" -o db-dumper \
    && chmod +x db-dumper \
    && cf install-plugin ./db-dumper -f

RUN curl -L https://github.com/rlmcpherson/s3gof3r/releases/download/v0.5.0/gof3r_0.5.0_linux_amd64.tar.gz -o gof3r_0.5.0_linux_amd64.tar.gz \
    && tar -xvf gof3r_0.5.0_linux_amd64.tar.gz \
    && chmod +x gof3r_0.5.0_linux_amd64/gof3r \
    && mv gof3r_0.5.0_linux_amd64/gof3r /usr/bin \
    && rm gof3r_0.5.0_linux_amd64.tar.gz \
    && rm -Rf gof3r_0.5.0_linux_amd64

WORKDIR $GOPATH

CMD ["mvn"]