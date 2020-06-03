FROM postgres:9.4

RUN apt-get update && \
    apt-get install less && \
    rm -rf /var/lib/apt/lists/*

RUN echo "\\\timing\n\\pset pager on\n\\setenv LESS '-iMSx4 -FX'\n" > ~/.psqlrc

