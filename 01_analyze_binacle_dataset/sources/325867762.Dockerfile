FROM 	10.11.3.8:5000/user-images/lcb-py2735-pytorch

MAINTAINER szh

RUN LC_ALL=C
RUN pip3 install matplotlib
