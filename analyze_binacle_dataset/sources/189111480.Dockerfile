FROM rounds/10m-build-go

RUN go get github.com/rounds/go-slackjira

CMD cd /root/go/bin/ && ./go-slackjira
