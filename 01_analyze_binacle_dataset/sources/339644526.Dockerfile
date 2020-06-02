FROM petrosagg/resin-wpe:raspberrypi3-30c7465

COPY wpe-init /wpe-init

COPY public_html /var/lib/public_html

ENV JQUERY_VERSION=3.3.1
RUN wget "https://code.jquery.com/jquery-${JQUERY_VERSION}.min.js" -O /var/lib/public_html/jquery.min.js

ENV WPE_URL="file:///var/lib/public_html/index.html"

CMD [ "/wpe-init" ]
