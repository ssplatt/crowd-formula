# vim: ft=sls
# Init crowd
{%- from "crowd/map.jinja" import crowd with context %}
{# Below is an example of having a toggle for the state #}

{% if crowd.enabled %}
include:
  - crowd.install
  - crowd.config
  - crowd.service
{% else %}
'crowd-formula disabled':
  test.succeed_without_changes
{% endif %}

