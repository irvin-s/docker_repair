FROM tomcat:7

MAINTAINER kingdz

ADD soft /usr/local/src/

WORKDIR /usr/local/src/

RUN tar -zxf solr.tar.gz && \
		rm solr.tar.gz && \
		mv solr-4.10.3.war ../tomcat/webapps/solr.war && \
		../tomcat/bin/startup.sh && \
		sleep 10 && \
		../tomcat/bin/shutdown.sh && \
		rm ../tomcat/webapps/solr.war && \
		mv solr ../tomcat/webapps/solr/solr-home && \
		mv web.xml ../tomcat/webapps/solr/WEB-INF/ && \
		mv ext/* ../tomcat/webapps/solr/WEB-INF/lib/ && \
		rm -rf ext && \
		tar -zxf IK\ Analyzer\ 2012FF_hf1.tar.gz && \
		rm IK\ Analyzer\ 2012FF_hf1.tar.gz && \
		mv IK\ Analyzer\ 2012FF_hf1/IKAnalyzer2012FF_u1.jar ../tomcat/webapps/solr/WEB-INF/lib/ && \
		mkdir ../tomcat/webapps/solr/WEB-INF/classes && \
		cd IK\ Analyzer\ 2012FF_hf1 && \
		mv IKAnalyzer.cfg.xml ext_stopword.dic mydict.dic ../../tomcat/webapps/solr/WEB-INF/classes/ && \
		cd .. && \
		rm -rf IK\ Analyzer\ 2012FF_hf1

EXPOSE 8080