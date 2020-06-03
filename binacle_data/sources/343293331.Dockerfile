FROM	ubuntu

RUN	apt-get install -y golang
RUN	go test -v
