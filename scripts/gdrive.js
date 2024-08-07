const fetch = require('node-fetch')
const fs = require('fs');
const slugify = require('slugify');
const YAML = require('json-to-pretty-yaml');

const activitieslist = [
  "Accompagnement allaitement maternel",
  "Accompagnement global",
  "Acupuncture",
  "Chant prénatal",
  "Consultation de suivi de grossesse",
  "Consultation de suivi gynécologique et contraception",
  "Consultation post - natale",
  "Consultation préconceptionnelle",
  "Echographie",
  "Entretien prénatal précoce",
  "Eveil du bébé par le toucher",
  "Haptonomie",
  "Hypnose",
  "IVG",
  "Monitoring",
  "Ostéopathie",
  "Portage des bébés",
  "Préparation à la naissance",
  "Préparation en piscine",
  "Psycho périnatalité",
  "Rééducation du périnée",
  "Sevrage tabagique",
  "Sophrologie",
  "Suivi du nourrisson",
  "Suivi post natal mère - enfant / PRADO",
  "Surveillance de grossesse pathologique",
  "Thérapie cellulaire active - TECAR thérapie",
  "Thérapie sexo - corporelle",
  "Yoga"
]



// https://benborgers.com/posts/google-sheets-json
// https://stackoverflow.com/questions/69045745/how-do-i-fetch-google-spreadsheet-data-from-javascript-in-sheets-v4-api-as-json
// https://dev.to/marcusatlocalhost/request-google-sheets-json-api-v4-with-php-12ji


//https://docs.google.com/spreadsheets/d/1nt-D_VmZT4ex_7EwkXRlcj2jIJ4gafgm1mtuxkbhSts/edit#gid=0
//https://spreadsheets.google.com/feeds/cells/1nt-D_VmZT4ex_7EwkXRlcj2jIJ4gafgm1mtuxkbhSts/1/public/full?alt=json
//
//https://sheets.googleapis.com/v4/spreadsheets/1nt-D_VmZT4ex_7EwkXRlcj2jIJ4gafgm1mtuxkbhSts

function getJson(id, gid) {
  fetch(`https://docs.google.com/spreadsheets/d/${id}/gviz/tq?tqx=out:json`)
  .then(res => res.text())
  .then(text => {
    const json = JSON.parse(text.substr(47).slice(0, -2))
    return json
  })
  .then(json => {
    const data = []
    const cols = json.table.cols
    const rows = json.table.rows
    for (const row of rows) {
      var formattedRow = new Object()
      var activites = []
      var activitesdata = []
      activites.splice(0,activites.length);
      activitesdata.splice(0,activitesdata.length);
      row.c.forEach(function (value, i) { 
        if (value && value.v !== null) {
          if (rows[1].c[i] !== null) {
            if (rows[1].c[i].v !== null) {
              var key = slugify(rows[1].c[i].v.toLowerCase().trim())
              key = key.includes('ttention') ? 'ville' : key;
              if (value && key && value.v !== null && (value.v !== 1 && value.v !== 0)) {
                formattedRow[key] = value.v.trim();
              }
            }
          }
          if (i == 6) {
            if (value && value.v !== null) {
              formattedRow['code-postal'] = value.v;
            }
          }
          if (i >= 13) {
            if (value && value.v !== null && (value.v === 1 || value.v === 0)) {
              activitesdata.push({ "nom": activitieslist[i-13] });
            }
          }
        }
      })
      if (formattedRow['prenom']) {
        formattedRow['nom_entier'] = slugify(formattedRow['prenom'] + '-' + formattedRow['nom']).toLowerCase().trim();
        formattedRow['activites'] = activitesdata;
        data.push(formattedRow)
      }
      var formattedRow = new Object()
    }
    const dataYAML = YAML.stringify(data);
    if (!fs.existsSync('./_data/')) {
      fs.mkdirSync('./_data/');
      console.log('create : ./_data/')
    }
    fs.writeFileSync('./_data/members.yml', dataYAML, 'utf8');
    console.log('create : ./_data/members.yml')
  }).catch((error) => {
    console.error(error,'Promise error');
});
}

getJson('1nt-D_VmZT4ex_7EwkXRlcj2jIJ4gafgm1mtuxkbhSts','1')
