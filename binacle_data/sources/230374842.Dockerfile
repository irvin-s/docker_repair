FROM scratch

COPY ./ui/app /ui
COPY ./build/output/auth_proxy /auth_proxy

WORKDIR /

ENTRYPOINT ["./auth_proxy"]
