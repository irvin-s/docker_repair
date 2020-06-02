FROM funcy/go:dev
RUN mkdir -p $GOPATH/src/github.com/denismakogon/emotion-recorder
ADD . $GOPATH/src/github.com/denismakogon/emotion-recorder
RUN cd $GOPATH/src/github.com/denismakogon/emotion-recorder && go build -o func
WORKDIR $GOPATH/src/github.com/denismakogon/emotion-recorder
ENTRYPOINT ["./func"]
