# vim: ft=sls
# Init crowd
{%- from "crowd/map.jinja" import crowd with context %}

{% if crowd.enabled %}
include:
  {% if crowd.mockup -%}
  - crowd.mockup
  {%- endif %}
  - crowd.install
  - crowd.config
  - crowd.service
{% else %}
'crowd-formula disabled':
  test.succeed_without_changes
{% endif %}
