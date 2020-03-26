FROM elixir:alpine  
LABEL maintainer "Antoine POPINEAU <antoine.popineau@appscho.com"  
  
WORKDIR /unicli  
ADD . /unicli  
  
RUN apk add -U git  
RUN mix local.hex --force && mix local.rebar --force && mix deps.get  
RUN mix escript.build  
  
ENTRYPOINT ["/unicli/unicli"]  

