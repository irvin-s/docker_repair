FROM ros:kinetic-ros-base-xenial
MAINTAINER Andrea Censi

RUN apt-get update

RUN apt-get install -y \
    software-properties-common \
    gnupg \
    curl \
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
    ntpdate  \
    libatlas-base-dev \
    vim\
    apt-file\
    iftop\
    ros-kinetic-image-proc
#    ros-kinetic-perception \
#    ros-kinetic-desktop-full \
#    ros-kinetic-tf-conversions \
#    ros-kinetic-cv-bridge \
#    ros-kinetic-image-transport \
#    ros-kinetic-camera-info-manager \
#    ros-kinetic-theora-image-transport \
#    ros-kinetic-joy \
#    ros-kinetic-compressed-image-transport \
#    ros-kinetic-phidgets-drivers \
#    ros-kinetic-imu-complementary-filter \
#    ros-kinetic-imu-filter-madgwick \



# needed for adding repository


# Git LFS

#RUN add-apt-repository -y ppa:git-core/ppa
#RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
#
#RUN apt-get update

#RUN apt-get install -y git-lfs \


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


RUN add-apt-repository ppa:mc3man/xerus-media
RUN apt-get update
RUN apt-get install -y  mplayer mencoder ffmpeg
# gstreamer0.10-ffmpeg


RUN wget https://dist.ipfs.io/go-ipfs/v0.4.15/go-ipfs_v0.4.15_linux-amd64.tar.gz
RUN tar xvzf go-ipfs_v0.4.15_linux-amd64.tar.gz
RUN cp go-ipfs/ipfs /usr/bin
RUN ipfs version


RUN virtualenv --system-site-packages /project/deploy

COPY requirements.txt  /project/requirements.txt

RUN pip install -r /project/requirements.txt

COPY . /project/10-infrastructure



RUN . /project/deploy/bin/activate && cd /project/10-infrastructure && python setup.py install
#RUN . /project/deploy/bin/activate && cd /project/10-infrastructure && python setup.py develop --no-deps

RUN chmod +x /project/10-infrastructure/entrypoint.sh

RUN /project/10-infrastructure/entrypoint.sh python -c "import easy_logs.cli"

ENTRYPOINT ["/project/10-infrastructure/entrypoint.sh"]

RUN mkdir -p \
    /dt-data/DUCKIETOWN_ROOT \
    /dt-data/DUCKIEFLEET_ROOT \
    /dt-data/DUCKIETOWN_DATA \
    /dt-data/DUCKIETOWN_TMP
ENV DUCKIETOWN_ROOT=/dt-data/DUCKIETOWN_ROOT
ENV DUCKIEFLEET_ROOT=/dt-data/DUCKIEFLEET_ROOT
ENV DUCKIETOWN_DATA=/dt-data/DUCKIETOWN_DATA
ENV DUCKIETOWN_TMP=/dt-data/DUCKIETOWN_TMP

# XXX 
RUN cp /project/10-infrastructure/easy_logs/include/easy_logs/unit_tests.urls.yaml /project/deploy/lib/python2.7/site-packages/DuckietownUtils-1.0-py2.7.egg/easy_logs

RUN /project/10-infrastructure/entrypoint.sh dt-logs-summary
