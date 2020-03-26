FROM python:2.7-wheezy

WORKDIR /root
RUN git clone https://LaNMaSteR53@bitbucket.org/LaNMaSteR53/recon-ng.git
WORKDIR /root/recon-ng
RUN pip install -r REQUIREMENTS

CMD git pull && python recon-ng
