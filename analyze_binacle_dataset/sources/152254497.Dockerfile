FROM rocker/verse:3.5.2

RUN install2.r DiagrammeR
RUN install2.r usethis
RUN install2.r printr
