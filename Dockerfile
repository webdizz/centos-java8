FROM blalor/centos:latest

MAINTAINER Izzet Mustafaiev "izzet@mustafaiev.com"

# Set correct environment variables.
ENV	HOME /root
ENV	LANG en_US.UTF-8
ENV	LC_ALL en_US.UTF-8

RUN	echo "root:123456" | chpasswd

RUN yum install -y wget pwgen openssh-server openssh-clients supervisor vim curl telnet;  yum upgrade -y; yum update -y;  yum clean all
RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/8u5-b13/jdk-8u5-linux-x64.rpm' -H 'Cookie: oraclelicense=accept-securebackup-cookie' && rpm -i jdk-8u5-linux-x64.rpm; rm -f jdk-8u5-linux-x64.rpm; yum clean all
ENV JAVA_HOME /usr/java/default

#SSH support
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
ADD /supervisor/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
