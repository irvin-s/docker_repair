FROM node:4.4.2  
# Install mary-poppins with a custom version of metahub  
RUN git clone https://github.com/btford/mary-poppins /var/mary-poppins \  
&& cd /var/mary-poppins \  
&& git checkout v0.3.1  
ADD npm-shrinkwrap.json /var/mary-poppins/  
RUN cd /var/mary-poppins && npm install -g  
  
# Install of packages starting with "poppins-"  
#  
# https://github.com/btford/poppins-check-cla  
# https://github.com/btford/poppins-check-commit  
# https://www.npmjs.com/package/poppins-deadline  
# https://github.com/btford/poppins-exec  
# https://github.com/btford/poppins-pin  
# https://github.com/btford/poppins-pr-checklist  
# https://github.com/frapontillo/poppins-pr-vote  
# https://github.com/btford/poppins-prioritize  
WORKDIR /var/src  
RUN npm install \  
poppins-check-commit \  
poppins-deadline \  
poppins-exec \  
poppins-pin \  
poppins-pr-checklist \  
poppins-pr-vote \  
poppins-prioritize \  
https://github.com/cogniteev/poppins-configure-label.git --save  
  
ADD config.js /var/src/  
ADD start.sh /var/src/  
EXPOSE 80  
CMD ./start.sh  

