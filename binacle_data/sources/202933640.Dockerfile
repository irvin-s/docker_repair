FROM ubuntu:14.04

ENV dominopackagedir=domino901

RUN useradd -ms /bin/bash notes
RUN usermod -aG notes notes
RUN usermod -d /local/notesdata notes
RUN sed -i '$d' /etc/security/limits.conf
RUN echo 'notes soft nofile 60000' >> /etc/security/limits.conf
RUN echo 'notes hard nofile 80000' >> /etc/security/limits.conf
RUN echo '# End of file' >> /etc/security/limits.conf

COPY sw-repo/${dominopackagedir}/ /tmp/sw-repo/

RUN /bin/bash -c "/tmp/sw-repo/install -silent -options /tmp/sw-repo/unix_response.dat"

RUN mkdir -p /etc/sysconfig/
COPY sw-repo/initscripts/rc_domino /etc/init.d/
RUN chmod u+x /etc/init.d/rc_domino
RUN chown root.root /etc/init.d/rc_domino
COPY sw-repo/initscripts/rc_domino_script /opt/ibm/domino/
RUN chmod u+x /opt/ibm/domino/rc_domino_script
RUN chown notes.notes /opt/ibm/domino/rc_domino_script
COPY sw-repo/initscripts/rc_domino_config_notes /etc/sysconfig/

# Clean up
RUN rm /tmp/* -R
