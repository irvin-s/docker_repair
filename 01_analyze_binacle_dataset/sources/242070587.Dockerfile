FROM mongo:3.4

EXPOSE 27017

RUN apt-get update && \
    apt-get install -yqq \
      python3 \
      python3-pip \
      python3-dev \
      pkg-config \
      software-properties-common \
      git \
      vim \
      libxml2-dev \
      libxslt1-dev \
      zlib1g-dev \
      libffi6 \
      build-essential \
      libssl-dev \
      libffi-dev
      
RUN mkdir /home/cve
WORKDIR /home/cve
    
RUN git clone https://github.com/cve-search/cve-search.git
WORKDIR /home/cve/cve-search
RUN pip3 install -r requirements.txt

COPY ./scripts/docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["-i"]