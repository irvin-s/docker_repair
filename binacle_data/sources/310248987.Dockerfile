FROM node:8.10.0 as build

WORKDIR /usr/src/app

# Run install as a separate step for caching
COPY package*.json ./
RUN npm install

# Copy everything else
COPY . .

# lint, test, build
RUN npm run vsts:lint & \
npm run vsts:test & \
npm run vsts:build

# Build final image
FROM nginx:1.13
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
EXPOSE 80 443