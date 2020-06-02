FROM local/node:1

LABEL maintainer My Name <myemail@example.com>
LABEL refreshed_at 2017-03-14

# ARG can be very useful when you want to pass a vlue at build time
ARG PORT=8080
ENV PORT $PORT

EXPOSE $PORT

ENTRYPOINT ["npm", "start"]
