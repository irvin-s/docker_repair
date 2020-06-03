# We use this image instead of other like Alpine due to bugs with the renderization
FROM ubuntu:14.04

RUN mkdir -p /nomi_plots

RUN apt-get update && apt-get install -y gnuplot

# Nomi
COPY ./nomi /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/nomi"]
