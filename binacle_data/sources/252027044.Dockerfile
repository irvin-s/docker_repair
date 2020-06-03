## Based on instructions by joukhaha (https://github.com/sharelatex/sharelatex/issues/460#issuecomment-283598664)

FROM  sharelatex/sharelatex:latest

MAINTAINER  Conor I. Anderson <conor@conr.ca>

COPY LatexRunner.patch /tmp/

RUN patch /var/www/sharelatex/clsi/app/js/LatexRunner.js /tmp/LatexRunner.patch

RUN  codename=$(cat /etc/*-release | grep 'DISTRIB_CODENAME=' | sed 's/DISTRIB_CODENAME=//g') &&\
  echo "deb https://cloud.r-project.org/bin/linux/ubuntu/ $codename/" >> /etc/apt/sources.list &&\
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 &&\
  apt-get update && apt-get install -y --no-install-recommends libssl-dev libcurl4-openssl-dev libxml2-dev r-base r-base-dev &&\
  apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*

RUN  Rscript -e "install.packages(c('knitr', 'patchSynctex', 'knitcitations'), repos = 'https://cloud.r-project.org/')"

COPY latexmk /usr/local/share/latexmk/latexmk
