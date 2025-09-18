FROM amazonlinux:2

# Install dependencies
RUN yum -y update && \
    yum -y install cowsay fortune-mod nc && \
    yum clean all && rm -rf /var/cache/yum

# Copy app script
COPY wisecow.sh /usr/local/bin/wisecow.sh
RUN chmod +x /usr/local/bin/wisecow.sh

# Expose port
EXPOSE 4499

# Run the app
CMD ["/usr/local/bin/wisecow.sh"]
