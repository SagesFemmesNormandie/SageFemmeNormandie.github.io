---
layout: default
title: accueil
---

##Liste des activités d'une sage femme##

Découvrez les activités proposées par les sages-femmes de l'association.

{% assign items_grouped = site.activities | group_by: 'category' %}

{% for group in items_grouped %}

<h2>{{ group.name }}</h2>
<div class="activity-list">
  {% for item in group.items %}
  {% assign activityrowvaluesum = 0 %}
  {% for row in site.data.google_sheet limit:3 offset:2 %}
    {% for col in row %}
      {% if col == item.title  %}{% assign activitycolnumber = forloop.index0 %}{% endif %}
    {% endfor %}
  {% endfor %}
  {% for row in site.data.google_sheet offset:3 %}
  {% if row[3] contains '2016' %}
    {% if row[activitycolnumber] == '1' %}{% assign activityrowvaluesum = activityrowvaluesumm | plus: 1 %}{% endif %}
    {% assign activityrowvaluesumm = activityrowvaluesum %}
  {% endif %}
  {% endfor %}
  {% if activityrowvaluesumm != 0 %}
  <div class="activity-list__box"> 
    <h3 class="h5"><a href="{{ item.url }}">{{ item.title }}</a></h3>
    {% if item.description %}{{ item.description | markdownify }}{% else %}{{ item.content | truncatewords: 25 | markdownify }}{% endif %}
    
  </div>
  {% endif %}
  {% endfor %}
</div>
{% endfor %}
