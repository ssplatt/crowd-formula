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

crowd_install_required_java:
  pkg.installed:
    - name: {{ crowd.required_java }}
    - fromrepo: {{ crowd.required_pkgs_repo }}

crowd_install_mysql_connector:
  archive.extracted:
    - name: /root/
    - source: http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz
    - source_hash: md5=8f8e768a91338328f2ac5cd6b6683c88
    - archive_format: tar
    - tar_options: ''
    - if_missing: /root/mysql-connector-java-5.1.38
    
crowd_copy_mysql_connector:
  cmd.run:
    - name: cp /root/mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar /opt/{{ crowd.app_name }}-{{ crowd.version }}/apache-tomcat/lib/
    - unless: test -f /opt/{{ crowd.app_name }}-{{ crowd.version }}/apache-tomcat/lib/mysql-connector-java-5.1.38-bin.jar

crowd_install_dir_permissions:
  file.directory:
    - name: /opt/{{ crowd.app_name }}-{{ crowd.version }}
    - user: crowd
    - group: crowd
    - mode: 755
    - recurse:
      - user
      - group
