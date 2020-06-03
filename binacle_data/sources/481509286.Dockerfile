FROM docker:stable-dind
COPY ./build/dockerbox /dockerbox
COPY ./dockerbox.toml /dockerbox.toml
ENTRYPOINT ["/dockerbox"]
