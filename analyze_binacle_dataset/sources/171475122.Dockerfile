# Version 0.0.4
FROM opensuse:leap
MAINTAINER Sean Cummins "sean.cummins@emc.com"
RUN zypper -n install zsh glibc-32bit gcc-32bit tar git sudo hostname man wget libopenssl-devel-32bit python-pip python3-pip vim strace curl ca-certificates-mozilla
RUN pip install prettytable
RUN mkdir /scripts
WORKDIR /scripts
RUN git clone https://github.com/seancummins/fast_report.git
RUN git clone https://github.com/seancummins/sgcapreport.git
RUN ln -s /scripts/fast_report/fastvp_report.py /usr/bin/fastvp_report.py
RUN ln -s /scripts/sgcapreport/sgcapreport.py /usr/bin/sgcapreport.py
