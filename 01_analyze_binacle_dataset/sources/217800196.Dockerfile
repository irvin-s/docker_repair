# R markdown
# See also https://cran.r-project.org/bin/linux/ubuntu/
FROM ubuntu:14.04

#ENV http_proxy 
#ENV https_proxy 
#ENV no_proxy 127.0.0.1

COPY ./cran.list.trusty /etc/apt/sources.list.d/cran.list
RUN gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 && \
    gpg -a --export E084DAB9 | sudo apt-key add - && \
    apt-get update -y && \
    apt-get install r-base r-base-dev r-recommended r-cran-rcpp -y && \
    apt-get install psmisc libapparmor1 libedit2 -y && \
    curl https://download2.rstudio.org/rstudio-server-0.99.903-amd64.deb \
        -o rstudio-server-0.99.903-amd64.deb && \
    dpkg -i rstudio-server-0.99.903-amd64.deb && \
    apt-get clean &&\ 
    ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin && \
    ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin && \
    Rscript -e 'install.packages("rmarkdown", dependencies=TRUE, repos="http://cran.ism.ac.jp")'

VOLUME "$PWD:/rdoc"
#CMD ["Rscript", "-e", "'rmarkdown::render(\"/rdoc/input.Rmd\")'" ]
