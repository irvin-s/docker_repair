## Adapted from rocker/r-devel-san-clang and rocker/hadleyverse
FROM r-base:latest
MAINTAINER "Hadley Wickham" hadley@rstudio.com

## From the Build-Depends of the Debian R package, plus subversion, and clang-3.5
RUN apt-get update -qq && apt-get install -t unstable -y --no-install-recommends \
    bash-completion \
    bison \
    clang-3.6 \
    debhelper \
    default-jdk \
    g++ \
    gcc \
    gfortran \
    git \
    groff-base \
    libblas-dev \
    libbz2-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libjpeg-dev \
    liblapack-dev \
    liblzma-dev \
    libncurses5-dev \
    libpango1.0-dev \
    libpcre3-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    libx11-dev \
    libxt-dev \
    mpack \
    rsync \
    subversion \
    tcl8.5-dev \
    texinfo \
    texlive-base \
    texlive-extra-utils \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    tk8.5-dev \
    valgrind \
    x11proto-core-dev \
    xauth \
    xdg-utils \
    xfonts-base \
    xvfb \
    zlib1g-dev

## Install inconsolata by hand
RUN cd /usr/share/texlive/texmf-dist \
  && wget http://mirrors.ctan.org/install/fonts/inconsolata.tds.zip \
  && unzip inconsolata.tds.zip \
  && rm inconsolata.tds.zip \
  && echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \
  && mktexlsr \
  && updmap-sys

## Check out R-devel
RUN cd /tmp \
  && svn co http://svn.r-project.org/R/trunk R-devel \
  && R-devel/tools/rsync-recommended

## Build and install according to Dirk's standard recipe
RUN cd /tmp/R-devel \
  && R_PAPERSIZE=letter \
	   R_BATCHSAVE="--no-save --no-restore" \
	   R_BROWSER=xdg-open \
	   PAGER=/usr/bin/pager \
	   PERL=/usr/bin/perl \
	   R_UNZIPCMD=/usr/bin/unzip \
	   R_ZIPCMD=/usr/bin/zip \
	   R_PRINTCMD=/usr/bin/lpr \
	   LIBnn=lib \
	   AWK=/usr/bin/awk \
	   CFLAGS="-pipe -std=gnu99 -Wall -pedantic -g" \
	   CXXFLAGS="-pipe -Wall -pedantic -g" \
	   FFLAGS="-pipe -Wall -pedantic -g" \
	   FCFLAGS="-pipe -Wall -pedantic -g" \
	   CC="clang-3.6 -fsanitize=undefined -fno-sanitize=float-divide-by-zero,vptr,function" \
	   CXX="clang++-3.6 -fsanitize=undefined -fno-sanitize=float-divide-by-zero,vptr,function" \
	   CXX1X="clang++-3.6 -fsanitize=undefined -fno-sanitize=float-divide-by-zero,vptr,function" \
	   FC="gfortran" \
	   F77="gfortran" \
	   ./configure \
         --enable-R-shlib \
         --without-blas \
         --without-lapack \
         --with-readline \
         --disable-openmp \
  && make --jobs=4 \
  && make install \
  && make clean

## Set default CRAN repo to RStudio
RUN echo 'options("repos"="http://cran.rstudio.com")' >> /usr/local/lib/R/etc/Rprofile.site

# Useful packages -------------------------------------------------------------

# Packages needed for full R CMD check
RUN apt-get update -qq && apt-get install -t unstable -y --no-install-recommends \
    aspell \
    aspell-en \
    ghostscript \
    imagemagick \
    lmodern

# Common dev headers
RUN apt-get update -qq && apt-get install -t unstable -y --no-install-recommends \
    libcairo2-dev \
    libmysqlclient-dev \
    libpq-dev \
    libssl-dev \
    libsqlite3-dev \
    libxml2-dev

# Install biocInstaller
RUN R -q -e 'source("http://bioconductor.org/biocLite.R")'

# Install devtools and all deps
RUN install2.r -d TRUE --error devtools \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Attach devtools and testthat to match my local env
RUN echo 'if (interactive()) { \
  suppressMessages(require(devtools)); \
  suppressMessages(require(testthat)) \
}' >> /usr/local/lib/R/etc/Rprofile.site
