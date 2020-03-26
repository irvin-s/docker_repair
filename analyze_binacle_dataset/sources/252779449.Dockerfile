FROM zorbash/kitto  
  
COPY . /dashboard  
WORKDIR /dashboard  
  
ENV MIX_ENV prod  
  
RUN mix deps.get  
RUN npm install  
RUN npm run build  
RUN mix compile  
  
CMD ["mix", "kitto.server"]  

