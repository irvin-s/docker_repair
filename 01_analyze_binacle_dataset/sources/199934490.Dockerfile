FROM ubuntu:14.04

ENV PATH "$PATH:/opt/Fulcrum"
ENV GITHUB_FEED "https://api.github.com/repos/fulcrumapp/fulcrum-desktop/releases/latest"

# System Dependencies
RUN apt-get update -y && apt-get install -y \
      apt-transport-https \
      curl \
      software-properties-common \
      python-software-properties && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
      tee /etc/apt/sources.list.d/yarn.list && \
    add-apt-repository -y ppa:ubuntugis/ppa && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
    apt-get update -y && apt-get install -y \
      libjson0 \
      libjson0-dev \
      libsqlite3-dev \
      libproj-dev \
      libgeos-dev \
      libgeos++-dev \
      libspatialite-dev \
      libgeotiff-dev \
      libgdal-dev \
      gdal-bin \
      libmapnik-dev \
      mapnik-utils \
      python-dev \
      python-setuptools \
      python-pip \
      python-gdal \
      python-mapnik \
      libprotobuf-dev \
      protobuf-compiler \
      nodejs \
      yarn \
      gdebi-core \
      build-essential \
      libssl-dev \
      libpq-dev \
      libxml2-dev \
      libxslt1-dev \
      imagemagick \
      libmagickwand-dev \
      git \
      libyaml-dev \
      sqlite3 \
      autoconf \
      libgmp-dev \
      libgdbm-dev \
      libncurses5-dev \
      automake \
      make \
      bison \
      flex \
      libtool \
      xz-utils \
      libffi-dev \
      libgmp-dev \
      libreadline6-dev \
      postgresql-client \
      libx11-xcb1

# Install wkhtmltopdf
RUN apt-get install -y \
  zip \
  xfonts-encodings \
  xfonts-utils \
  xfonts-base xfonts-75dpi

RUN apt-get install -y \
  xfonts-intl-european \
  xfonts-intl-asian \
  xfonts-intl-arabic \
  xfonts-intl-chinese \
  xfonts-intl-chinese-big \
  xfonts-intl-japanese \
  xfonts-intl-japanese-big \
  xfonts-intl-phonetic \
  xfonts-wqy \
  xfonts-thai \
  fonts-khmeros-core \
  ttf-indic-fonts-core \
  ttf-indic-fonts \
  ttf-bengali-fonts \
  ttf-devanagari-fonts \
  ttf-gujarati-fonts \
  ttf-kannada-fonts \
  ttf-malayalam-fonts \
  ttf-oriya-fonts \
  ttf-punjabi-fonts \
  ttf-tamil-fonts \
  ttf-telugu-fonts \
  ttf-wqy-microhei \
  fonts-wqy-microhei \
  fonts-lao \
  fonts-droid

ENV WKHTMLTOPDF_URL "http://zhm.s3.amazonaws.com/wkhtmltopdf/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb"
ENV WKHTMLTOPDF_PATH /opt/wkhtmltopdf-build/wkhtmltopdf.deb

RUN mkdir -p `dirname $WKHTMLTOPDF_PATH`
RUN curl $WKHTMLTOPDF_URL > $WKHTMLTOPDF_PATH
RUN fc-cache -f -v
RUN dpkg --install $WKHTMLTOPDF_PATH
RUN rm /opt/wkhtmltopdf-build/wkhtmltopdf.deb

RUN VERSION=$( \
    curl -s "$GITHUB_FEED" | \
    grep '"name":' | \
    head -n 1 | \
    sed -e '1s/  "name": "//' | \
    sed -e '1s/",//' \
  ) && \
  DEB_FILE="Fulcrum_${VERSION}_amd64.deb" && \
  DOWNLOAD_URL="https://github.com/fulcrumapp/fulcrum-desktop/releases/download/v${VERSION}/${DEB_FILE}" && \
  curl -L $DOWNLOAD_URL -o /tmp/$DEB_FILE && \
  gdebi -n /tmp/$DEB_FILE && \
  rm /usr/local/bin/fulcrum && ln -s /opt/Fulcrum/scripts/* /usr/local/bin && \
  rm /tmp/$DEB_FILE

CMD 'fulcrum'
