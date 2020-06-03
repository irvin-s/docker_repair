FROM stefanscherer/node-windows:10.14.1-nanoserver-1809 as builder

# set working directory
RUN mkdir app
WORKDIR /app

# add `/usr/src/app/node_modules/.bin` to $PATH
#ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY ClientApp/package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@6.0.0 --unsafe

# add app
COPY ClientApp/ /app

# generate build
RUN npm run prod

##################
### production ###
##################

# base image
FROM sixeyed/nginx:1.15.5-windowsservercore-1809

COPY nginx/nginx.conf c:/nginx/conf/

# copy artifact build from the 'build environment'
COPY --from=builder /app/dist c:/nginx/html

# expose port 80
EXPOSE 80

# run nginx
CMD "C:\nginx\nginx.exe"