FROM builder:debian as build

RUN apt install -y cmake libasound2-dev libudev-dev
RUN git clone https://github.com/wb2osz/direwolf.git
RUN mkdir direwolf/build 
RUN cd direwolf/build && cmake .. 
RUN cd direwolf/build && make -j4 
RUN cd direwolf/build && make install
RUN cd direwolf/build && make install-conf

FROM debian:buster

WORKDIR /data

RUN apt update && apt install -y libasound2 libudev1 vim alsa-utils

COPY --from=build /usr/local/bin/ /usr/local/bin/
COPY --from=build /usr/local/share/doc/direwolf/ /usr/local/share/doc/direwolf/
COPY --from=build /etc/udev/rules.d/99-direwolf-cmedia.rules /etc/udev/rules.d/99-direwolf-cmedia.rules
COPY --from=build /root/direwolf.conf /data/direwolf.conf
COPY --from=build /usr/local/share/man/man1/ /usr/local/share/man/man1/
COPY --from=build /usr/local/share/direwolf/ /usr/local/share/direwolf/

EXPOSE 8000
EXPOSE 8001

CMD ["/usr/local/bin/direwolf", "-c", "/data/direwolf.conf", "-t", "0"]

