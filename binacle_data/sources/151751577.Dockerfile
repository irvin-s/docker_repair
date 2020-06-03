FROM mafintosh/mongodb:2.6.5
USER root
RUN touch /root/.mongorc.js
ENTRYPOINT ["/usr/bin/mongo"]
