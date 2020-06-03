## Start with a minimal R image
FROM jangorecki/r-base-dev

MAINTAINER Conor I. Anderson <conor@conr.ca>

## Install Pandoc as per cardcorp/r-pandoc

RUN mkdir -p /opt/pandoc \
  && curl -L -O https://s3.amazonaws.com/rstudio-buildtools/pandoc-1.13.1.zip \
  && unzip -j pandoc-1.13.1.zip "pandoc-1.13.1/linux/debian/x86_64/pandoc" -d /opt/pandoc \
  && chmod +x /opt/pandoc/pandoc \
  && ln -s /opt/pandoc/pandoc /usr/local/bin \
  && unzip -j pandoc-1.13.1.zip "pandoc-1.13.1/linux/debian/x86_64/pandoc-citeproc" -d /opt/pandoc \
  && chmod +x "/opt/pandoc/pandoc-citeproc" \
  && ln -s "/opt/pandoc/pandoc-citeproc" /usr/local/bin \
  && rm -f pandoc-1.13.1.zip

## Install bookdown and clean up

RUN apt-get update -qq && apt-get install -y --no-install-recommends libxml2-dev && \
    R -q -e 'install.packages("bookdown", repo="https://cran.rstudio.com/")' && \
    apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*

CMD ["R"]
