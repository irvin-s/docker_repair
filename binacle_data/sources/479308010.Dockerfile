FROM progrium/busybox
RUN opkg-install libc-dev
ADD ./consoleapp console
CMD [ "./console" ]