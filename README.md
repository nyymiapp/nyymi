# nyymi

[![Coverage Status](https://coveralls.io/repos/github/nyymiapp/nyymi/badge.svg?branch=master)](https://coveralls.io/github/nyymiapp/nyymi?branch=master)

[![Build Status](https://travis-ci.org/nyymiapp/nyymi.svg?branch=master)](https://travis-ci.org/nyymiapp/nyymi)

[Aikakirjanpito](https://docs.google.com/spreadsheets/d/1HR3h8OUmtGv9Rlxunj25JdfaotxLDICiaqsESHZKF8A/edit?usp=sharing) [Heroku](https://nyymi.herokuapp.com/)

## Käyttö
Tätä sovellusta käytetään anonyymiin työnhakuun. Se piilottaa hakijasta nimen sekä muut yhteystiedot ja opiskelupaikoista koulun nimen. Työnantaja luo yrityksen ja asettaa sille avoimia työpaikkoja, joita muut käyttäjät voivat hakea. 

## Ulkoiset gemit

[Sendgrid](http://sendgrid.com/) hoitaa sähköpostien lähetyksen.

[CanCan](https://github.com/ryanb/cancan) huolehtii sivujen authorisoinnista ja näin on mahdollista yhdestä CanCanin määrittelytiedostosta nähdä millaiset käyttäjät pääsevät katsomaan mitäkin sivua.

[Pusher](https://pusher.com/) huolehtii chatin viestien lähetyksen websocketeilla. 

[Database Cleaneria](https://github.com/DatabaseCleaner/database_cleaner) käytetään testeissä tietokannan tyhjennykseen.

[Bootstrap](http://getbootstrap.com/components/) tyyleihin.

Google maps karttoihin

## Testausperiaate

RSpec-testeillä testataan ainoastaan olioiden validointia. 
Aluksi testausperiaatteena oli kirjoittaa selaintestit [CanCan-sääntöjen](https://github.com/nyymiapp/nyymi/blob/master/app/models/ability.rb) pohjalta. Tämä periaate onkin nähtävissä joissain selaintesteissä kuten [companies_page_specissä](https://github.com/nyymiapp/nyymi/blob/master/spec/features/companies_page_spec.rb). Testien kirjoituksen aikana huomattiin että tämä lähestymistapa on hyvin työläs ja siirryttiin coverage-driven-testaukseen. 


