FROM mwcampbell/muslbase-static-runtime
MAINTAINER Matt Campbell <mattcampbell@pobox.com>
ADD runtime.tar /
CMD ["nginx"]
