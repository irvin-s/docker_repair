FROM       jekyll/builder:pages
ENV        DAPPER_SOURCE /srv/jekyll
ENV        DAPPER_OUTPUT /
ENV        DAPPER_RUN_ARGS -p 4000:4000    
ENTRYPOINT ["jekyll"]
