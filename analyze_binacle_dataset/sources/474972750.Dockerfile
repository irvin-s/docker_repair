FROM elasticsearch:latest

RUN plugin install license
RUN plugin install watcher
RUN plugin install marvel-agent 
