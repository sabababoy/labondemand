FROM ubuntu

RUN apt-get update
RUN apt-get install -y openssh-server passwd sudo lsof procps net-tools
RUN mkdir /run/sshd

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu \
    echo 'testUser:test' | chpasswd
RUN chmod +x /usr/sbin/sshd


# ENTRYPOINT ["ssh-keygen -A && /usr/sbin/sshd -D"]
CMD ["/usr/sbin/sshd", "-D"]