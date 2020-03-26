ARG TAG=5.7

FROM mysql:$TAG

# ARG EXP=3306

LABEL mantainer="developer@fabriziocafolla.com"
LABEL description="MySQL Container"

# EXPOSE $EXP