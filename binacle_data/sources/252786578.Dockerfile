FROM nginx:stable-alpine  
  
COPY ./scripts /  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["nginx", "-g", "daemon off;"]  

