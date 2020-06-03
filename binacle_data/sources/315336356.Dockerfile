FROM rocker/tidyverse:3.5

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image that extends the rocker tidyverse image to include support for MariaDB" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/tidyverse-mariadb"

RUN apt-get update && apt-get install -y libmariadbclient-dev && R -e 'install.packages("RMariaDB")'
