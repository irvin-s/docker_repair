  
FROM nginx:1.7  
MAINTAINER CenturyLink Labs  
  
COPY . /usr/share/nginx/html  
  
# expose both the HTTP (80) and HTTPS (443) ports  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  

