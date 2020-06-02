FROM armel/busybox

COPY heapster eventer /

ENTRYPOINT ["/heapster"]
