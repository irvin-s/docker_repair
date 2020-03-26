FROM xeor/base-centos

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-10-25

ENV DEPENDING_ENVIRONMENT_VARS SICKBEARD_URL SICKBEARD_API_KEY

# Force python3's stdin/stdout encoding to be utf-8, instead of guessing..
ENV PYTHONIOENCODING utf-8

RUN yum localinstall -y https://www.softwarecollections.org/en/scls/rhscl/python33/epel-7-x86_64/download/rhscl-python33-epel-7-x86_64.noarch.rpm && \
    yum localinstall -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum install -y scl-utils python33 ffmpeg && \
    scl enable python33 'easy_install pip' && \
    scl enable python33 'pip install ipython requests beautifulsoup4'

COPY init/ /init/
ADD worker.py /
