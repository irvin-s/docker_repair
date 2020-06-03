FROM drecom/ubuntu-ruby:2.5.0  
# 文字化け防止  
ENV LANG C.UTF-8  
# 日本時間設定  
ENV TZ Asia/Tokyo  
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime  
RUN echo $TZ > /etc/timezone  
  
# Node.js  
RUN npm install n -g \  
&& n stable \  
&& ln -sf /usr/local/bin/node /usr/bin/node  

