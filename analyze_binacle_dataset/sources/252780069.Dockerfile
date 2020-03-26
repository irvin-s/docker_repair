# docker image  
FROM sameersbn/gitlab:10.4.0  
  
# maintainer information  
MAINTAINER ayapapa ayapapajapan@yahoo.co.jp  
  
# fix some issues related to relative resources(avatar, uploads)' url  
RUN \  
ABSROOT="Gitlab\.config\.gitlab\.url" && \  
RELROOT="Gitlab\.config\.gitlab\.relative_url_root" && \  
TARGET="URI\.join(Gitlab\.config\.gitlab\.base_url, path)\.to_s" && \  
REPLACE="path" && \  
sed -i.org "s/${TARGET}/${REPLACE}/" \  
/home/git/gitlab/lib/banzai/filter/relative_link_filter.rb && \  
\  
TARGET="def apply_relative_link_rules\!" && \  
REPLACE="\ return if \@uri\.to_s\.start_with?(${RELROOT})" && \  
sed -i.org "/${TARGET}/a ${REPLACE}" \  
/home/git/gitlab/lib/banzai/filter/wiki_link_filter/rewriter.rb  

