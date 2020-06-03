FROM bamos/openface
WORKDIR /root
RUN git clone git://github.com/richardstechnotes/rtndf
WORKDIR /root/src/facerec
RUN cp -r /root/rtndf/Python/facerec/* .
RUN ./get-models.sh
ENTRYPOINT ["/bin/bash", "-c", "-l", "./trainexecute"]






