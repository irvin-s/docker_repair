# Copyright 2017 - Dechain User Group
# Ethereum Smart-Contracts Dapp based development environment

FROM docker_eth-polygon
LABEL name=dapphub-dapp

RUN echo "installing dapphub/dapp" \
	&& cd ~/tools \
	&& git clone https://github.com/dapphub/dapp.git \
	&& cd dapp && git checkout 26acb91 \
	&& sudo make link
