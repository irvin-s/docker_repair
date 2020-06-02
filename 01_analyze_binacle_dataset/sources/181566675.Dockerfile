FROM tvelocity/etherpad-lite:latest

WORKDIR /opt/

RUN curl -SL \
    https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.zip \
    > etherpad.zip && unzip etherpad && rm etherpad.zip && \
    mv etherpad-lite-${ETHERPAD_VERSION} etherpad-lite

WORKDIR etherpad-lite

# Install desired plugins (list taken from http://static.etherpad.org/plugins.html)

# [File / Menu style toolbar](https://www.npmjs.org/package/ep_aa_file_menu_toolbar)
# Score: 10/10
RUN npm install ep_aa_file_menu_toolbar

# [Gives the ability to list and administrate all pads on admin page](https://www.npmjs.org/package/ep_adminpads)
# Score: 10/10
RUN npm install ep_adminpads

# [Turn etherpad-lite into a realtime collaborative development environment](https://www.npmjs.org/package/ep_codepad)
ENV CODEPAD_ACTIVE 0
ENV CODEPAD_PROJECT_PATH /codepad
ENV CODEPAD_LOG_PATH /var/log
ENV CODEPAD_PLAY_URL http://localhost
ENV CODEPAD_PUSH_ACTION echo 'No push action'
#RUN npm install ep_codepad

# [Clear formatting on a selection, this plugin requires the file menu](https://npmjs.org/package/ep_clear_formatting)
# Score: 10/10
RUN npm install ep_clear_formatting

# [Adds comments on sidebar and link it to the text](https://www.npmjs.org/package/ep_comments_page)
# Score: 5/10 Form is not always rendered correctly, no realtime update, comment link has wrong icon
#RUN npm install ep_comments_page

# [Copy and Paste images from clipboard to a pad](https://www.npmjs.org/package/ep_copy_paste_images)
# Score: 0/10 Breaks the build
#RUN npm install ep_copy_paste_images

# [Add support to do Copy, Paste, Select All and Find and Replace](https://www.npmjs.org/package/ep_copy_paste_select_all)
# Score: 2/10 No real functionality
#RUN npm install ep_copy_paste_select_all

# [Clone a pad without history](https://www.npmjs.org/package/ep_copypad)
# Score: O/10 Didn't work
#RUN npm install ep_copypad

# [Show cursor/caret movements of other users in real time](https://www.npmjs.org/package/ep_cursortrace)
# Score: O/10 Didn't work
#RUN npm install ep_cursortrace

# [Receive chat desktop notifications](https://www.npmjs.org/package/ep_desktop_notifications)
#RUN npm install ep_desktop_notifications

# [Subscribe to a pad and receive an email when someone edits your pad](https://www.npmjs.org/package/ep_email_notifications)
# Score: ?/10 I should create the settings first
#RUN npm install ep_email_notifications

# [File upload](https://www.npmjs.org/package/ep_fileupload)
# Score: 8/10
RUN npm install ep_fileupload
# Uploaded files are stored in the following path, it is required to mount an external volume for this folder
VOLUME /opt/etherpad-lite/node_modules/ep_fileupload/upload/

# [Image previewer, paste the URL or an image or upload an image using ep_fileupload](https://www.npmjs.org/package/ep_previewimages)
# Score: 7/10 Makes cursor a bit laggy
RUN npm install ep_previewimages

# [A closed pad system, with no public pads. The pad system is arranged in groups, every pad is assigned to a group, just as users. Users can edit any pad of their groups and also create new group pads. This is also a frontend to manage users and groups.](https://www.npmjs.org/package/ep_frontend_community)
# Score: ?/10 I should create the initialization script first
#RUN npm install ep_frontend_community

# [Authenticate users against Github](https://www.npmjs.org/package/ep_github)
# Score: ?/10 I should create the settings first
#RUN npm install ep_github

# [Adds internal links to etherpad lite. To create internal links use [[example]] style formatting](https://www.npmjs.org/package/ep_linkify)
# Score: 10/10
RUN npm install ep_linkify

# [List Pads on the Index Page](https://www.npmjs.org/package/ep_list_pads)
# Score: 3/10 Works but is not easy to browse the pads
#RUN npm install ep_list_pads

# [Edit and Export as Markdown](https://www.npmjs.org/package/ep_markdown)
# Score: 10/10 Github compatible
RUN npm install ep_markdown

# [Make the font default to Monospace](https://www.npmjs.org/package/ep_monospace_default)
# Score: 10/10
RUN npm install ep_monospace_default

# [Display a list of pads at /list](https://www.npmjs.org/package/ep_padlist)
# Score: 10/10
#RUN npm install ep_padlist

# [Prompt an author for their name](https://www.npmjs.org/package/ep_prompt_for_name)
# Score: 6/10
RUN npm install ep_prompt_for_name

# [Get an RSS feed for updates for a specific pad](https://www.npmjs.org/package/ep_rss)
# Score: 7/10
#RUN npm install ep_rss

# [Video and audio chat without plugins powered by WebRTC](https://github.com/bit/ep_webrtc)
# Score: O/10 Didn't work
#RUN npm install ep_webrtc

# [Search through all pads for a string in index page](https://www.npmjs.org/package/ep_search)
# Score: 6/10 UI is of poor quality
#RUN npm install ep_search

# [Insert special characters into a pad](https://www.npmjs.org/package/ep_special_characters)
# Score: 8/10 UI is of poor quality
RUN npm install ep_special_characters

# [Adds syntax highlighting to etherpad-lite](https://www.npmjs.org/package/ep_syntaxhighlighting)
# Score: 7/10 All file is highlighted
RUN npm install ep_syntaxhighlighting

# [Table of contents for Etherpad](https://github.com/JohnMcLear/ep_table_of_contents)
# Score: 6/10 Duplicate headings are genereated some times
RUN npm install ep_table_of_contents

# [Add tables in etherpad-lite](https://github.com/quenenni/ep_tables2)
# Score: 7/10 UI is of poor quality
RUN npm install ep_tables2

# [Change the themes, styles & colors](https://www.npmjs.com/package/ep_themes)
# Usage: http://beta.etherpad.org/p/test?theme=monokai
# Revert: http://beta.etherpad.org/p/test?theme=default
# Score: 3/10 Actual themes are of poor quality
#RUN npm install ep_themes

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

VOLUME /opt/etherpad-lite/var

EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/run.sh", "--root"]
