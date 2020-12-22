# start from a base ubuntu image
FROM ubuntu

# set users cfg file
ARG USERS_CFG=users.json
ARG DEBIAN_FRONTEND=noninteractive

# Install pre-reqs
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y apache2 git python supervisor wget
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fetch  brat
RUN mkdir /var/www/brat
RUN git clone https://github.com/nlplab/brat.git /var/www/brat
RUN cd /var/www/brat

# create a symlink so users can mount their data volume at /bratdata rather than the full path
RUN mkdir /bratdata && mkdir /bratcfg
RUN chown -R www-data:www-data /bratdata /bratcfg 
RUN chmod o-rwx /bratdata /bratcfg
RUN ln -s /bratdata /var/www/brat/data
RUN ln -s /bratcfg /var/www/brat/cfg 

ADD brat_install_wrapper.sh /usr/bin/brat_install_wrapper.sh
RUN chmod +x /usr/bin/brat_install_wrapper.sh

# Make sure apache can access it
RUN chown -R www-data:www-data /var/www/brat

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf

# add the user patching script
ADD user_patch.py /var/www/brat/user_patch.py

# Enable cgi
RUN a2enmod cgi

EXPOSE 80

# We can't use apachectl as an entrypoint because it starts apache and then exits, taking your container with it. 
# Instead, use supervisor to monitor the apache process
RUN mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

CMD ["/usr/bin/supervisord"]
