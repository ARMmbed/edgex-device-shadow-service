FROM ubuntu:16.04
MAINTAINER ARM <doug.anson@arm.com>
EXPOSE 22/tcp
EXPOSE 1883/tcp
EXPOSE 1880/tcp
EXPOSE 28175/tcp
EXPOSE 8234/tcp
RUN apt-get update
RUN apt-get -y install default-jre vim sudo locales openssh-server supervisor dnsutils unzip zip mosquitto
RUN apt-get -y dist-upgrade
RUN useradd arm -m -s /bin/bash 
RUN mkdir -p /home/arm
RUN chown arm.arm /home/arm
COPY ssh-keys.tar /home/arm/
COPY mosquitto.tar /home/arm/
COPY configurator-1.0.zip /home/arm/
COPY shadow-service.zip /home/arm/
COPY restart.sh /home/arm/
RUN chmod 755 /home/arm/ssh-keys.tar
RUN chmod 755 /home/arm/mosquitto.tar
RUN chmod 755 /home/arm/shadow-service.zip
RUN chmod 755 /home/arm/configurator-1.0.zip
COPY configure_instance.sh /home/arm/
COPY start_instance.sh /home/arm/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod 700 /home/arm/configure_instance.sh
RUN chmod 700 /home/arm/start_instance.sh
RUN /home/arm/configure_instance.sh

ENTRYPOINT [ "/home/arm/start_instance.sh" ]
