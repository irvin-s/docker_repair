FROM mongo

ARG USERADMIN_PASS
ARG ADMIN_PASS

COPY mongo-setup.sh /
COPY db.js /
COPY *.json /
RUN chmod 755 /mongo-setup.sh
RUN echo ${USERADMIN_PASS}
RUN USERADMIN_PASS=${USERADMIN_PASS} ADMIN_PASS=${ADMIN_PASS} /mongo-setup.sh

ENTRYPOINT ["/usr/bin/mongod"]
CMD ["--auth", "--dbpath=/containerdb"]
