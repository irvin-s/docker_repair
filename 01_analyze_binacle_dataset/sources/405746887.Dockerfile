FROM node:11-slim

LABEL "com.github.actions.name"="Report to packtracker.io"
LABEL "com.github.actions.description"="Report your webpack build stats to the packtracker.io service."
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="#363636"

RUN apt-get update && apt-get install jq git -y && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh
COPY ./report.js /report.js
ENTRYPOINT ["/entrypoint.sh"]
