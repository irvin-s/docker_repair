## Get Jeffreys Image
FROM jeffreyhorner/r-array-hash

## Install requirements
RUN mkdir -p ~/R312 && \
    mkdir -p ~/R320 && \
    R --quiet -e '.libPaths("~/R312"); install.packages(c("devtools", "microbenchmark"));devtools::install_github("jeroenooms/jsonlite");' > /dev/null 2>&1 && \
    RD --quiet -e '.libPaths("~/R320"); install.packages(c("devtools", "microbenchmark"));devtools::install_github("jeroenooms/jsonlite");' > /dev/null 2>&1

## The actual benchmarks
RUN R --quiet -e '.libPaths("~/R312"); library(ggplot2); library(microbenchmark); suppressMessages(library(jsonlite)); json <- toJSON(diamonds); print(microbenchmark(toJSON(diamonds), fromJSON(json), times = 20));' && \
    RD --quiet -e '.libPaths("~/R320"); library(ggplot2); library(microbenchmark); suppressMessages(library(jsonlite)); json <- toJSON(diamonds); print(microbenchmark(toJSON(diamonds), fromJSON(json), times = 20));'
