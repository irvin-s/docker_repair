FROM reactioncommerce/reaction:latest

ENV ROOT_URL "https://www.yourdomain.com"

ENV MONGO_URL="mongodb://USERNAME:PASSWORD@000.host.com:port/databasename"

ENV REACTION_EMAIL "you@yourdomain.com"
ENV REACTION_USER "admin"
ENV REACTION_AUTH "admin"

EXPOSE 3000
