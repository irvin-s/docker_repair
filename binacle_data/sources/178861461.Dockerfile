FROM ubermuda/phantomjs

ADD https://raw.githubusercontent.com/ariya/phantomjs/master/examples/rasterize.js /rasterize.js

VOLUME ["/srv"]
WORKDIR /srv

ENTRYPOINT ["/phantomjs/bin/phantomjs", "/rasterize.js"]