FROM nginx:stable  
  
RUN apt-get update && apt-get install -y fail2ban  
  
COPY nginx/default.conf nginx/sharing-only.conf /etc/nginx/conf.d/  
RUN touch /var/log/nginx/sharing-only.log  
  
COPY fail2ban/nginx-nextcloud-sharing-auth.conf /etc/fail2ban/filter.d/  
COPY fail2ban/iptables-proxy.conf /etc/fail2ban/action.d/  
COPY fail2ban/jail.conf /etc/fail2ban/  
  
EXPOSE 80 8000  
CMD ["sh", "-c", "service fail2ban force-start && nginx -g 'daemon off;'"]  
  

