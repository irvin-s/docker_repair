FROM  node:10.11.0 as base
LABEL description="Cogito IOS distribution"

WORKDIR /apps/cogito-ios-app-distribution

COPY . .
RUN yarn install
RUN yarn build --production

FROM nginx:alpine
ENV HTPASSWD='philips:$apr1$edu3G9YE$zFZDqLyMIVa.pmaqJNSJX/'

WORKDIR /apps/cogito-ios-app-distribution
RUN apk add --no-cache gettext

COPY auth.conf auth.htpasswd launch.sh ./

COPY --from=base /apps/cogito-ios-app-distribution/build/ build
CMD ["./launch.sh"]
