FROM golang as builder
ADD . /go/src/github.com/HFO4/plus1s.live
RUN CGO_ENABLED=0 go build /go/src/github.com/HFO4/plus1s.live/stream.go

CMD ["/go/stream"]

##########
FROM alpine
COPY --from=builder /go/stream / 
COPY --from=builder /go/src/github.com/HFO4/plus1s.live/pic /pic
CMD ["/stream"]