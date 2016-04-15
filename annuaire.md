---
layout: default
title: Annuaire
navigation: true
---

<div class="members" id="users">
  <h2>Trouver une sage femme libérale en Haute-Normandie</h2>
  <!-- <input class="search" placeholder="Trier">
  <button class="sort" data-sort="name">Trier par nom</button>
  <button class="sort" data-sort="activity">Trier par activité</button>
  <br>
  <br> --> 
  {% assign items_grouped-sort = site.data.members | sort: 'ville' %}
  {% assign items_grouped = items_grouped-sort | group_by: 'ville' %}
  {% assign items = site.data.members | sort: 'ville' %}

  <nav class="nav-activity">
  <h2>Par villes</h2>
  <ul>

  {% for group in items_grouped %} 
  {% if group.items[0].adhesion contains '2016' %}
  <li><a href="#id-{{ group.name | slugify }}">{{ group.name }}</a></li>
  {% endif %}
  {% endfor %} 
  </ul>
  </nav>

  <div class="members-list list">
  {% for row in items %}
  {% include members-new.html %}
  {% endfor %}
  </div>

</div>

