FROM appsflare/pro-ideas:node  
RUN mkdir /var/www -p  
ADD dist/pro-ideas.tar.gz /var/www/  
RUN cd /var/www/bundle/programs/server && \  
npm rebuild && \  
npm install  
ENV ROOT_URL=http://127.0.0.1  
ENV PORT=3000  
WORKDIR /var/www/bundle  
EXPOSE 3000  
CMD ['node','main.js']  

