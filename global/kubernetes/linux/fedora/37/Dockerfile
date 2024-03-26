FROM fedora:37

RUN yum install -y openssh-server passwd sudo lsof procps net-tools which

RUN chmod +x /usr/sbin/sshd
RUN useradd testUser
RUN echo "testUser:test" | chpasswd
RUN usermod -aG wheel testUser