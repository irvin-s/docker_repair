# escape=`
FROM plugins/base:windows-1809

LABEL maintainer="Drone.IO Community <drone-dev@googlegroups.com>" `
  org.label-schema.name="Drone IRC" `
  org.label-schema.vendor="Drone.IO Community" `
  org.label-schema.schema-version="1.0"

ADD release/windows/amd64/drone-irc.exe C:/bin/drone-irc.exe
ENTRYPOINT [ "C:\\bin\\drone-irc.exe" ]
