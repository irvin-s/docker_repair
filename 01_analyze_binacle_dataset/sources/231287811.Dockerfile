FROM strato-build

RUN mkdir /package
COPY group passwd profile shadow shells /usr/src/
RUN install -m 0755 -d \
    /package/etc \
    /package/etc/ssl \
    /package/etc/strato \
    /package/home \
    /package/run \
    /package/usr \
    /package/usr/bin \
    /package/usr/sbin \
    /package/usr/share \
    /package/var/cache \
    /package/var/cache/misc \
    /package/var/lib \
    /package/var/lib/strato \
    /package/var/lib/misc \
    /package/var/local \
    /package/var/log \
    /package/var/run \
    && install -m 0555 -d /package/var/empty \
    && install -m 0700 -d /package/root \
    && install -m 1777 -d /package/tmp /package/var/tmp \
    && cp /usr/src/group \
    /usr/src/passwd \
    /usr/src/profile \
    /usr/src/shadow \
    /usr/src/shells \
    /package/etc
