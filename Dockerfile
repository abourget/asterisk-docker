FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y build-essential wget aptitude gdb strace
WORKDIR /root
RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-13.0.0.tar.gz
RUN wget http://www.pjsip.org/release/2.2.1/pjproject-2.2.1.tar.bz2
RUN tar -xjvf pjproject-2.2.1.tar.bz2
RUN cd pjproject-2.2.1 && \
    ./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr && \
    make dep && \
    make && \
    make install && \
    ldconfig

RUN tar -zxvf asterisk-13.0.0.tar.gz
RUN asterisk-13.0.0/contrib/scripts/install_prereq install
WORKDIR /root/asterisk-13.0.0
RUN wget https://issues.asterisk.org/jira/secure/attachment/51445/ASTERISK-24498-13.diff
RUN patch -p0 < ASTERISK-24498-13.diff
RUN ./configure
RUN make menuselect.makeopts
RUN menuselect/menuselect --enable DONT_OPTIMIZE --enable BETTER_BACKTRACES menuselect.makeopts
RUN make
RUN make install
RUN make samples
RUN make config

ADD run.sh /run.sh
CMD ["/run.sh"]

# Run with:
#
#    dk run -ti --rm --net=host -v `pwd`/etc_asterisk:/etc/asterisk -v `pwd`/voicemail:/var/spool/asterisk/voicemail -v `pwd`/monitor:/var/spool/asterisk/monitor -v `pwd`/run:/var/run/asterisk asterisk /etc/init.d/asterisk start
#
#    -v `pwd`/voicemail:/var/spool/asterisk/voicemail -v `pwd`/monitor:/var/spool/asterisk/monitor -v `pwd`/run:/var/run/asterisk
#    --net=host to listen to all ports on the machine