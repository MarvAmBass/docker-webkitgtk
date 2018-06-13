FROM debian:stretch

ENV WEBKITGTK_VERSION=2.20.2

COPY install.sh /usr/local/bin/install.sh

RUN apt-get -q -y update \
 && apt-get -q -y upgrade \
 && apt-get -q -y install sudo \
                          \
                          wget \
                          unzip \
                          \
                          git \
                          \
                          make \
                          cmake \
                          ruby \
                          debhelper \
                          gawk \
                          gperf \
                          bison \
                          flex \
                          gtk-doc-tools \
 \
 && cd \
 \
 && wget https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip \
 && unzip ninja-linux.zip \
 && mv ninja /usr/local/bin/ \
 && rm ninja-linux.zip \
 \
 && wget "https://webkitgtk.org/releases/webkitgtk-$WEBKITGTK_VERSION.tar.xz" \
 && tar xvf webkitgtk-*.tar.xz \
 && cd webkitgtk*/ \
 \
 && chmod a+x /usr/local/bin/install.sh \
 && cp /usr/local/bin/install.sh install.sh \
 \
 && ./install.sh \
 \
 && cp /usr/local/bin/ninja ninja \
 \
 && cmake -DPORT=GTK -DCMAKE_BUILD_TYPE=RelWithDebInfo -GNinja \
 && sh -c 'while ! ./ninja; do sleep 1; done' \
 && sudo ninja install \
 \
 && strip /usr/local/lib/* \
 && strip /usr/local/libexec/webkit*/* \
 && strip /usr/local/bin/* \
 \
 && rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/midi/* /usr/share/GeoIP/* /usr/share/perl/* /usr/share/cmake-* \
 \
 && cd \
 && tar czvf /wk.tar.gz webkitgtk*/
