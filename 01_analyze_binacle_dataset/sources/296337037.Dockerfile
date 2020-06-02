FROM node:8.7
RUN npm install -g replicated-studio
EXPOSE 8006
CMD ["replicated-studio"]
