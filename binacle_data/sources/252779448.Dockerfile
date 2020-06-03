FROM zorbash/kitto  
  
ENV MIX_ENV prod  
  
RUN mkdir /dashboard  
WORKDIR /dashboard  
  
RUN mix local.rebar --force && mix local.hex --force  
  
COPY ./mix.exs ./  
COPY ./mix.lock ./  
RUN mix deps.get  
  
COPY ./package.json ./  
RUN npm install  
  
COPY . /dashboard  
RUN npm run build  
RUN mix compile  
  
CMD ["mix", "kitto.server"]  

