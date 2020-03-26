FROM calculator

COPY tests tests
ENV NODE_ENV dev

RUN npm update && \
    npm install -g mocha

CMD ["mocha", "tests/test.js", "--reporter", "spec"]
