FROM https://container-registry.oracle.com/database/enterprise:21.3.0.0

# RUN apt-get update
# RUN apt-get install -y openssh-server passwd sudo lsof procps net-tools network-manager
# RUN mkdir /run/sshd

# RUN useradd -m testUser && \
#     echo "testUser:test" | chpasswd && \
#     adduser testUser sudo
# RUN chmod +x /usr/sbin/sshd

# CMD ["/usr/sbin/sshd", "-D"]
CMD ["/etc/sh", "--"]