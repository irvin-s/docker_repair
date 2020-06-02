FROM rounds/10m-build-go
RUN apt-get update && \
  apt-get install  wget

RUN go get github.com/rounds/annona

EXPOSE 5000

RUN wget -O /root/go/bin/avatars.json https://raw.githubusercontent.com/rounds/annona/master/avatars.json

CMD cd /root/go/bin/ && ./annona

