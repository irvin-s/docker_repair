FROM python:2.7

ARG http_proxy=
ARG https_proxy=

RUN if [ ! -z "$https_proxy" ]; then export https_proxy=$https_proxy; fi \
    && if [ ! -z "$http_proxy" ]; then export http_proxy=$http_proxy; fi \
    && apt-get update && apt-get install -y unzip \
    && pip install pyopenssl \
    && pip install gitpython \
    && pip install requests \
    && unset http_proxy \
    && unset https_proxy
    
ADD azure-apim.zip /azure-apim.zip
RUN unzip azure-apim.zip
COPY scripts/azure_apim.sh /azure_apim.sh

ENTRYPOINT ["/azure_apim.sh"]
