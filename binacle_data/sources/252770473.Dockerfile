FROM php:apache  
LABEL maintainer="aaron@spettl.de"  
  
# Enable Apache rewrite module  
RUN a2enmod rewrite  
  
# Copy the necessary files  
COPY email-autodiscover/.htaccess /var/www/html/  
COPY email-autodiscover/autodiscover.xml.php /var/www/html/  
COPY email-autodiscover/mail /var/www/html/mail  
COPY settings.json /var/www/html/settings.json  
  
# Override the default command and set configure the environment  
COPY start.sh /usr/local/bin  
  
# Available environment variables with default values  
ENV COMPANY_NAME="Your company name" \  
SUPPORT_URL="https://yourdomain.todo/" \  
DOMAIN="yourdomain.todo" \  
IMAP_HOST="mail.yourdomain.todo" \  
IMAP_PORT=993 \  
IMAP_SOCKET="SSL" \  
SMTP_HOST="mail.yourdomain.todo" \  
SMTP_PORT=587 \  
SMTP_SOCKET="STARTTLS"  
# Run the server  
CMD ["start.sh"]  

