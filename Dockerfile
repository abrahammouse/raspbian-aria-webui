
# Use rpi-raspbian as basic image
FROM sdhibit/rpi-raspbian
MAINTAINER abrahammouse<abrahammouse@gmail.com>

# Update the repository
RUN apt-get update \
        && apt-get install -y aria2 nginx \
        && rm -rf /var/lib/apt/lists/*

# Prepare conf file
RUN mkdir /data -p
RUN mkdir /aria2c -p
ADD aria2.session /aria2c/
ADD aria2.conf /aria2c/
ADD . /var/www/html/

# Expose ports
EXPOSE 6800 80

# Set the default command to execute when creating a new container
CMD service nginx restart && aria2c --conf-path=/aria2c/aria2.conf
