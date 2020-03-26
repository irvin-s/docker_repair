FROM zopyx/xmldirector-base

MAINTAINER Andreas Jung <info@zopyx.com>
ADD start-all.sh /home/plone/start-all.sh
CMD /home/plone/start-all.sh
