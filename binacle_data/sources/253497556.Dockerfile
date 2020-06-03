FROM golang
RUN echo "Asia/Shanghai" > /etc/timezone
RUN go get -u github.com/Bpazy/wl520/...
ENTRYPOINT ["wl520cron", "-wlc", "/etc/wl520/wl520.json", "-c", "/etc/wl520/wl520cron.json"]
