FROM nginx:alpine  
  
COPY index.html /usr/share/nginx/html/index.html  
COPY js-compiled.js /usr/share/nginx/html/js-compiled.js  
COPY addtohomescreen.min.js /usr/share/nginx/html/addtohomescreen.min.js  
COPY jquery-3.1.1.min.js /usr/share/nginx/html/jquery-3.1.1.min.js  
COPY addtohomescreen.css /usr/share/nginx/html/addtohomescreen.css  
COPY images /usr/share/nginx/html/images  
  

