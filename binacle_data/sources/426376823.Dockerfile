#// Before you can use this, you need to download a copy of Qt:
#//
#// http://download.qt-project.org/official_releases/qt/5.1/5.1.1/qt-linux-opensource-5.1.1-x86_64-offline.run
#//
#// into the directory where you are running "docker build ."

ADD qt-linux-opensource-5.1.1-x86_64-offline.run /opt/qt-linux-opensource-5.1.1-x86_64-offline.run
RUN chmod u+x /opt/qt-linux-opensource-5.1.1-x86_64-offline.run

