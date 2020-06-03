FROM mbisi/domino901-ready-playground:latest

COPY sw-repo/domino901fp5/ /tmp/sw-repo/
ENV NUI_NOTESDIR /opt/ibm/domino/
RUN cd /tmp/sw-repo/ && bash -c "./install -script silent.dat"
RUN rm -rf /tmp/*

