FROM node:7-onbuild

RUN npm link

ENTRYPOINT ["scs-commander"]
