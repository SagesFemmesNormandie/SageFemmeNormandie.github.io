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
  <img src="//maps.googleapis.com/maps/api/staticmap?center=duclair,fr&zoom=8&size=600x300&scale=2&sensor=false&visual_refresh=true&style=feature:poi|visibility:off&style=feature:all|saturation:-30|lightness:17|gamma:1&style=feature:road|lightness:0|saturation:0|hue:0xffffff|gamma:0&style=feature:road.highway|element:geometry|lightness:50|saturation:0|hue:0xffffff{% for group in items_grouped %}&markers=color:pink|size:tiny|label:S|{{ group.name }},fr{% endfor %}" style="margin-bottom: 1.5rem;" />
  {% endcomment %}

  {% comment %}
    <img src="//maps.googleapis.com/maps/api/staticmap?{% for location in page.locations %}{% if forloop.first %}center={{location}}&markers=color:blue%7C{{location}}{% else %}&markers=color:blue%7C{{location}}{% endif %}{% endfor %}&zoom={% if page.zoom %}{{page.zoom}}{% else %}13{% endif %}&size=300x200&scale=2&sensor=false&visual_refresh=true" alt="">
  {% endcomment %}

  {% comment %}
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
  {% endcomment %}
  <div class="search">
    <input type="search" placeholder="Chercher une ville, le nom d‘une Sage-femme ou une activité" required="">
  </div>
  <div class="map-link">  
    <a href="{{ site.baseurl }}/carte.html" data-no-instant style="padding-bottom:0.2rem;border-bottom: 1px solid #ccc;">=>Localiser les Sages-femmes sur la carte de Haute-Normandie</a>
  </div>
  <div class="members-list list" itemtype="http://schema.org/ItemList http://schema.org/Midwifery">
  {% for group in items_grouped %}
  {% assign items = group.items | sort: 'nom' %}
  {% for row in items %}
  {% include members-new.html %}
  {% endfor %}
  {% endfor %} 
  </div>

</div>
<script src="{{ site.baseurl }}/assets/js/holmes.js" data-no-instant></script>
<script data-no-instant>
    // holmes setup
    var h = new holmes({
      input: '.search input',
      find: '.members-list .members-list__box',
      placeholder: '<h3>Aucun résultat pour votre recherche</h3>',
      class: {
        visible: 'visible',
        hidden: 'hidden'
      }
    });
</script>

