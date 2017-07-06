# vim: ft=yaml
# Custom Pillar Data for crowd

crowd:
  enabled: true
  mockup: true
  required_java: openjdk-8-jre-headless
  service:
    name: crowd
    state: running
    enable: true

