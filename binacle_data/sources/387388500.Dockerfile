FROM node:9.2.0

COPY ./compose/node/entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh \
    && chmod +x /entrypoint.sh

COPY ./referral_project_client/ /app/

WORKDIR /app

RUN npm install

ENTRYPOINT ["/entrypoint.sh"]
