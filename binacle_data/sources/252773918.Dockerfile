FROM bitwalker/alpine-elixir-phoenix:latest  
  
# Set exposed ports  
EXPOSE 80  
ENV PORT=4000 MIX_ENV=dev  
  
# Cache elixir deps  
ADD mix.exs mix.lock ./  
ADD config config  
RUN mix do deps.get, deps.compile  
  
ADD . .  
  
# Run frontend build, compile, and digest assets  
RUN mix do compile, phoenix.digest  
RUN chmod +x ./entrypoint.sh  
  
CMD ["/bin/sh", "./entrypoint.sh"]  

