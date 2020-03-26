FROM progrium/busybox

ADD bin/smg /usr/local/bin/smg

ENTRYPOINT ["/usr/local/bin/smg"]
