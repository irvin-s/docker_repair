FROM nils/domino:9.0.1-fp8

EXPOSE 25 80 443 1352

COPY resources/docker-entrypoint.sh /
RUN chmod 775 /docker-entrypoint.sh
RUN apt-get update && \
    apt-get -y install nodejs npm python build-essential && \
    rm -rf /var/lib/apt/lists/* && \ 
    wget -q http://172.17.0.1:7777/notesapi.tar.gz && \
    tar -xf notesapi.tar.gz -C /opt/ibm/ && \
    mkdir /home/notes/samples && \
    cp -a /opt/ibm/notesapi/samples/. /home/notes/samples && \
    ln -s /opt/ibm/domino/notes/latest/linux/libnotes.so /usr/lib/libnotes.so && \
    ln -s /opt/ibm/domino/notes/latest/linux/libndgts.so /usr/lib/libndgts.so && \
    ln -s /opt/ibm/domino/notes/latest/linux/libxmlproc.so /usr/lib/libxmlproc.so && \
    ln -s /opt/ibm/domino/notes/latest/linux/libgsk8iccs_64.so /usr/lib/libgsk8iccs_64.so && \
    npm install -g n && \
    n stable && \
    npm install -g node-gyp nan
    

USER notes
WORKDIR /local/notesdata
ENV LOGNAME=notes
ENV LOTUS=/opt/ibm
ENV Notes_ExecDirectory=/opt/ibm/domino/notes/latest/linux
ENV NOTES_DATA_DIR=/local/notesdata
ENV DOMINO_RES_DIR=/opt/ibm/domino/notes/latest/res/C

ENV PATH=$PATH:/opt/ibm/domino/:$Notes_ExecDirectory:$NOTES_DATA_DIR:$DOMINO_RES_DIR

ENTRYPOINT ["/docker-entrypoint.sh"]
