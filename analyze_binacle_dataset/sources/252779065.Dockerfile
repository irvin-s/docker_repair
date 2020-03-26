ARG X_DCKR_TAG=edge  
FROM alpine:$X_DCKR_TAG  
MAINTAINER B. van Berkum <dev@dotmpe.com>  
  
RUN apk update && \  
apk add --no-cache \  
ncurses jq curl \  
bash bats && \  
rm -rf /var/cache/apk/*  
  
ARG X_DCKR_PREFIX=x-docker  
ARG X_DCKR_BASENAME=alpine-bats  
ARG X_DCKR_NAME=$X_DCKR_PREFIX/$X_DCKR_BASENAME  
  
ENV X_DCKR_CMD=/usr/bin/bats  
ENV X_DCKR_APK=""  
  
# Generate entry point script  
RUN printf "#!/bin/sh\n\  
set -e\n\  
test -z \"\$X_DCKR_APK\" || {\n\  
echo \"$X_DCKR_NAME: Installing additional packages '\$X_DCKR_APK'\" >&2\n\  
apk update \  
&& apk add --no-cache \$X_DCKR_APK\n\  
}\n\  
test \"\$1\" = \"\--\" && { shift\n\  
echo \"$X_DCKR_NAME: Running script, remaining argv: \$*\" >&2;\n\  
while test \$# -ne 0 ; do\n\  
cmd=\"\$1\"; shift\n\  
while test \$# -ne 0 ; do\n\  
cmd=\"\$cmd \$1\"; shift\n\  
test \"\$1\" = '--' && { shift; break; } || continue; done;\n\  
echo \"$X_DCKR_NAME: Running '\$cmd'\";\n\  
\$cmd || exit \$?;\n\  
done\n\  
echo \"$X_DCKR_NAME: Script finished without errors\" >&2;\n\  
} || {\n\  
exec \$X_DCKR_CMD \"\$@\"\n\  
}\n\  
" >> /x-docker-entrypoint.sh  
RUN chmod +x /x-docker-entrypoint.sh  
RUN ls -la /x-docker-entrypoint.sh && cat /x-docker-entrypoint.sh  
  
ENTRYPOINT ["/x-docker-entrypoint.sh"]  
CMD ["-v"]  
  
VOLUME ["/project"]  
WORKDIR /project  
# From: x-docker/0.0.2-dev alpine-bats/latest/Dockerfile  

