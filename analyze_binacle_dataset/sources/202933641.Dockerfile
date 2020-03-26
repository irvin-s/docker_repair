FROM mbisi/domino901-install:latest

# Set the init service as entrypoint to have domino start with the image
#ENTRYPOINT exec /etc/init.d/rc_domino monitor
ENTRYPOINT su - notes -c "cd /local/notesdata; /opt/ibm/domino/bin/server"
EXPOSE 80 443 1352

COPY sw-repo/serverconfig/* /local/notesdata/

# Perform silent configuration of the server based on recorded profile
RUN su notes -c "cd /local/notesdata && /opt/ibm/domino/bin/server -silent /local/notesdata/playground.pds /local/notesdata/playground.txt"

VOLUME ["/local/notesdata"]


