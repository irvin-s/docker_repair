# get the base image, this one has R, RStudio and pandoc
FROM rocker/verse:3.3.2

# required
MAINTAINER Ben Marwick <benmarwick@gmail.com>

COPY . /mjbtramp
 # go into the repo directory
RUN . /etc/environment \

  # need this for ggforce::geom_sina
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \

  # what is in /mjbtramp?
  && ls /mjbtramp \

  # build this compendium package
  && R -e "options(repos='$MRAN'); devtools::install('/mjbtramp', dep=TRUE)" \
 # render the manuscript into a docx
  && R -e "rmarkdown::render('/mjbtramp/analysis/paper/Marwick_Hayes_et_al.Rmd')"


#################### Notes to self ###############################
# a suitable disposable test env:
# docker run -dp 8787:8787 rocker/rstudio

# to build this image:
# docker build -t benmarwick/mjbtramp https://raw.githubusercontent.com/benmarwick/mjbtramp/master/Dockerfile

# to run this container to work on the project:
# docker run -dp 8787:8787  -v /c/Users/bmarwick/docker:/home/rstudio/ -e ROOT=TRUE  benmarwick/mjbtramp
# then open broswer at localhost:8787 or run `docker-machine ip default` in the shell to find the correct IP address

# go to hub.docker.com
# create empty repo for this repo ('Create Automated Build'), then

# to add CI for the docker image
# add .circle.yml file
# - Pushes new image to hub on successful complete of test
# - And gives a badge to indicate test status
# go to circle-ci to switch on this repo

# On https://circleci.com/gh/benmarwick/this_repo
# I need to set Environment Variables:
# DOCKER_EMAIL
# DOCKER_PASS
# DOCKER_USER

# Circle will push to docker hub automatically after each commit, but
# to manually update the container at the end of a work session:
# docker login # to authenticate with hub
# docker push benmarwick/mjbtramp

# When running this container, the mjbtramp dir is not writable, so we need to
# sudo chmod 777 -R mjbtramp

#

