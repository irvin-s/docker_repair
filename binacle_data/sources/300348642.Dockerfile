# i386
FROM {{.BaseImage}}:{{.BaseImageTag}}
WORKDIR /opt
COPY ./build/{{.AppName}}.run /opt/{{.AppName}}
CMD ["./{{.AppName}}", "-c", "/opt/config.json"]