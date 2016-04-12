---
layout: default
title: Annuaire
navigation: true
---

<div class="members" id="users">
  <h2>Trouver une sage femme libérale en Normandie</h2>
  <!-- <input class="search" placeholder="Trier">
  <button class="sort" data-sort="name">Trier par nom</button>
  <button class="sort" data-sort="activity">Trier par activité</button>
  <br>
  <br> -->
  <div class="members-list list">
    {% for row in site.data.google_sheet offset:3 %}
    {% if row[3] contains '2015' %}
      {% include members.html %}
      {% endif %}
    {% endfor %} 
  </div> 
</div>

