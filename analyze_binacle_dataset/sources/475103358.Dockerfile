#
# Node.js w/ Bower & Grunt Dockerfile
#
# https://github.com/dockerfile/nodejs-bower-grunt
#
# Pull base image.
FROM dockerfile/nodejs-bower-grunt

EXPOSE 9000

#Getting and Running the conference buddy
RUN git clone https://github.com/SchweizerischeBundesbahnen/conference-buddy.git . && sed -i 's/localhost/0.0.0.0/g' Gruntfile.js && npm install --unsafe-perm

# Define default command.
CMD ["npm", "start"]
