---
layout: default
title: Annuaire
navigation: true
---

<div class="members" id="users">
  <h2>Trouver une sage-femme libérale en Haute-Normandie</h2>

  {% assign items_grouped-sort = site.data.members | sort: 'ville' %}
  {% assign items_grouped = items_grouped-sort | group_by: 'ville' %}
  {% assign siteyear = site.time | date: '%Y' %}
  
  {% comment %}
  <img src="https://maps.googleapis.com/maps/api/staticmap?center=rouen,fr&zoom=8&size=900x900&maptype=roadmap{% for group in items_grouped %}&markers={{ group.name }},fr{% endfor %}" /> 
  {% endcomment %}

  <nav class="nav-activity">
  <h2>Par villes</h2>
  <ul>
  {% for group in items_grouped %}
  {% if group.items[0].adhesion contains siteyear %}
  <li><a href="#id-{{ group.name | slugify }}">{{ group.name }}</a></li>
  {% endif %}
  {% endfor %}
  </ul>
  </nav>

  <div class="members-list list" itemtype="http://schema.org/ItemList http://schema.org/Midwifery">
  {% for group in items_grouped %}
  {% assign items = group.items | sort: 'nom' %}
  {% for row in items %}
  {% include members-new.html %}
  {% endfor %}
  {% endfor %} 
  </div>

</div>

