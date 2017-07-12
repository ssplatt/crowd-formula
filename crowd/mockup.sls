# vim: ft=sls
# How to install crowd
{%- from "crowd/map.jinja" import crowd with context %}

debian_backports_repo:
  pkgrepo.managed:
    - humanname: Debian Backports
    - name: deb http://http.debian.net/debian jessie-backports main
    - file: /etc/apt/sources.list.d/jessie-backports.list

crowd_mokcup_data_dir:
  file.directory:
    - name: /var/atlassian/crowd
    - user: root
    - group: root
    - mode: 755
    - makedirs: true

crowd_mockup_user:
  user.present:
    - name: crowd
    - gid_from_name: true
    - home: /var/atlassian/crowd
    - shell: /bin/sh

crowd_mockup_install_mariadb:
  pkg.installed:
    - name: mariadb-server

crowd_mockup_start_mariadb:
  service.running:
    - name: mysql
    - enable: true

crowd_mockup_setup_sql_db:
  mysql_database.present:
    - name: crowd
    
crowd_mockup_setup_sql_user:
  mysql_user.present:
    - name: crowduser
    - host: localhost
    - password: crowdpassword
    - connection_charset: utf8
    
crowd_mockup_sql_grants:
  mysql_grants.present:
    - grant: all privileges
    - database: crowd.*
    - user: crowduser
    - host: localhost
