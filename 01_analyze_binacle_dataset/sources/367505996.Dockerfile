FROM ros:kinetic-ros-base-xenial
MAINTAINER Andrea Censi

# ARG DEBIAN_FRONTEND=noninteractive
# RUN apt-get install dialog apt-utils

RUN apt-get update

RUN apt-get install -y \
    ros-kinetic-perception=1.3.1-0*

RUN apt-get install -y \
    ros-kinetic-desktop-full \
    ros-kinetic-tf-conversions \
    ros-kinetic-cv-bridge \
    ros-kinetic-image-transport \
    ros-kinetic-camera-info-manager \
    ros-kinetic-theora-image-transport \
    ros-kinetic-joy \
    ros-kinetic-image-proc \
    ros-kinetic-compressed-image-transport \
    ros-kinetic-phidgets-drivers \
    ros-kinetic-imu-complementary-filter \
    ros-kinetic-imu-filter-madgwick


# needed for adding repository

RUN apt-get update
RUN apt-get install -y \
    software-properties-common \
    gnupg \
    curl

# Git LFS

RUN add-apt-repository -y ppa:git-core/ppa
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

RUN apt-get update

RUN apt-get install -y \
    git \
    git-extras \
    ssh \
    pdftk \
    bibtex2html \
    libxml2-dev \
    libxslt1-dev \
    libffi6 \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    pdftk \
    bibtex2html \
    build-essential \
    graphviz \
    idle \
    virtualenv \
    python-pmw \
    python-imaging \
    python-yaml \
    python-dev \
    python-matplotlib \
    python-numpy \
    python-matplotlib \
    python-setproctitle \
    python-psutil \
    python-lxml \
    python-pillow \
    python-matplotlib \
    python-pip \
    python-tk \
    python-scipy \
    python-frozendict \
    python-tables \
    python-sklearn \
    python-termcolor \
    python-setproctitle \
    python-psutil\
    byobu \
    atop \
    htop \
    imagemagick \
    graphviz \
    ghostscript \
    git-lfs \
    ntpdate  \
    libatlas-base-dev \
    vim\
    apt-file\
    iftop\
    node-less

# Python deps

RUN pip install -U \
    empy\
    catkin_pkg\
    pint \
    networkx \
    watchdog \
    pyramid \
    pyramid_jinja2 \
    pyramid_debugtoolbar \
    bs4 \
    nose \
    reprep \
    bcrypt \
    markdown \
    junit_xml \
    lxml \
    bcrypt \
    waitress \
    gitpython \
    webtest \
    chardet



RUN wget https://www.princexml.com/download/prince_11.3-1_ubuntu16.04_amd64.deb && dpkg -i prince_11.3-1_ubuntu16.04_amd64.deb


# RUN rm -rf /var/lib/apt/lists/*

RUN  add-apt-repository ppa:mc3man/xerus-media
# RUN add-apt-repository ppa:mc3man/trusty-media
RUN apt-get update
RUN apt-get install -y  mplayer mencoder ffmpeg
# gstreamer0.10-ffmpeg


# Other stuff for Duckiebot / duckietop


RUN apt-get install -y clang

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get update
RUN apt-get install -y nodejs
RUN npm install MathJax-node jsdom@9.3 less
