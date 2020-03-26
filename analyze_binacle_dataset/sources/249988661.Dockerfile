FROM sebp/elk

# Replace existing Beats configuration file.
ADD './01-lumberjack-input.conf' '/etc/logstash/conf.d/01-lumberjack-input.conf'
ADD './02-beats-input.conf' '/etc/logstash/conf.d/02-beats-input.conf'