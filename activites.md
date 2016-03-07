---
layout: default
title: Activités
navigation: true
---

##Liste des activités d'une sage femme##

Découvrez les activités proposées par les sages-femmes de l'association.  

<br>

<div class="activity-list">
{% for activity in site.activities %}
  {% assign activityrowvaluesum = 0 %}
  {% for row in site.data.google_sheet limit:3 offset:2 %}
    {% for col in row %}
      {% if col == activity.title  %}{% assign activitycolnumber = forloop.index0 %}{% endif %}
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
    <h3 class="h5"><a href="{{ activity.url }}">{{ activity.title }}</a></h3>
    {% if activity.description %}{{ activity.description | markdownify }}{% endif %}
  </div>
  {% endif %}
{% endfor %}
</div>
