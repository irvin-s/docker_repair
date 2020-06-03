FROM ubuntu:18.04

ENV PYTHONUNBUFFERED 1

# Install Python3
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python3 python3-pip

# Install lightgrep, bulk_extractor, and textract dependencies
RUN apt-get update && apt-get install -y \
  git \
  gcc \
  g++ \
  flex \
  make \
  autoconf \
  libewf-dev \
  libssl-dev \
  libsqlite3-dev \
  scons \
  bison \
  libboost-dev \
  libicu-dev \
  libtool \
  sleuthkit \
  libxml2-dev \
  libxslt1-dev \
  python-dev \
  antiword \
  unrtf \
  poppler-utils \
  pstotext \
  tesseract-ocr \
  flac \
  ffmpeg \
  lame \
  libmad0 \
  libsox-fmt-mp3 \
  sox \
  libjpeg-dev \
  swig \
  zlib1g-dev \
  default-jdk \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Get bulk_extractor and non-packaged dependencies
RUN git clone --recursive https://www.github.com/simsong/bulk_extractor.git
RUN git clone --recursive https://github.com/strozfriedberg/liblightgrep.git

# Build lightgrep
RUN cd liblightgrep && \
    ./bootstrap.sh && \
    ./configure --with-boost-chrono=no --with-boost-thread=no --with-boost-program-options=no --with-boost-system=no --prefix=/usr && \
    make && \
    make install && \
    ldconfig

# Build bulk_extractor
RUN cd bulk_extractor && \
    chmod 755 bootstrap.sh && \
    ./bootstrap.sh && \
    ./configure --enable-lightgrep --prefix=/usr/local && \
    make && \
    make install

WORKDIR /src

COPY . /src

# Install python dependencies
RUN pip3 install -r requirements.txt

# Install English-language spaCy models
RUN python3 -m spacy download en

# Install Apache Tika
RUN mkdir /usr/share/tika && \
    cd /usr/share/tika && \
    wget https://github.com/timothyryanwalsh/bulk-reviewer/raw/master/server/lib/tika-app-1.20.jar

EXPOSE 8000