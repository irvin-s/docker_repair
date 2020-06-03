FROM scratch

ADD ${ARTIFACTS_PATH}/${EXEC_NAME} /
ADD ${ARTIFACTS_PATH}/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

CMD ["/${EXEC_NAME}"]
