FROM golang:1.4

MAINTAINER Potiguar Faga <potz@potz.me>

ENV WKHTML_MAJOR 0.12
ENV WKHTML_MINOR 2.1

# Builds the wkhtmltopdf download URL based on version numbers above
ENV DOWNLOAD_URL "http://download.gna.org/wkhtmltopdf/${WKHTML_MAJOR}/${WKHTML_MAJOR}.${WKHTML_MINOR}/wkhtmltox-${WKHTML_MAJOR}.${WKHTML_MINOR}_linux-jessie-amd64.deb"

# Create system user first so the User ID gets assigned
# consistently, regardless of dependencies added later
RUN useradd -rM appuser && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl \
       fontconfig libfontconfig1 libfreetype6 \
       libpng12-0 libjpeg62-turbo \
       libssl1.0.0 libx11-6 libxext6 libxrender1 \
       xfonts-base xfonts-75dpi && \
    curl -o /tmp/wkhtmltox.deb $DOWNLOAD_URL && \
    dpkg -i /tmp/wkhtmltox.deb && \
    rm /tmp/wkhtmltox.deb && \
    apt-get purge -y curl && \
    rm -rf /var/lib/apt/lists/*

COPY /app /usr/src/app

RUN mkdir /app && \
    cd /usr/src/app && \
    go build -v -o /app/app && \
    chown -R appuser:appuser /app

USER appuser
WORKDIR /app
EXPOSE 3000

CMD [ "/app/app" ]
