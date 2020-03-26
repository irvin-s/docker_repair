FROM python:2.7.13-alpine3.6

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      version.image="1.0.0" \
      version.roslin-qc="0.5.8" \
      version.r="3.3.3-r0" \
      version.alpine="3.5.x"

ENV ROSLIN_QC_VERSION 0.5.8
ENV R_VERSION 3.3.3-r0

COPY mysql-connector-python-2.1.6.tar.gz /tmp/mysql-connector-python-2.1.6.tar.gz
COPY install-packages.R /tmp/install-packages.R
COPY roslin-qc-${ROSLIN_QC_VERSION}.tar.gz /tmp/roslin-qc-${ROSLIN_QC_VERSION}.tar.gz

RUN apk add --update \
    # for wget
    && apk add ca-certificates openssl \
    # for compilation
    && apk add build-base musl-dev \
    # hashlib does not like pip for some reason
    && easy_install hashlib \
    # install mysql connector
    && cd /tmp \
	&& pip install mysql-connector-python-2.1.6.tar.gz \
	# install pandas
	&& easy_install pandas \
	# install python dependencies
	&& pip install fnmatch2 dbconfig argparse \
	# install R
	&& apk add R=${R_VERSION} R-dev=${R_VERSION} R-doc=${R_VERSION} \
	# install R dependencies
	&& Rscript --vanilla install-packages.R \
	# install java and perl
	&& apk add openjdk8-jre-base perl \
	# unpack roslin-qc
	&& tar xvzf roslin-qc-${ROSLIN_QC_VERSION}.tar.gz \
	# FIX ALL THESE WRONG FILE PATHS
	&& cd roslin-qc-${ROSLIN_QC_VERSION} \
	&& sed -i[.bak] "s/opt\/common\/CentOS_6-dev\//usr\//g" *.pl \
	&& sed -i[.bak] "s/opt\/common\/CentOS_6\/python\/python-2.7.8\//usr\/local\//g" *.py \
	&& sed -i[.bak] "s/opt\/common\/CentOS_6\/R\/R-3.2.0\//usr\//g" *.R \
	&& sed -i[.bak] "s/opt\/common\//usr\/local\//g" *.py \
	# Install perl dependency needed
	&& perl -MCPAN -e 'install Tie::IxHash' \
	# send scripts to the bin directory
	&& cp -r /tmp/roslin-qc-${ROSLIN_QC_VERSION}/* /usr/bin \
	# clean up
	&& rm -rf /tmp/*

ENV PYTHONNOUSERSITE set

ENTRYPOINT ["python", "/usr/bin/generate_pdf.py"]
