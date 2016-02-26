# nyymi

Nyymi on rekrytointipalvelu, joka piilottaa kaikki hakijoiden iän, sukupuolen ja etnisen taustan kertovat tiedot.

##Tekninen toteutus ja CI

Sovelluksessa on sekä one-to-many että many-to-many-yhteyksiä. CI-systeeminä on [shippable](https://app.shippable.com/). 

##Ulkoasu

http://www.free-css.com/free-css-templates/page193/spot 

## Yksityisyydenhallinta

Yksityisenhallinnassa käytetään deklaratiivisen autentikoinnin gemiä CanCania (https://github.com/ryanb/cancan ).

##Kielilokalisointi

ei vielä tehty

## Muut ulkoiset gemit tai palvelut
* JSONin generoinnin ehdollisuuteen käytetään [JBuilderia](https://github.com/rails/jbuilder). 
* Kun yritys saa uuden hakemuksen, siitä lähetetään sähköposti ylläpitäjille [Sendgridillä](https://sendgrid.com/).

##Testausuunnitelma 

###Yksikkötestaus

Yksikkötestejä on User, Company ja OpenJob -olioiden validointiin sekä open_jobs.json -vastauksesta varmistamiseen, ettei vanhentuneita avoimia työpaikkoja ole mukana listauksessa. (HUOM tee tämä) 

###Capybara -testaus

Kaikkien luokkien kaikki sivut testataan erityisesti yksityisyyden takaamiseksi. 

###Company

<b>New-sivu</b>
* Jos käyttäjä ei ole kirjautunut, cancan estää pääsemästä new -sivulle t

<b>Index-sivu</b>
* Jos käyttäjä ei ole kirjautunut, Luo uusi yritys -nappia ei ole t
* Kun käyttäjä luo yrityksen kirjautuneena, hänestä tulee ylläpitäjä. t

<b>Edit-sivu: </b>
* Käyttäjä ei pääse edit-sivulle, jos hän ei ole ylläpitäjä mutta on kirjautunut t
* Käyttäjä ei pääse edit-sivulle, jos hän ei ole kirjautunut lainkaan t
* Käyttäjä pääsee edit -sivulle ja muokatut tiedot tulevat näkyviin yrityksen sivulla muokkauksen jälkeen jos ylläpitäjä t

<b>Administration -sivu</b>
* Käyttäjä ei pääse administration-sivulle, jos hän ei ole ylläpitäjä mutta on kirjautunut t
* Käyttäjä ei pääse administration-sivulle, jos hän ei ole kirjautunut lainkaan t
* Käyttäjä pääsee administration -sivulle, jos hän on ylläpitäjä t

<b>Yrityksen poistaminen</b>
* Käyttäjä voi poistaa yrityksen kirjautuneena ylläpitäjänä

<b>Administration -sivulle vievä nappi</b>
* Yrityksen sivulla ei näy administration -nappia (vie kyseiselle sivulle), jos käyttäjä on kirjautunut mutta ei ole ylläpitäjä t
* Yrityksen sivulla näkyy administration -nappi jos käyttäjä on ylläpitäjä t

<b>About -sivu</b>
* Käyttäjä pääsee about-sivulle (Tietoa yritykselle) kirjautuneena t
* Käyttäjä pääsee about-sivulle (Tietoa yritykselle) kirjautumattomana  t

###User

<b>Rekisteröityminen:</b>
* Kun käyttäjä ei ole kirjautunut sisään, navigaatiopalkissa näkyy Rekisteröidy -ja Kirjaudu sisään -napit t
* Käyttäjä kirjautuu automaattisesti sisään rekisteröityessä t
* Kun käyttäjä on kirjautunut sisään, navigaatiopalkissa näkyy Kirjaudu ulos -nappi t

<b>Show-sivu</b>
* Käyttäjä ei pääse muiden käyttäjien sivulle kirjautuneena
* Käyttäjä ei pääse muiden käyttäjien sivulle kirjautumattomana 


<b>Edit -sivu</b>
* Käyttäjä ei voi muokata muiden käyttäjien tietoja kirjautumattomana
* Käyttäjä ei voi muokata muiden käyttäjien tietoja kirjautuneena
* Käyttäjä voi muokata omia tietojaan 

###Open job

* Yrityksen ylläpitäjä voi luoda uuden avoimen työpaikan administration -sivulta 

###Application



#TODO: 

2. haastattelukutsu jollakin message gemillä https://github.com/mailboxer/mailboxer 
3. react näkymiä 
4. kielilokalisointi
5. https://github.com/plataformatec/devise autentikointi 

