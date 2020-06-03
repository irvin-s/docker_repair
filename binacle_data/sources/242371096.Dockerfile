FROM jacopomauro/hyvarrec
MAINTAINER Jacopo Mauro

# install required packages adn download repository
RUN cd /  && \
    apt-get update && \
	apt-get install -y rsync sshpass && \
    rm -rf /var/lib/apt/lists/* && \
	pip install click lrparsing z3-solver pysmt requests && \
	git clone --depth 1 https://github.com/HyVar/gentoo_to_mspl.git

# hyvar-rec in /bin
RUN echo '#!/bin/bash' >> /bin/hyvar-rec && \
    echo 'python /hyvar-rec/hyvar-rec.py "$@"' >> /bin/hyvar-rec && \
    chmod 770 /bin/hyvar-rec

WORKDIR /gentoo_to_mspl