FROM rocker/geospatial:3.5.0

VOLUME /output

RUN apt-get update && apt-get install -y curl
RUN R -e 'install.packages(c("ggthemes"))'
RUN cd /tmp && curl -O https://raw.githubusercontent.com/scottcame/shiny-docker-demo/master/australia-elex-2016/Notebook.Rmd

CMD ["R", "-e", "rmarkdown::render('/tmp/Notebook.Rmd', output_file='/output/Notebook.html')"]
