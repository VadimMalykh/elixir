FROM elixir

RUN git clone https://github.com/inotify-tools/inotify-tools
RUN cd inotify-tools && ./autogen.sh && ./configure --prefix=/usr && make && su -c 'make install'
