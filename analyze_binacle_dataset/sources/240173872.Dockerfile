FROM node:7-onbuild

ARG BUILD_DATE="`date`"

LABEL org.label-schema.vendor="SBB" \
      org.label-schema.url="https://www.sbb.ch" \
      org.label-schema.name="bookingAPI" \
      org.label-schema.description="A simple API to book tickets for public transport in Switzerland." \
      org.label-schema.vcs-url="https://github.com/schlpbch/bookingAPI" \
      org.label-schema.build-date=$BUILD_DATE

# Fix permissions for runtime
RUN chmod -R 777 ./public/app

CMD npm run dev

EXPOSE 8080
