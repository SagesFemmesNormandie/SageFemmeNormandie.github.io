---
layout: default
title: accueil
---

<div class="members" id="users">
  <h2>Trouver une sage femme libérale en Normandie</h2>
  <!-- <input class="search" placeholder="Trier">
  <button class="sort" data-sort="name">Trier par nom</button>
  <button class="sort" data-sort="activity">Trier par activité</button>
  <br>
  <br> -->
  <div class="members-list list">
    {% assign coltitle = "Nom|Prénom|Téléphone" | split: "|" %}
    {% for row in site.data.google_sheet offset:3 %}
    {% if row[3] contains '2016' %}
      {% include members.html %}
      {% endif %}
    {% endfor %}
  </div>
</div>
