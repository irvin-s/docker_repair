# Stage 1
FROM stedolan/jq AS builder
COPY ./registries.json ./
COPY ./build.sh ./
RUN ./build.sh > ./nginx.conf

# Stage 2
FROM nginx:alpine
COPY --from=builder ./nginx.conf /etc/nginx/nginx.conf
