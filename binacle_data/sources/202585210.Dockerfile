FROM quay.io/deis/base:v0.3.6

COPY . /

CMD ["/bin/boot"]
EXPOSE 8080
