FROM ubuntu:bionic
RUN apt-get update
RUN apt-get install -y build-essential software-properties-common openjdk-8-jdk
RUN export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
RUN apt-get update
RUN add-apt-repository ppa:webupd8team/java && apt-get update
RUN apt-get update
RUN apt-get install -y maven \
    python3-dev python3-pip python3-virtualenv \
    libsasl2-dev libldap2-dev libssl-dev \
    nodejs
RUN apt-get install -y npm
RUN npm install avrodoc -g
ENV PYTHONUNBUFFERED 1
RUN mkdir /gel
RUN mkdir /gel/GelReportModels
WORKDIR /gel
ADD . /gel/GelReportModels
RUN mkdir -p ~/.m2
WORKDIR /gel/GelReportModels
RUN pip3 install --upgrade pip==18.0
ENV GEL_REPORT_MODELS_PYTHON_VERSION 3
RUN pip3 install .
