FROM norionomura/sourcekit:311  
MAINTAINER Danielle Tomlinson <dani@tomlinson.io>  
  
ENV SWIFTLINT_REVISION="master" \  
SWIFTLINT_BUILD_DIR="/swiftlint_build" \  
LINT_WORK_DIR="/swiftlint"  
WORKDIR "${SWIFTLINT_BUILD_DIR}"  
  
RUN git clone https://github.com/realm/SwiftLint.git .  
RUN git checkout -f -q "${SWIFTLINT_REVISION}"  
RUN swift build -c release  
  
RUN cd .build/release \  
&& mv swiftlint /usr/bin/ \  
&& mv *.so /usr/lib/swift/linux/x86_64/ \  
&& mv *.swiftmodule /usr/lib/swift/linux/x86_64/ \  
&& cd / \  
&& rm -rf "${SWIFTLINT_BUILD_DIR}"  
  
RUN swiftlint version  
  
RUN echo "${SWIFT_INSTALL_DIR}"  
  
VOLUME ${LINT_WORK_DIR}  
WORKDIR ${LINT_WORK_DIR}  
  
ENTRYPOINT ["swiftlint"]  
CMD ["lint"]  

