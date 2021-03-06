ARG BASE_IMAGE
FROM $BASE_IMAGE

LABEL maintainer="Bernd Doser <bernd.doser@braintwister.eu>"

ARG VERSION=1.35.0

ENV SHELL /bin/bash
ENV DOWNLOAD_URL https://vscode-update.azurewebsites.net/$VERSION/linux-deb-x64/stable

RUN wget -q "$DOWNLOAD_URL" -O code.deb

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    chromium-browser \
    libasound2 \
    libgtk-3-0 \
    libxtst6 \
    libx11-xcb-dev \
    ./code.deb \
 && apt-get clean \
 && rm ./code.deb \
 && rm -rf /var/lib/apt/lists/*

ADD keep_running.sh /postprocess.d/

CMD ["code"]
