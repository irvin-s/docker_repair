FROM openjdk:8 AS builder-base
WORKDIR /usr/src/datacollector-edge
RUN git init
COPY ./gradle ./gradle
COPY ./gradlew ./build.gradle ./gradle.properties ./
RUN ./gradlew --no-daemon init
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*
ENV CGO_ENABLED=1
ARG TF_TYPE="cpu"
ENV TARGET_DIRECTORY="/usr/local"
ENV PATH=${PATH}:"/root/.gradle/go/binary/1.11/go/bin"
ENV GOPATH=/usr/src/datacollector-edge/.gogradle/project_gopath
RUN curl -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-${TF_TYPE}-$(go env GOOS)-x86_64-1.10.0.tar.gz" | tar -C ${TARGET_DIRECTORY} -xz && ldconfig
ONBUILD COPY . .
ONBUILD ENV VER="$(grep version gradle.properties | awk -F = '{print $2}')"
ONBUILD RUN ./gradlew --no-daemon -Prelease -PincludeStage="kafka javascript tensorflow" installLinuxAmd64

FROM builder-base as builder

FROM debian:stretch-slim
COPY --from=builder /usr/local/lib/libtensorflow.so /usr/local/lib/libtensorflow_framework.so /usr/local/lib/
RUN ldconfig
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/src/datacollector-edge/dist /opt/datacollector-edge/

EXPOSE 18633
ENTRYPOINT ["/opt/datacollector-edge/bin/edge"]

# Metadata
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL Name="Data Collector Edge"
LABEL Version="${VERSION}"
LABEL org.label-schema.vendor="StreamSets" \
  org.label-schema.url="https://streamsets.com" \
  org.label-schema.name="Data Collector Edge - Tensorflow Edition" \
  org.label-schema.vcs-ref="${VCS_REF}" \
  org.label-schema.vcs-url="https://github.com/streamsets/datacollector-edge" \
  org.label-schema.version="${VERSION}" \
  org.label-schema.build-date="${BUILD_DATE}" \
  org.label-schema.docker.schema-version="1.0"
