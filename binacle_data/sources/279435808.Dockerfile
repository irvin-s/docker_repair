FROM alpine

COPY meltdown /capsule8-meltdown-detector
CMD ["/capsule8-meltdown-detector"]
