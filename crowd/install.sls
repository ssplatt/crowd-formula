# vim: ft=sls
# How to install crowd
{%- from "crowd/map.jinja" import crowd with context %}

crowd_pkg:
  archive.extracted:
    - name: /opt/
    - source: https://downloads.atlassian.com/software/crowd/downloads/{{ crowd.app_name }}-{{ crowd.version }}.tar.gz
    - source_hash: md5={{ crowd.pkg_hash }}
    - archive_format: tar
    - options: 'zxf'
    - if_missing: /opt/{{ crowd.app_name }}-{{ crowd.version }}

crowd_install_required_java:
  pkg.installed:
    - name: {{ crowd.required_java }}
    {% if crowd.required_pkgs_repo is defined -%}
    - fromrepo: {{ crowd.required_pkgs_repo }}
    {%- endif %}

{% if crowd.mysql_connector is defined %}
crowd_install_mysql_connector:
  archive.extracted:
    - name: /root/
    - source: http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-{{ crowd.mysql_connector.version }}.tar.gz
    - source_hash: md5={{ crowd.mysql_connector.hash }}
    - archive_format: tar
    - options: 'zxf'
    - if_missing: /root/mysql-connector-java-{{ crowd.mysql_connector.version }}

crowd_copy_mysql_connector:
  cmd.run:
    - name: cp /root/mysql-connector-java-{{ crowd.mysql_connector.version }}/mysql-connector-java-{{ crowd.mysql_connector.version }}-bin.jar /opt/{{ crowd.app_name }}-{{ crowd.version }}/apache-tomcat/lib/
    - unless: test -f /opt/{{ crowd.app_name }}-{{ crowd.version }}/apache-tomcat/lib/mysql-connector-java-{{ crowd.mysql_connector.version }}-bin.jar
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
