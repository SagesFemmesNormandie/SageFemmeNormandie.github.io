---
layout: default
title: Activités
navigation: true
---

##Liste des activités d'une sage femme##

Découvrez les activités proposées par les sages-femmes de l'association.

{% for activity in site.activities %}
  <h3><a href="{{ activity.url }}">{{ activity.title }}</a></h3>
  {% if activity.description %}{{ activity.description | markdownify }}{% endif %}
{% endfor %}
