## see https://github.com/pbhogale/gpu-keras-rstudio

FROM nvidia/cuda:9.0-cudnn7-runtime


MAINTAINER "prasanna bhogale"

ENV CRAN_URL https://cloud.r-project.org/

RUN set -e \
	&& apt-get -y update \
    && apt-get -y install apt-utils libapparmor1 libcurl4-openssl-dev libxml2-dev libssl-dev gdebi-core apt-transport-https pandoc libssh2-1-dev libpython2.7 python-pip imagemagick libxt-dev libxml2-dev xterm

RUN set -e \
    && grep '^DISTRIB_CODENAME' /etc/lsb-release \
    | cut -d = -f 2 \
    | xargs -I {} echo "deb ${CRAN_URL}bin/linux/ubuntu {}/" \
    | tee -a /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
    && apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y --no-install-recommends \
    r-base \
    r-base-dev \
    r-cran-littler \
    && apt-get -y autoremove \
    && apt-get clean


RUN set -e \
    && apt-get install -y curl \
    && curl -sS https://s3.amazonaws.com/rstudio-server/current.ver \
    | xargs -I {} curl -sS http://download2.rstudio.org/rstudio-server-{}-amd64.deb -o /tmp/rstudio.deb \
    && gdebi -n /tmp/rstudio.deb \
    && rm -rf /tmp/* \
    && apt-get -y autoremove \
    && apt-get clean

RUN set -e \
    && useradd -m -d /home/rstudio rstudio \
    && echo rstudio:rstudioTheLegendOfZelda \
    | chpasswd \
    && apt-get -y autoremove \
    && apt-get clean

RUN set -e \
    && grep '^DISTRIB_CODENAME' /etc/lsb-release \
    | cut -d = -f 2 \
    | xargs -I {} echo "deb ${CRAN_URL}bin/linux/ubuntu {}/" \
    | tee -a /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 \
	&& apt-get update \
    && apt-get upgrade -y -q \
    && pip install --upgrade pip==9.0.3 \
    && pip install virtualenv \
    && pip install pelican \
    && rm -rf .cache \
    && echo 'options(repos = c(CRAN = "https://cloud.r-project.org"))' >> /etc/R/Rprofile.site \
    && /usr/lib/R/site-library/littler/examples/install.r tensorflow keras \
	&& r -e "install.packages(c('devtools', 'keras', 'xgboost', 'tidyverse', 'rmarkdown', 'greta', 'usethis', 'docopt'))" \
	&& r -e "keras::install_keras(tensorflow = 'gpu')" \
    && apt-get -y autoremove \
    && apt-get clean

## Add LaTeX, rticles and bookdown support
## uses dummy texlive, see FAQ 8: https://yihui.name/tinytex/faq/
RUN apt-get install -y --no-install-recommends wget software-properties-common python-software-properties\
	&& add-apt-repository -y ppa:opencpu/jq \
	&& apt-get update \
	&& wget "https://travis-bin.yihui.name/texlive-local.deb" \
	&& dpkg -i texlive-local.deb \
	&& rm texlive-local.deb \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
    	## for rJava
    	default-jdk \
    	## Nice Google fonts
    	fonts-roboto \
    	## used by some base R plots
    	ghostscript \
    	## used to build rJava and other packages
    	libbz2-dev \
    	libicu-dev \
    	liblzma-dev \
    	## system dependency of hunspell (devtools)
    	libhunspell-dev \
    	## system dependency of hadley/pkgdown
    	libmagick++-dev \
    	## rdf, for redland / linked data
    	librdf0-dev \
    	## for V8-based javascript wrappers
    	libv8-dev \
    	## for jq queries
    	libjq-dev \
    	## R CMD Check wants qpdf to check pdf sizes, or throws a Warning
    	qpdf \
    	## For building PDF manuals
    	texinfo \
    	## for git via ssh key
    	ssh \
   		## just because
    	less \
    	vim \
        git-all \
  	&& apt-get clean \
  	&& rm -rf /var/lib/apt/lists/ \
  	## Use tinytex for LaTeX installation
  	&& wget -qO- \
    "https://github.com/yihui/tinytex/raw/master/tools/install-unx.sh" | \
    sh -s - --admin --no-path \
  	&& mv ~/.TinyTeX /opt/TinyTeX \
  	&& /opt/TinyTeX/bin/*/tlmgr path add \
  	&& tlmgr install metafont mfware inconsolata tex ae parskip listings \
  	&& tlmgr path add \
  	&& Rscript -e "source('https://install-github.me/yihui/tinytex'); tinytex::r_texmf()" \
  	&& chown -R root:staff /opt/TinyTeX \
  	&& chmod -R g+w /opt/TinyTeX \
  	&& chmod -R g+wx /opt/TinyTeX/bin \
 	## And some nice R packages for publishing-related stuff
  	&& /usr/lib/R/site-library/littler/examples/install2.r --error --deps TRUE \
	bookdown rticles rmdshower DT DiagrammeR bayesplot

RUN pip install typogrify pygments markdown beautifulsoup4 \
	&& rm -rf .cache \
	&& git clone --recursive https://github.com/getpelican/pelican-themes ~/pelican-themes \
	&& pelican-themes -i ~/pelican-themes/Flex \
    && pelican-themes -i ~/pelican-themes/elegant \
    && pelican-themes -i ~/pelican-themes/pelican-bootstrap3 \
	&& git clone --recursive https://github.com/getpelican/pelican-plugins ~/pelican-plugins

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libglu1-mesa-dev \
    && apt-get autoremove \
    && apt-get clean \
    && /usr/lib/R/site-library/littler/examples/install2.r --error --deps TRUE \
    vars prophet fanplot chron tseriesEntropy tseriesChaos pdfetch Quandl factorstochvol \
    wavelets Risk fGarch \
    && pelican-themes -i ~/pelican-themes/pelican-bootstrap3

RUN apt-get install -y --no-install-recommends libgsl-dev \
    && /usr/lib/R/site-library/littler/examples/install2.r --error --deps TRUE \
    tidytext janeaustenr shiny wordcloud sentimentr stringr gutenbergr ggthemes rsconnect

EXPOSE 8787

CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0", "--server-app-armor-enabled=0"]

