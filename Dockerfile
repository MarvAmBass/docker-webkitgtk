FROM debian:stretch

RUN apt-get -q -y update \
 && apt-get -q -y install wget \
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
 && wget https://webkitgtk.org/releases/webkitgtk-2.20.2.tar.xz \
 && tar xvf webkitgtk-*.tar.xz \
 && cd webkitgtk*/ \
 \
 && cp /usr/local/bin/ninja ninja \
 \
 && cmake -DPORT=GTK -DCMAKE_BUILD_TYPE=RelWithDebInfo -GNinja \
 && while ! ./ninja; do sleep 1; done # retry on errors \
 && ninja install \
 \
 && cd \
 \
 && git clone https://git.suckless.org/surf \
 && cd surf \
 && make


