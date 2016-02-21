# nyymi

Nyymi on rekrytointipalvelu, joka piilottaa kaikki hakijoiden iän, sukupuolen ja etnisen taustan kertovat tiedot. Tutkitusti yli 50-vuotiaiden sekä maahanmuuttajien on vaikeampi saada töitä, joten Nyymi on tarkoitettu lieventämään työnantajien ennakkoluuloja rekrytoinnissa. 

Nyymissä on kaksi käyttäjätyyppiä, yrityksen ylläpitäjä sekä työnhakija. Yrityksen ylläpitäjä voi tietysti myös hakea töitä. Sovellus itsessään on käyttöohje. 

##Tekninen toteutus

Sovelluksessa on sekä one-to-many että many-to-many-yhteyksiä (yritys - adminkäyttäjä). 

##Ulkoasu

Käytin ulkoasussa http://www.free-css.com/free-css-templates/page193/spot css-templatea itse muokattuna. 

## Yksityisyydenhallinta

Yksityisenhallinnassa käytetään deklaratiivisen autentikoinnin gemiä CanCania (https://github.com/ryanb/cancan ). Se helpottaa sen määrittelyä, mille sivuille mitkäkin käyttäjän saavat mennä. 

##Kielilokalisointi

ei vielä tehty

## Muut ulkoiset gemit
JSONin generoinnin ehdollisuuteen käytin jbuilder-gemiä. (https://github.com/rails/jbuilder). 

##Testausuunnitelma 

Yksikkötestejä User, Company ja OpenJob -olioiden validointiin. 

Kaikki sivut capybara-testataan erityisesti sen varalta, että ulkopuoliset eivät pääse näkemään heille tarkoittamatonta sisältöä. 

###Company

New-sivu
* Jos käyttäjä ei ole kirjautunut, cancan estää pääsemästä new -sivulle

Index-sivu
* Jos käyttäjä ei ole kirjautunut, Luo uusi yritys -nappia ei ole
* Kun käyttäjä luo yrityksen kirjautuneena, hänestä tulee ylläpitäjä.

Edit-sivu: 
* Käyttäjä ei pääse edit-sivulle, jos hän ei ole ylläpitäjä mutta on kirjautunut
* Käyttäjä ei pääse edit-sivulle, jos hän ei ole kirjautunut lainkaan

Administration -sivu
* Käyttäjä ei pääse administration-sivulle, jos hän ei ole ylläpitäjä mutta on kirjautunut
* Käyttäjä ei pääse administration-sivulle, jos hän ei ole kirjautunut lainkaan

Yrityksen poistaminen
* Käyttäjä ei voi poistaa yritystä, jos hän ei ole ylläpitäjä mutta on kirjautunut
* Käyttäjä ei voi poistaa yritystä, jos hän ei ole kirjautunut lainkaan

Administration -sivulle vievä nappi
* Yrityksen sivulla ei näy administration -nappia (vie kyseiselle sivulle), jos käyttäjä on kirjautunut mutta ei ole ylläpitäjä
* Yrityksen sivulla ei näy administration -nappia, jos käyttäjä ei ole kirjautunut lainkaan
* Yrityksen sivulla näkyy administration -nappi 

About -sivu
* Käyttäjä pääsee about-sivulle (Tietoa yritykselle) kirjautuneena
* Käyttäjä pääsee about-sivulle (Tietoa yritykselle) kirjautumattomana 

###User

* Kun käyttäjä ei ole kirjautunut sisään, navigaatiopalkissa näkyy Rekisteröidy -ja Kirjaudu sisään -napit
* Käyttäjä kirjautuu automaattisesti sisään rekisteröityessä
* Kun käyttäjä on kirjautunut sisään, navigaatiopalkissa näkyy Kirjaudu ulos -nappi

* Käyttäjä ei pääse muiden käyttäjien sivulle kirjautuneena
* Käyttäjä ei pääse muiden käyttäjien sivulle kirjautumattomana 

###Open job

###Application

