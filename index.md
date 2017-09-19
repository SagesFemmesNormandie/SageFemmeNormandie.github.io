---
layout: default
title: Trouver une sage femme
---

# Une sage-femme, pour pratiquer de nombreuses activités&nbsp;: #

Découvrez les activités proposées par les sages-femmes de l'association.

{% assign items_grouped-sort = site.activities | sort: 'category' %}
{% assign items_grouped = items_grouped-sort | group_by: 'category' %}
{% assign items = site.data.members | sort: 'ville' %}

{% for group in items_grouped %}

<h2 class="activity-{{ group.name | slugify }}">{{ group.name }}</h2>
<div class="activity-list">
  {% for item in group.items %}
  {% assign activitycheck = 0 %}
  {% for row in items %}
  {% for activity in row.activites %}
  {% if activity.nom contains item.title %}
    {% assign activitycheck = 1 %}
  {% endif %}
  {% endfor %}
  {% endfor %}
  {% if activitycheck != 0 %}
  <div class="activity-list__box">  
    <h3 class="h5"><a href="{{ item.url }}">{{ item.title }}</a></h3>
    {% if item.description %}{{ item.description | markdownify }}{% else %}{% if item.content %}{{ item.content | truncatewords: 25 | markdownify }}{% else %}Découvrez l'activité {{ item.title }}{% endif %}{% endif %}
  </div>
  {% endif %}
  {% endfor %} 
</div>
{% endfor %}
