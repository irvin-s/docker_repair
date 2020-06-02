FROM jonmcquade/aspnetcore-react-redux:latest
ENV ASPNETCORE_ENVIRONMENT Production
ENV RUNTIME="Release"
ENV ASPNETCORE_URLS="http://*:$PORT"
WORKDIR /dotnetcorespa
RUN ls -l
CMD /dotnetcorespa/FlightSearch

 

