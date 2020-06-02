FROM r-base
RUN apt-get update && apt-get install -y curl jq libcurl4-gnutls-dev
RUN R -e 'install.packages("Rbitcoin", repos=c("https://jangorecki.gitlab.io/Rbitcoin","https://cran.rstudio.com"))'
ADD rbitcoin.R /
