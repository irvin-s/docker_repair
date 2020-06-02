FROM nginx:stable  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["nginx", "-g", "daemon off;"]  

