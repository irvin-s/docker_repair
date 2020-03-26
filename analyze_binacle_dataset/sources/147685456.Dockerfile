FROM golang:1.11 as build
ADD . /src
WORKDIR /src
RUN go get
RUN go build -o vigilant

# -------------------------------------------

FROM gcr.io/distroless/base
COPY --from=build /src/vigilant /vigilant
USER 10000:10000
EXPOSE 8000
ENTRYPOINT [ "/vigilant" ]
