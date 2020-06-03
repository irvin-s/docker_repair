FROM node:7  
# Create sentimeter directory  
RUN mkdir -p /retruco-api/uploads  
WORKDIR /retruco-api  
COPY ./src /retruco-api/src  
COPY ./config /retruco-api/config  
COPY ./email-templates /retruco-api/email-templates  
COPY ./forever /retruco-api/forever  
COPY ./scripts /retruco-api/scripts  
COPY configure.js /retruco-api/configure.js  
COPY index.js /retruco-api/index.js  
COPY .babelrc /retruco-api/.babelrc  
COPY package.json /retruco-api/package.json  
COPY process-actions.js /retruco-api/process-actions.js  
COPY regenerate-text-search.js /retruco-api/regenerate-text-search.js  
  
VOLUME /retruco-api/uploads  
# Variables  
ENV NODE_ENV development  
ENV RTAPI_CONTACT "Retruco-API Team"  
ENV RTAPI_DB_NAME "retruco"  
ENV RTAPI_DB_HOST "localhost"  
ENV RTAPI_DB_PASSWORD "password"  
ENV RTAPI_DB_PORT 5432  
ENV RTAPI_DB_USER "username"  
ENV RTAPI_DESCRIPTION "Bring out shared positions from argumented statements"  
ENV RTAPI_EMAIL "retruco@localhost"  
ENV RTAPI_EMAIL_KEY "Retruco sign key"  
ENV RTAPI_HOST "localhost"  
ENV RTAPI_KEY "RetrucoXAPI3not$very1secr3t%key"  
ENV RTAPI_PORT 3000  
ENV RTAPI_PROXY false  
ENV SMTP_HOST localhost  
ENV SMTP_PORT 25  
ENV SMTP_SECURE false  
ENV SMTP_REJECT_UNAUTHORIZED false  
ENV RTAPI_TITLE "Retruco-API"  
RUN npm install .  
CMD ["node", "index.js"]  

