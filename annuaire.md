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
  <div class="members-list list">
  {% for row in site.data.members %}
  {% if row.adhesion contains '2016' %}
  <div class="members-list__box" data-id="{{forloop.index}}" data-town="{{row.ville}}">
    <div class="members-list__line name">
        <div class="members-list__item name">
          <span>{{ row.prenom }} {{ row.nom }}</span>
          {{ row.adresse }} {{ row.code-postal }} {{ row.ville }}
        </div>
        <div class="members-list__item location">{{ row.ville }}</div>
    </div>
    <div class="members-list__line">
      <div class="members-list__item téléphone-mobile">
        {% if row.telephone-mobile %}<span>{{ row.telephone-mobile }}</span>{% endif %} {% if row.telephone-mobile %}<span>{{ row.telephone-fixe }}</span>{% endif %}<br>
        {{ row.email }}
        <a href="//{{ row.site-web }}">{{ row.site-web }}</a>
      </div>
    </div>
    <div class="members-list__line">
      <div class="members-list__item activity">
      {% for activity in row.activites %}
      {% for activitycollection in site.activities %}
        {% if activitycollection.title == activity.nom %}
          {% assign activityurl = activitycollection.url %}
       {% endif %}
      {% endfor %}
      <span class="members-list__item__activity activity"><a href="{{ activityurl }}">{{ activity.nom }}</a></span>
      {% endfor %}
      </div>
    </div>
  </div>
  {% endif %}
  {% endfor %}
  </div>

</div>

