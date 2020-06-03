FROM scratch
COPY registry-ui /
COPY views/ /views
CMD ["/registry-ui"]
