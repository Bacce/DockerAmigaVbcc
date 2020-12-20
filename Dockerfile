# VBCC Installation tutorial for Amiga m68k from https://www.youtube.com/watch?v=vFV0oEyY92I
# Updated to build to Kickstart 1.3 with NDK 1.3
FROM debian:jessie
MAINTAINER BenceD

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install gcc wget curl make lhasa


WORKDIR /root
RUN mkdir vbcc_tools && mkdir -p amiga_sdk/vbcc

WORKDIR /root/vbcc_tools
RUN wget http://phoenix.owl.de/tags/vbcc0_9g.tar.gz && \
	wget http://phoenix.owl.de/vbcc/2019-10-04/vbcc_target_m68k-kick13.lha && \
	wget http://phoenix.owl.de/vbcc/2019-10-04/vbcc_unix_config.tar.gz

RUN tar xvfz vbcc0_9g.tar.gz && cd vbcc && mkdir bin && yes '\
' | make TARGET=m68k && cp -r bin ~/amiga_sdk/vbcc/
RUN lha x ~/vbcc_tools/vbcc_target_m68k-kick13.lha && cp -r vbcc_target_m68k-kick13/* ~/amiga_sdk/vbcc
WORKDIR /root/amiga_sdk/vbcc
RUN tar xvfz ~/vbcc_tools/vbcc_unix_config.tar.gz
ENV VBCC="/root/amiga_sdk/vbcc"
ENV PATH="$VBCC/bin:${PATH}"
RUN wget http://sun.hasenbraten.de/vasm/release/vasm.tar.gz && tar xvfz vasm.tar.gz && cd vasm && make CPU=m68k SYNTAX=mot && cp vasmm68k_mot vobjdump $VBCC/bin
RUN wget http://sun.hasenbraten.de/vlink/release/vlink.tar.gz && tar xvfz vlink.tar.gz && cd vlink && mkdir objects && make && cp vlink $VBCC/bin
WORKDIR /root/amiga_sdk
VOLUME ./ndk_1.3 /root/amiga_sdk/ndk_1.3
ENV NDK_INC=/root/amiga_sdk/ndk_1.3/includes1.3/include.h
WORKDIR /root
CMD /root/amiga_sdk/vbcc/bin/vc
