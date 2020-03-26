FROM golang AS build
RUN go get k8s.io/client-go/rest
RUN go get k8s.io/api/admission/v1beta1
COPY . /go
RUN CGO_ENABLED=0 go build .

FROM scratch
EXPOSE 443
ENTRYPOINT ["/webhook"]
COPY --from=build /go/admission /webhook