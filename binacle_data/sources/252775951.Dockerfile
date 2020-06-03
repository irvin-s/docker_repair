# onbuild versions not recommended for long term use  
FROM node:onbuild  
EXPOSE 8888  
CMD ["node", "app.js"]  
ENTRYPOINT ["node", "app.js"]  

