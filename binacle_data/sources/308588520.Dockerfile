FROM alpine:3.7
LABEL maintainers="Kubernetes Authors"
LABEL description="Manila CSI Plugin"

ADD manila-csi-plugin /bin/

ENTRYPOINT ["/bin/manila-csi-plugin"]
