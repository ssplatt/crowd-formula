# vim: ft=sls
# How to configure crowd
{%- from "crowd/map.jinja" import crowd with context %}

crowd_app_symlink:
  file.symlink:
    - name: /opt/{{ crowd.app_name }}
    - target: /opt/{{ crowd.app_name }}-{{ crowd.version }}

crowd_init_properties_config:
  file.managed:
    - name: /opt/{{ crowd.app_name }}-{{ crowd.version }}/crowd-webapp/WEB-INF/classes/crowd-init.properties
    - source: salt://crowd/files/crowd-init.properties.j2
    - user: crowd
    - group : crowd
    - mode: 0644
    - template: jinja

crowd_autostart_script:
  file.managed:
    - name: /etc/init.d/crowd
    - source: salt://crowd/files/initd_crowd.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0755

{% if crowd.mockup %}
crowd_mockup_myconf_settings:
  file.managed:
    - name: /etc/mysql/my.cnf
    - source: salt://crowd/files/my.cnf
    - user: root
    - group: root
    - mode: 0644
{% endif %}
