FROM ubuntu

RUN apt-get update
RUN apt-get install -y openssh-server passwd sudo lsof procps net-tools
RUN mkdir /run/sshd

# RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 ubuntu
RUN useradd -m testUser && \
    echo "testUser:test" | chpasswd && \
    adduser testUser sudo
RUN chmod +x /usr/sbin/sshd


# ENTRYPOINT ["ssh-keygen -A && /usr/sbin/sshd -D"]
CMD ["/usr/sbin/sshd", "-D"]