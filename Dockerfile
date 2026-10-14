FROM ubuntu:latest

# Install SSH and basic network tools
RUN apt-get update && apt-get install -y openssh-server sudo net-tools curl openssl

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:LearningSSH2026!' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Expose port 22 for SSH
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
