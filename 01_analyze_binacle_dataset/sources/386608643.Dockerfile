FROM		golang:1.4
RUN		go get golang.org/x/tools/cmd/cover

ENV		APP_DIR	$GOPATH/src/github.com/creack/gosplice
WORKDIR		$APP_DIR

ADD		.	$APP_DIR
RUN		cd $APP_DIR && go test -v -cover .
