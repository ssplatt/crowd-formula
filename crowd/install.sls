# vim: ft=sls
# How to install crowd
{%- from "crowd/map.jinja" import crowd with context %}

crowd_pkg:
  archive.extracted:
    - name: /opt/
    - source: https://www.atlassian.com/software/crowd/downloads/binary/{{ crowd.app_name }}-{{ crowd.version }}.tar.gz
    - source_hash: sha256={{ crowd.pkg_hash }}
    - archive_format: tar
    - tar_options: ''
    - if_missing: /opt/{{ crowd.app_name }}-{{ crowd.version }}

crowd_data_dir:
  file.directory:
    - name: /var/atlassian
    - user: root
    - group: root
    - mode: 755

{% if crowd.mockup %}
debian_backports_repo:
  pkgrepo.managed:
    - humanname: Debian Backports
    - name: deb http://http.debian.net/debian jessie-backports main
    - file: /etc/apt/sources.list.d/jessie-backports.list

crowd_user:
  user.present:
    - name: crowd
    - gid_from_name: true
    - home: /var/atlassian/crowd
    - shell: /bin/sh

crowd_mockup_install_mariadb:
  pkg.installed:
    - name: mariadb-server
    
crowd_mockup_install_mysql_connector:
  archive.extracted:
    - name: /root/
    - source: http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz
    - source_hash: md5=8f8e768a91338328f2ac5cd6b6683c88
    - archive_format: tar
    - tar_options: ''
    - if_missing: /root/mysql-connector-java-5.1.38
    
crowd_mockup_copy_mysql_connector:
  cmd.run:
    - name: cp /root/mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar /opt/{{ crowd.app_name }}-{{ crowd.version }}/apache-tomcat/lib/
    - unless: test -f /opt/{{ crowd.app_name }}-{{ crowd.version }}/apache-tomcat/lib/mysql-connector-java-5.1.38-bin.jar

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
{% endif %}

crowd_install_dir_permissions:
  file.directory:
    - name: /opt/{{ crowd.app_name }}-{{ crowd.version }}
    - user: crowd
    - group: crowd
    - mode: 755
    - recurse:
      - user
      - group

crowd_install_required_java:
  pkg.installed:
    - name: {{ crowd.required_java }}
