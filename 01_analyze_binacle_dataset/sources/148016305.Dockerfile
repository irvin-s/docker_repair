FROM golang:1.11 as builder

WORKDIR /go/src/github.com/tokend/terraform-provider-tokend
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /terraform-provider-tokend -v github.com/tokend/terraform-provider-tokend


FROM hashicorp/terraform:0.11.11
WORKDIR /opt
COPY --from=builder /terraform-provider-tokend /bin/terraform-provider-tokend
