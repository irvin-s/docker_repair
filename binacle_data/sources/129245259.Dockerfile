FROM node:6.9.1

WORKDIR app

ENV PATH="${PATH}:./node_modules/.bin"

CMD /bin/bash
