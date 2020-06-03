FROM bradleybossard/docker-node-devbox  
  
# caniuse-cmd cli for caniuse.com  
# live-server dead simple webserver  
# st static web server  
# wintersmith static site generator  
# babel es6 compiler  
# webpack-dev-server webpack development server  
# jspm next-gen package manager  
RUN mkdir -p /root/.config/configstore  
RUN chmod g+rwx /root /root/.config /root/.config/configstore  
  
RUN npm install --global --allow-root \  
caniuse-cmd \  
live-server \  
st \  
wintersmith \  
babel \  
webpack-dev-server \  
jspm  
  

