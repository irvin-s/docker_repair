########
# Stage 1:
# - Install Mono
# - Build Project
# - Make Bundle
########
FROM debian:stretch-slim AS mkbundle

RUN set -ex \
    && apt update \
    && apt install -y gpg \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb http://download.mono-project.com/repo/debian stretch main" > /etc/apt/sources.list.d/mono-official.list \
    && apt-get update \
    && apt install -y --no-install-recommends mono-devel nuget msbuild fsharp

# Remember to configurare these ARGS also on Stage 2
ARG PROJECT=SigFoxReceiver
ARG CONFIGURATION=Release

COPY . /Build/${PROJECT}/

WORKDIR /Build/${PROJECT}
RUN set -ex \
    && nuget restore -PackagesDirectory ../packages -NonInteractive

RUN set -ex \
    && msbuild /p:Configuration=${CONFIGURATION}

WORKDIR /Build/${PROJECT}/bin/${CONFIGURATION}
RUN set -ex \
    && mkbundle -o ${PROJECT} --simple ${PROJECT}.exe

########
# Stage 2: Build Image
########
FROM busybox:glibc
RUN set -ex; ln -s /lib/libc.so.6 /lib/libc.so
COPY --from=mkbundle /usr/lib/x86_64-linux-gnu/librt* /lib/
COPY --from=mkbundle /usr/lib/x86_64-linux-gnu/libdl* /lib/
COPY --from=mkbundle /usr/lib/x86_64-linux-gnu/libgcc* /lib/

ARG PROJECT=SigFoxReceiver
ARG CONFIGURATION=Release

COPY --from=mkbundle /Build/${PROJECT}/bin/${CONFIGURATION}/${PROJECT} /opt/${PROJECT}/bin/
ENV PATH /opt/${PROJECT}/bin:$PATH
ENV COMMAND ${PROJECT}

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s /usr/local/bin/docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["--host", "0.0.0.0", "--mqttbroker", "mqtt", "1883"]
