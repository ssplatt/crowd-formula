# vim: ft=sls
# Manage service for service crowd
{%- from "crowd/map.jinja" import crowd with context %}

crowd_service:
 service.{{ crowd.service.state }}:
   - name: {{ crowd.service.name }}
   - enable: {{ crowd.service.enable }}
