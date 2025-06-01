# Use frovlad/alpine-glibc image (glibc is needed)
FROM frolvlad/alpine-glibc

WORKDIR /app

# Copy the current directory contents into the container at /app
COPY build .

# Install any needed packages and do needed file system modifcations
RUN apk add --no-cache wget \
	&& wget https://www.hdsentinel.com/hdslin/hdsentinel-020b-x64.zip \
	&& unzip hdsentinel-020b-x64.zip \
	&& apk del wget \
	&& chmod 0755 HDSentinel \
	&& mkdir /etc/hdsentinel \
    && mv HDSentinel /bin/hdsentinel \
	&& chmod +x run_hdsentinel.sh run_cron.sh \
	&& /usr/bin/crontab crontab.txt

# Define environment variable
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=C.UTF-8

# Run  when the container launches 
# CMD ["/app/run_cron.sh"]
ENTRYPOINT ["/app/run_cron.sh"]
