ARG TAG=5.0.4-alpine3.9

FROM redis:$TAG

# ARG EXP=6379

LABEL mantainer="developer@fabriziocafolla.com"
LABEL description="Redis Container"

# EXPOSE $EXP