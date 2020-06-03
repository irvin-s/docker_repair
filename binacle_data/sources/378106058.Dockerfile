FROM yungsang/busybox

EXPOSE 80
CMD ["nc", "-p", "80", "-l", "-l", "-e", "echo", "hello world!"]
