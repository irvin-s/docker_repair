FROM iojs:2

RUN useradd -ms /bin/bash node

USER node

# This will cd into the project root before running bash
CMD sh -c "cd ${PROJECT_PATH:-/}; exec /bin/bash"
