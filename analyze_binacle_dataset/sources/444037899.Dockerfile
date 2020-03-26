FROM sameersbn/gitlab:8.2.0

# We need to prepend something to app/controllers/application_controller.rb, but we need app/init to do it. So this is a sed line that injects another sed line to app/init.
# The line we are injecting to app/init (after "cd ${GITLAB_INSTALL_DIR}") is:
#   sed "s/\(.*\)\(if user\)/\1if \!user; user = User.find_by_email(request.headers[\"HTTP_USER\"]) end\n\1\2/" -i app/controllers/application_controller.rb
# and that will inject:
#   if !user; user = User.find_by_email(request.headers["HTTP_USER"]) end
# to app/controllers/application_controller.rb just before "if user"
# RUN sed '/cd ${GITLAB_INSTALL_DIR}/a sed "s/\\(.*\\)\\(if user\\)/\\1if \\!user; user = User.find_by_email(request.headers[\\"HTTP_USER\\"]) end\\n\\1\\2/" -i app/controllers/application_controller.rb' -i /app/init

# In the new version, we can do this at image buildtime, since the file is there ready for us :) Keeping the above for reference
RUN sed "s/\\(.*\\)\\(if user\\)/\\1if \\!user; user = User.find_by_email(request.headers[\"HTTP_USER\"]) end\\n\\1\\2/" -i /home/git/gitlab/app/controllers/application_controller.rb
