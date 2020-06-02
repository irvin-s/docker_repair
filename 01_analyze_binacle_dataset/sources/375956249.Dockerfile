# First stage: Frontend
FROM library/node:11.7.0-alpine AS front_builder

# Install dependencies
WORKDIR /app
COPY web/package.json \
     web/package-lock.json \
     /app/
RUN npm install

# Build
COPY web /app
RUN npm run build

# Second stage: Backend
FROM library/golang:1.11.4-alpine AS back_builder

RUN  mkdir -p /go/src \
     && mkdir -p /go/bin \
     && mkdir -p /go/pkg
RUN apk add --no-cache git 

ENV GOPATH=/go
ENV GO111MODULE=on
ENV PATH=${GOPATH}/bin:$PATH   

# Prepare module
WORKDIR ${GOPATH}/src/github.com/pcorbel/techline
COPY vendor ${GOPATH}/src/github.com/pcorbel/techline/

# Build
COPY cmd ${GOPATH}/src/github.com/pcorbel/techline/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o techline-amd64 .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -a -installsuffix cgo -o techline-arm32v6 .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -installsuffix cgo -o techline-arm64v8 .

# Final stage
FROM __BASEIMAGE_ARCH__/alpine:3.8

RUN apk add --no-cache ca-certificates

WORKDIR /app
COPY --from=front_builder /app/dist /app/web/dist
COPY --from=back_builder /go/src/github.com/pcorbel/techline/techline-__BASEIMAGE_ARCH__ /app/techline
COPY configs /app/configs

CMD ./techline
