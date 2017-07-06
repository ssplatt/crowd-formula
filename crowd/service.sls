# vim: ft=sls
# Manage service for service crowd
{%- from "crowd/map.jinja" import crowd with context %}

crowd_service:
 service.{{ crowd.service.state }}:
   - name: {{ crowd.service.name }}
   - enable: {{ crowd.service.enable }}
   - watch:
     - file: crowd_autostart_script

{% if crowd.mockup %}
crowd_mockup_sql_service:
  service.running:
    - name: mysql
    - enable: true
    - watch:
      - file: crowd_mockup_myconf_settings
{% endif %}
