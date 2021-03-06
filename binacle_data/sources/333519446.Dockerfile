FROM ubuntu:18.04

# Install packages for building HIRS
RUN apt-get update -y && apt-get upgrade -y && apt-get clean -y
RUN apt-get -y install autoconf autoconf-archive automake libtool pkg-config m4 openjdk-8-jdk protobuf-compiler build-essential devscripts lintian debhelper cmake make git g++ doxygen graphviz cppcheck liblog4cplus-dev libssl-dev libprotobuf-dev libre2-dev libsapi-dev trousers libtspi-dev libcurl4-openssl-dev

# Install Newer TPM2-TSS & TPM2-Abrmd from Source for Building HIRS_ProvisionerTPM2
RUN apt-get -y install wget libdbus-1-dev libglib2.0-dev
RUN mkdir tpm2tss && cd tpm2tss && wget https://github.com/tpm2-software/tpm2-tss/releases/download/1.3.0/tpm2-tss-1.3.0.tar.gz && tar -xzf tpm2-tss-1.3.0.tar.gz && cd tpm2-tss-1.3.0 && ./configure && make && make install && cd ../ && cd ../
RUN mkdir tpm2abrmd && cd tpm2abrmd && wget https://github.com/tpm2-software/tpm2-abrmd/releases/download/1.3.1/tpm2-abrmd-1.3.1.tar.gz && tar -xzf tpm2-abrmd-1.3.1.tar.gz && cd tpm2-abrmd-1.3.1 && ./configure && make && make install && cd ../ && cd ../

# Set Environment Variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
