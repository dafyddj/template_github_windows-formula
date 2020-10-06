# -*- coding: utf-8 -*-
# vim: ft=sls
---
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import TEMPLATE as mapdata with context %}

{%- do salt['log.debug']('### MAP.JINJA DUMP ###\n' ~ mapdata | yaml(False)) %}

{%- set tmp = {'Windows': 'TMP'}[grains['kernel']] | default('TMPDIR') %}
{%- set output_file = salt['environ.get'](tmp) ~ '/salt_mapdata_dump.yaml' %}

{{ tplroot }}-mapdata-dump:
  file.managed:
    - name: {{ output_file }}
    - source: salt://{{ tplroot }}/_mapdata/_mapdata.jinja
    - template: jinja
    - context:
        map: {{ mapdata | yaml }}
