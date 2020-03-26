FROM rocker/tidyverse:latest

RUN R -e "install.packages('flexdashboard')"
RUN R -e "install.packages('tidytext')"
RUN R -e "install.packages('quanteda')"
RUN R -e "install.packages('stm')"

ADD topic_model.rda /home/rstudio/
ADD sherlock_dfm.rda /home/rstudio/
ADD sherlock-topic-model-app.Rmd /home/rstudio/
