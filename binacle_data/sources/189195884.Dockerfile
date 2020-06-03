FROM bigm/base-deb

# install rsync
RUN /xt/tools/_apt_install rsync

# interact with S3 bucket
RUN /xt/tools/_apt_install python-pip \
  && pip install python-magic s3cmd

ADD startup/* /prj/startup/
VOLUME /data/prj

# rsync
ENV DOWNLOAD_RSYNC ""

# Amazon S3
ENV DOWNLOAD_S3 ""
ENV AWS_ACCESS_KEY ""
ENV AWS_SECRET_KEY ""
