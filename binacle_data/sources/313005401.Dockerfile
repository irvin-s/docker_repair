FROM golang:1.12.5 AS builder
WORKDIR /src
COPY go.mod go.sum ./
ARG GITHUB_TOKEN
RUN git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/mesosphere".insteadOf "https://github.com/mesosphere"
RUN go mod download
COPY . .
RUN make build

# Copy the "dklb" binary from the "builder" container.
FROM gcr.io/distroless/static:a4fd5de337e31911aeee2ad5248284cebeb6a6f4
LABEL name=mesosphere/dklb
ARG VERSION
LABEL version=${VERSION}
COPY --from=builder /src/build/dklb /dklb
ENV CLUSTER_NAME ""
ENV POD_NAME ""
ENV POD_NAMESPACE ""
EXPOSE 10250
CMD ["/dklb", "-h"]
