FROM debian:sid

WORkDIR /usr/local/share
RUN apt-get update && \
    apt-get install -y latexmk texlive-full && \
    rm -rf /var/cache/*

ENTRYPOINT ["latexmk"]
