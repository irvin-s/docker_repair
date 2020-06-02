FROM scratch
COPY ./build/linux/brew-manage /brew-manage
ENTRYPOINT ["/brew-manage"]
