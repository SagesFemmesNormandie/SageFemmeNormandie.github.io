---
layout: default
title: Trouver une sage femme
---


<div class="jumbo">
<h1>Une sage-femme<br>pour pratiquer de nombreuses activités</h1>
Découvrez les activités proposées par les sages-femmes de l'association.
</div>

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
    <h3><a href="{{ item.url }}">{{ item.title }}</a></h3>
    {% if item.description %}{{ item.description | markdownify }}{% else %}{% if item.content %}{{ item.content | truncatewords: 25 | markdownify }}{% else %}Découvrez l'activité {{ item.title }}{% endif %}{% endif %}
  </div>
  {% endif %}
  {% endfor %}
</div>
{% endfor %}
