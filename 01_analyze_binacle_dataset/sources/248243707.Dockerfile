FROM node:6

RUN echo "unsafe-perm=true" > ~/.npmrc

# Create src directory
RUN mkdir -p /usr/src/alfresco-ng2-components/

# Copy source and install app dependencies
COPY *.* /usr/src/alfresco-ng2-components/
COPY assets /usr/src/alfresco-ng2-components/assets
COPY app /usr/src/alfresco-ng2-components/app
COPY server /usr/src/alfresco-ng2-components/server
COPY i18n /usr/src/alfresco-ng2-components/i18n


WORKDIR /usr/src/alfresco-ng2-components/
RUN npm install concurrently -g
RUN npm install

EXPOSE 3000

CMD [ "concurrently", "npm run tsc:w", "npm run serve" ]
