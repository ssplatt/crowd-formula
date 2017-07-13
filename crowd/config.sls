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

{% if grains.init == 'systemd' %}
crowd_systemd_script:
  file.managed:
    - name: /lib/systemd/system/crowd.service
    - source: salt://crowd/files/systemd_crowd.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - watch_in:
      - service: crowd_service

crowd_systemd_daemon_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: crowd_systemd_script
{% else %}
crowd_initd_script:
  file.managed:
    - name: /etc/init.d/crowd
    - source: salt://crowd/files/initd_crowd.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 0755
    - watch_in:
      - service: crowd_service
{% endif %}
