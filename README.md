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
JSONin generoinnin ehdollisuuteen käytin jbuilder-gemiä. (https://github.com/rails/jbuilder)

##Testaus 

ei vielä tehty

