FROM alpine

USER 1001
COPY bin/linux/openshift-lb-controller .
ENTRYPOINT ["./openshift-lb-controller"]
