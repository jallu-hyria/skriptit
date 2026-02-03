#!/bin/bash
# Versio 1.00. 12.2.2025. Jalmari Valimaan tikkukirjaimilla koodattu
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/                 

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m' 
BLUE='\033[1;34m'
NORMAL='\e[0m'

echo ""
    echo -e "${GREEN} Vihreä teksti tarkoittaa, että tehtävän kohta on oikein tehty ${NORMAL}"
    echo -e "${RED} Punainen teksti tarkoittaa, että tehtävän kohta on todennäköisesti väärin tehty ${NORMAL}"
    echo -e "${YELLOW} Keltainen teksti tarkoittaa, että tehtävän kohta oli sellainen jota skripti ei osaa tarkistaa ${NORMAL}"
echo -e "${WHITE}"	

# PS3 muuttuja on erikoismuuttuja joka ottaa vastaan käyttäjän syötettä skriptin sisällä
PS3='Minkä tehtävän haluat tarkistaa? ' 

# Mitkä valinnat näytetään käyttäjälle
options=("001 Verkon konfigurointi ja asennus" "002 Linux komentoja #2" "003 Linux käyttäjät ja oikeudet" "004 Työasemien asentaminen" "005 DHCP palvelin" "006 SSH" "007 WWW Apache" "008 Palomuuri UFW" "009 DNS BIND9" "010 Skriptaus ja Cron" "Poistu") 

# Luodaan menu ja määritellään miten käsitellään vaihtoehdot 
select opt in "${options[@]}" 
do 
case $opt in 

"001 Verkon konfigurointi ja asennus") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 001 ================ ${NORMAL}"
echo ""

# IP-osoite ja aliverkonmaski
IPjaSMosoite=$(ip a | grep "192.168.1.30/24")
if [[ $? != 0 ]];
then
	echo -e "${RED}IP-osoite ja/tai aliverkonmaski ovat väärin. Niiden pitäisi olla 192.168.1.30 ja /24 eli 255.255.255.0 ${NORMAL}"
else
	echo -e "${GREEN}IP-osoite ja aliverkonmaski ovat oikein ${NORMAL}"
fi

# Oletusyhdyskäytävä
GWosoite=$(ip r | grep "192.168.1.1")
if [[ $? != 0 ]];
then
	echo -e "${RED}Oletusyhdyskäytävä on väärin. Sen pitäisi olla 192.168.1.1 ${NORMAL}"
else
	echo -e "${GREEN}Aliverkonmaski on oikein ${NORMAL}"
fi

# DNS osoite
DNSosoite=$(grep "nameserver 8.8.8.8" /etc/resolv.conf)
if [[ $? != 0 ]];
then
	echo -e "${RED}DNS osoite on väärin. Sen pitäisi olla 8.8.8.8 ${NORMAL}"
else
	echo -e "${GREEN}DNS osoite on oikein ${NORMAL}"
fi

#Tietokoneen nimi
tietokoneenNimi=$(hostname | grep "LNXSRVDEB")
if [[ $? != 0 ]];
then
	echo -e "${RED}Tietokoneen nimi on väärin. Sen pitäisi olla LNXSRVDEB ${NORMAL}"
else
	echo -e "${GREEN}Tietokoneen nimi on oikein ${NORMAL}"
fi

#Rootin salis
echo -e "${YELLOW}Onhan Rootin salasana Sala1234 ${NORMAL}"

#Asentajan tili löytyy
asentajaNimi=$(grep "asentaja" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjän nimi on väärin. Sen pitäisi olla asentaja ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjän nimi on oikein ${NORMAL}"
fi

#Asentajan salis
echo -e "${YELLOW}Onhan käyttäjän asentaja salasana Sala1234 ${NORMAL}"

#pingaukset
ping1="8.8.8.8"
ping -c 1 $ping1 > /dev/null
if [ $? -eq 0 ]; then
	echo -e "${GREEN}Pingaus osoitteeseen $ping1 onnistui ${NORMAL}"
else
	echo -e "${RED}Pingaus osoitteeseen $ping1 ei onnistunut ${NORMAL}"
fi
ping2="google.com"
ping -c 1 $ping2 > /dev/null
if [ $? -eq 0 ]; then
	echo -e "${GREEN}Pingaus osoitteeseen $ping2 onnistui ${NORMAL}"
else
	echo -e "${RED}Pingaus osoitteeseen $ping2 ei onnistunut ${NORMAL}"
fi

#Asentajan sudo oikeudet
asentajaSudo=$(grep "asentaja ALL=(ALL:ALL) ALL" /etc/sudoers)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjällä asentaja ei ole sudo oikeuksia ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjällä asentaja on sudo oikeudet ${NORMAL}"
fi

#sudo käytöstä
echo -e "${YELLOW}Olethan kokeillut komentoa apt install links ilman sudo oikeuksia? Asennuksen ei pitäisi onnistua ${NORMAL}"

#onko links asennettu?
linksAsennettu=$(dpkg-query -W links | grep "links")
if [[ "$linksAsennettu" =~ "links" ]]; then
	echo -e "${GREEN}Links on asennettu ${NORMAL}"
else
	echo -e "${RED}Links ei ole asennettu ${NORMAL}"
fi

;; 
"002 Linux komentoja #2") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 002 ================ ${NORMAL}"
echo ""

#peruskomentoja
echo -e "${YELLOW}cd komennolla liikutaan Linuxin kansiorakenteessa ja / eli kauttaviiva kuvaa Linuxin juurihakemistoa, joka on vähän verrattavissa Windowsin C:\ asemaan ${NORMAL}"
echo -e "${YELLOW}Komennolla cd /var/log siirtyisit kyseiseen kansioon ${NORMAL}"
echo -e "${YELLOW}komento cd .. siirtyy kansiorakenteessa ylöspäin. Tässä tapauksessa kansiosta /var/log kansioon /var ${NORMAL}"
echo -e "${YELLOW}mkdir komennolla voi luoda uusia kansioita ${NORMAL}"
echo -e "${YELLOW}ls komento näyttää mitä tiedostoja/kansioita halutussa sijainnissa on ${NORMAL}"
echo -e "${YELLOW}pwd kertoo missä kansiossa olet tällä hetkellä ${NORMAL}"

#onko /var/testi olemassa
if test -d "/testi"; then
	echo -e "${GREEN}Kansio /testi on olemassa ${NORMAL}"
else
	echo -e "${RED}Kansiota /testi ei ole olemassa ${NORMAL}"
fi

echo -e "${YELLOW}pwd kertoo missä kansiossa olet tällä hetkellä ${NORMAL}"
echo -e "${YELLOW}mv komennolla voi siirtää ja uudelleennimetä tiedostoja/kansioita ${NORMAL}"

#onko /oikea.txt olemassa
if test -f "/oikea.txt"; then
	echo -e "${GREEN}Tiedosto /oikea.txt on olemassa ${NORMAL}"
else
	echo -e "${RED}Tiedostoa /oikea.txt ei ole olemassa ${NORMAL}"
fi

echo -e "${YELLOW}~ eli aaltoviivalla ilmaistaan käyttäjän kotikansiota ${NORMAL}"

#onko /home/asentaja/kotitesti poistettu
if test -d "/home/asentaja/kotitesti"; then
	echo -e "${RED}Kansio /home/asentaja/kotitestit on olemassa ${NORMAL}"
else
	echo -e "${GREEN}Kansiota /home/asentaja/kotitesti ei ole olemassa ${NORMAL}"
fi

#onko /kissat/ruoka/omistaja.txt olemassa
if test -f "/kissat/ruoka/omistaja.txt"; then
	echo -e "${GREEN}Tiedosto /kissat/ruoka/omistaja.txt on olemassa ${NORMAL}"
else
	echo -e "${RED}Tiedostoa /kissat/ruoka/omistaja.txt ei ole olemassa ${NORMAL}"
fi

#kissa omistaja.txt
omistajaTXT=$(grep "asentaja" /kissat/ruoka/omistaja.txt)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston sisältö on oikein ${NORMAL}"
fi

#onko /koirat/.saksanpaimenkoira olemassa
if test -f "/koirat/.saksanpaimenkoira/.poliisikoira.txt"; then
	echo -e "${GREEN}Tiedosto /koirat/.saksanpaimenkoira/.poliisikoira.txt on olemassa ${NORMAL}"
else
	echo -e "${RED}Tiedostoa /koirat/.saksanpaimenkoira/.poliisikoira.txt ei ole olemassa ${NORMAL}"
fi

#kissa omistaja.txt
poliisikoiraTXT=$(grep "rex" /koirat/.saksanpaimenkoira/.poliisikoira.txt)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}ls -a komennolla näkee piilotetut kansiot ja tiedostot ${NORMAL}"

;; 
"003 Linux käyttäjät ja oikeudet") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 003 ================ ${NORMAL}"
echo ""

#onko käyttäjä olemassa?
mikkoON=$(grep "mikko" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjää mikko ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjä mikko on olemassa ${NORMAL}"
fi

#onko käyttäjä olemassa?
sallaON=$(grep "salla" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjää salla ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjä salla on olemassa ${NORMAL}"
fi

echo -e "${YELLOW}Salasanan saa vaihdettua komennolla passwd ${NORMAL}"

#onko ryhmä olemassa?
tuomaritON=$(grep "tuomarit" /etc/group)
if [[ $? != 0 ]];
then
	echo -e "${RED}Ryhmää tuomarit ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Ryhmä tuomarit on olemassa ${NORMAL}"
fi

#onko ryhmä olemassa?
kisaajatON=$(grep "kisaajat" /etc/group)
if [[ $? != 0 ]];
then
	echo -e "${RED}Ryhmää kisaajat ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Ryhmä kisaajat on olemassa ${NORMAL}"
fi

#onko käyttäjä oikeassa ryhmässä
sallaRyhma=$(grep "tuomarit" /etc/group | grep "salla")
if [[ $? != 0 ]];
then
	echo -e "${RED}salla ei ole ryhmässä tuomarit${NORMAL}"
else
	echo -e "${GREEN}salla on ryhmässä tuomarit ${NORMAL}"
fi

#onko käyttäjä oikeassa ryhmässä
mikkoRyhma=$(grep "tuomarit" /etc/group | grep "mikko")
if [[ $? != 0 ]];
then
	echo -e "${RED}mikko ei ole ryhmässä tuomarit${NORMAL}"
else
	echo -e "${GREEN}mikko on ryhmässä tuomarit ${NORMAL}"
fi

#onko käyttäjä olemassa?
aleksiON=$(grep "aleksi" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjää aleksi ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjä aleksi on olemassa ${NORMAL}"
fi

#onko käyttäjä oikeassa ryhmässä
aleksiRyhma=$(grep "kisaajat" /etc/group | grep "aleksi")
if [[ $? != 0 ]];
then
	echo -e "${RED}aleksi ei ole ryhmässä kisaajat${NORMAL}"
else
	echo -e "${GREEN}aleksi on ryhmässä kisaajat ${NORMAL}"
fi

#/oikeudet1 kansion oikeudet
oikeudet1=$(ls -al / | grep oikeudet1 | grep drwxrwxrwx)
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /oikeudet1 oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /oikeudet1 oikeudet ovat oikein ${NORMAL}"
fi

#/permissions2 kansion oikeudet
permissions2=$(ls -al / | grep permissions2 | grep drwxrwxr--)
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /permissions2 oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /permissions2 oikeudet ovat oikein ${NORMAL}"
fi

#/rights3 kansion oikeudet
rights3=$(ls -al / | grep rights3 | grep drwx------)
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /rights3 oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /rights3 oikeudet ovat oikein ${NORMAL}"
fi

#/permissions2 kansion omistaja
permissions2=$(ls -al / | grep permissions2 | grep "salla")
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /permissions2 omistaja on väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /permissions2 omistaja ovat oikein ${NORMAL}"
fi

#/rights3 kansion omistajaryhmä
rights3=$(ls -al / | grep rights3 | grep "tuomarit")
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /rights3 omistajaryhmä on väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /rights3 omistajaryhmä on oikein ${NORMAL}"
fi

echo -e "${YELLOW}Oikeuksia ja omistajia voi muokata chmod sekä chown komennoilla. ls -l komennolla nämä tiedot saa luettua ${NORMAL}"

#/donotdelete kansion omistajaryhmä
donotdelete=$(ls -al / | grep donotdelete | grep "drwxr-xr-t")
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /donotdelete oikeudet ja stickybit ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /donotdelete oikeudet ja stickybit ovat oikein ${NORMAL}"
fi

;; 
"004 Työasemien asentaminen")
echo "" 
echo -e ${BLUE}"================ Tarkistetaan tehtävä 004 ================ ${NORMAL}"
echo ""

echo -e ${YELLOW}"Tässä tehtävässä ei ole kohtia, joita skripti voisi tarkistaa palvelimelta ${NORMAL}"
;; 
"005 DHCP palvelin") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 005 ================ ${NORMAL}"
echo ""

scopePortIP=$(grep "enp0s3/192.168.1.30" /etc/kea/kea-dhcp4.conf)
if [[ $scopePortIP =~ "enp0s3/192.168.1.30" ]]
then
	echo -e "${GREEN}DHCP palvelun verkkokortin portti ja IP-osoite ovat oikeat ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun verkkokortin portti ja IP-osoite ovat väärin ${NORMAL}"
fi

#DHCP osoitealue
scopeSubnet=$(grep "192.168.1.0/24" /etc/kea/kea-dhcp4.conf)
if [[ $scopeSubnet =~ "192.168.1.0/24" ]]
then
	echo -e "${GREEN}DHCP palvelun osoitealue on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun osoitealue on väärin ${NORMAL}"
fi

#DHCP jaettavat osoitteet
scopeRange=$(grep "192.168.1.200 - 192.168.1.230" /etc/kea/kea-dhcp4.conf)
if [[ $scopeRange =~ "192.168.1.200 - 192.168.1.230" ]]
then
	echo -e "${GREEN}DHCP palvelun jaettavat osoitteet ovat oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jaettavat osoitteet ovat väärin ${NORMAL}"
fi

#DHCP GW osoite
scopeGW=$(grep "192.168.1.1" /etc/kea/kea-dhcp4.conf)
if [[ $scopeGW =~ "192.168.1.1" ]]
then
	echo -e "${GREEN}DHCP palvelun jakama oletusyhdyskäytävän osoite on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jakama oletusyhdyskäytävän osoite on väärin ${NORMAL}"
fi

#DHCP DNS osoite
scopeDNS=$(grep "8.8.8.8" /etc/kea/kea-dhcp4.conf)
if [[ $scopeDNS =~ "8.8.8.8" ]]
then
	echo -e "${GREEN}DHCP palvelun jakama DNS osoite on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jakama DNS osoite on väärin ${NORMAL}"
fi

#DHCP status
dhcpStatus=$(systemctl status kea-dhcp4-server | grep "Active:")
if [[ $dhcpStatus =~ "Active: active" ]]
then
	echo -e "${GREEN}DHCP palvelu on käytössä ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelu ei ole käytössä ${NORMAL}"
fi

echo -e "${YELLOW}Testasithan yhteyden Linux työasemaan pingaamalla niitä? ${NORMAL}"
echo -e "${YELLOW}Saihan LNXWSK001 työasema IP-asetukset DHCP-palvelulta eli se ei enää käytä kiinteitä IP-asetuksia? ${NORMAL}"

#Palvelimelta varmistus onko IP-asetuksia jaettu
lnxwksDHCP=$(grep "lnxwksubu" /var/lib/kea/kea-leases4.csv)
if [[ $? != 0 ]];
then
	echo -e "${RED}Työasemalle lnxwksubu ei ole jaettu IP-osoite ${NORMAL}"
else
	echo -e "${GREEN}Työasemalle lnxwksubu on jaettu IP-osoite ${NORMAL}"
fi

#Palvelimelta varmistus onko IP-asetuksia jaettu
winwksDHCP=$(grep "winwksl" /var/lib/kea/kea-leases4.csv)
if [[ $? != 0 ]];
then
	echo -e "${RED}Työasemalle winwksl ei ole jaettu IP-osoite ${NORMAL}"
else
	echo -e "${GREEN}Työasemalle winwksl on jaettu IP-osoite ${NORMAL}"
fi

echo -e "${YELLOW}Testasithan yhteyden Linux ja Windows työasemiin pingaamalla niitä? ${NORMAL}"
echo -e "${YELLOW}Saihan LNXWSKUBU työasema IP-asetukset DHCP-palvelulta eli se ei enää käytä kiinteitä IP-asetuksia? ${NORMAL}"
;; 

"006 SSH") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 006 ================ ${NORMAL}"
echo ""

#onko käyttäjä olemassa?
villeON=$(grep "ville" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjää ville ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjä ville on olemassa ${NORMAL}"
fi

#SSH status
sshStatus=$(systemctl status sshd | grep "Active:")
if [[ $sshStatus =~ "Active: active" ]]
then
	echo -e "${GREEN}SSH palvelu on päällä ${NORMAL}"
else	
	echo -e "${RED}SSH palvelu ei ole päällä ${NORMAL}"
fi

#Root saa kirjautua SSH kautta
sshRootLuvat=$(grep '^[^#]*PermitRootLogin' /etc/ssh/sshd_config)
if [[ $sshRootLuvat =~ "yes" ]]
then
	echo -e "${GREEN}Root saa kirjautua SSH kautta ${NORMAL}"
else	
	echo -e "${RED}Root ei saa kirjautua SSH kautta  ${NORMAL}"
fi

#SSH kirjautumisaika
sshLoginGraceTime=$(grep '^[^#]*LoginGraceTime' /etc/ssh/sshd_config)
if [[ $sshLoginGraceTime == "LoginGraceTime 15" ]]
then
	echo -e "${GREEN}Kirjautumisaika on oikein ${NORMAL}"
else	
	echo -e "${RED}Kirjautumisaika on väärin  ${NORMAL}"
fi

#SSH portti
sshPort=$(grep '^[^#]*Port' /etc/ssh/sshd_config)
if [[ $sshPort == "Port 1337" ]]
then
	echo -e "${GREEN}SSH portti on oikein  ${NORMAL}"
else	
	echo -e "${RED}SSH portti on väärin ${NORMAL}"
fi

#SSH Bannerin polku
sshBannerPolku=$(grep '^[^#]*Banner' /etc/ssh/sshd_config)
if [[ $sshBannerPolku == "Banner /etc/banner" ]]
then
	echo -e "${GREEN}Bannerin polku on oikein ${NORMAL}"
else	
	echo -e "${RED}Bannerin polku on väärin  ${NORMAL}"
fi

#SSH banner tiedoston sisältö
etcBANNER=$(grep "Kirjauduttu SSH-yhteydellä!" /etc/banner)
if [[ $? != 0 ]];
then
	echo -e "${RED}/etc/banner tiedoston sisältö on väärin. ${NORMAL}"
else
	echo -e "${GREEN}/etc/banner tiedoston sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}Olethan käynnistänyt ssh palvelun uudestaan systemctl komennolla? ${NORMAL}"
echo -e "${YELLOW}Olethan testannut SSH-yhteyden toiminnan työasemilta palvelimelle? ${NORMAL}"

;; 

"007 WWW Apache") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 007 ================ ${NORMAL}"
echo ""

echo -e "${YELLOW}Testasithan verkkosivujen toiminnan työasemalta käsin? ${NORMAL}"

documentRoot=$(grep -oP 'DocumentRoot \K.*' /etc/apache2/sites-enabled/000-default.conf)
if [[ $documentRoot == "/var/verkkosivut" ]]
then
	echo -e "${GREEN}Verkkosivun documentRoot eli polku on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun documentRoot eli polku on väärin  ${NORMAL}"
fi

echo -e "${YELLOW}Onko konfiguraatio testattu apachectl configtest komennolla? ${NORMAL}"

#/var/verkkosivut/index.html sisältö
indexSisalto=$(grep "asentaja testaa" /var/verkkosivut/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/verkkosivut/index.html sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}/var/verkkosivut/index.html sisältö on oikein ${NORMAL}"
fi

#/var/verkkosivut/suklaa/index.html sisältö
suklaaSisalto=$(grep "fazerin sininen" /var/verkkosivut/suklaa/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/verkkosivut/suklaa/index.html sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}/var/verkkosivut/suklaa/index.html sisältö on oikein ${NORMAL}"
fi

#Onko kuvaa sivulla?
suklaaKuva=$(grep "<img" /var/verkkosivut/suklaa/index.html)
if [[ $suklaaKuva =~ "<img" ]]
then
	echo -e "${GREEN}/var/verkkosivut/suklaa/index.html sisältä löytyi <img> tagit ${NORMAL}" 
else
	echo -e "${RED}/var/verkkosivut/suklaa/index.html ei näyttäisi olevan kuvaa eli <img> tagia ${NORMAL}"
fi

echo -e "${YELLOW}Onhan kuvassa suklaata? ${NORMAL}"
echo -e "${YELLOW}Testasithan suklaa sivun toiminnan työasemalta käsin? ${NORMAL}"

#/var/verkkosivut/suklaa/chocolate.html sisältö
suklaaSisalto=$(grep "fazer blue" /var/verkkosivut/suklaa/chocolate.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/verkkosivut/suklaa/chocolate.html sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}/var/verkkosivut/suklaa/chocolate.html sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}chocolate.html sivun saa auki kirjiittamalla selaimeen <palvelimen-IP-osoite/suklaa/chocolate.html> ${NORMAL}"
echo -e "${YELLOW}chocolate.html pitää kirjoittaa manuaalisesti osoiterivin loppuun sillä oletuksena vain index.html nimiset sivut avataan automaattisesti ${NORMAL}"

;; 

"008 Palomuuri UFW") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 008 ================ ${NORMAL}"
echo ""

#Onko UFW päällä
ufwStatus=$(ufw status verbose | grep "Status")
if [[ $ufwStatus == "Status: active" ]]
then
	echo -e "${GREEN}UFW on päällä ${NORMAL}" 
else
	echo -e "${RED}UFW ei ole päälläl ${NORMAL}"
fi

#SSH portti 1337
ufwSSHport=$(grep -oP '^Port \K.*' /etc/ssh/sshd_config)
ufwAllowSSH=$(ufw show added | grep "allow $ufwSSHport")
if [[ -n $ufwAllowSSH ]]
then
	echo -e "${GREEN}UFW palomuurista on sallittu SSH portti 1337 ${NORMAL}" 
else
	echo -e "${RED}UFW palomuurista ei ole sallittu porttia 1337 ${NORMAL}"
fi

#Estetty kaikki epäoleellinen
ufwDefaultIncoming=$(ufw status verbose | grep -o 'Default: deny (incoming)')
if [[ $ufwDefaultIncoming == "Default: deny (incoming)" ]]
then
	echo -e "${GREEN}UFW palomuurista on estetty kaikki portit paitsi käytössä olevat ${NORMAL}" 
else
	echo -e "${RED}UFW palomuurista ei ole estetty kaikkia ei-käytössä olevia portteja ${NORMAL}"
fi

#UFW HTTP portti
ufw80=$(ufw status verbose | tr -s ' ' | grep '80 ALLOW IN')
if [[ $ufw80 =~ "80 ALLOW IN" ]]
then
	echo -e "${GREEN}UFW palomuurista on portti 80 avattu ${NORMAL}" 
else
	echo -e "${RED}UFW palomuurista on estetty portti 80 ${NORMAL}"
fi

#UFW DHCP portti 67
ufw67=$(ufw status verbose | tr -s ' ' | grep '67 ALLOW IN')
if [[ $ufw67 =~ "67 ALLOW IN" ]]
then
	echo -e "${GREEN}UFW palomuurista on portti 67 avattu ${NORMAL}" 
else
	echo -e "${RED}UFW palomuurista on estetty portti 67  ${NORMAL}"
fi

echo -e "${YELLOW}Olethan testannut UFW-palomuurin toiminnan työasemalta käsin? ${NORMAL}"

;; 

"009 DNS BIND9") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 009 ================ ${NORMAL}"
echo ""

#Domain nimi
bindConfZone=$(grep 'zone "taitajalinux.fi" {' /etc/bind/named.conf.local)
if [[ $bindConfZone =~ "taitajalinux.fi" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikea domain nimi ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärä domain nimi ${NORMAL}"
fi

#Tietokannan nimi
bindConfFile=$(grep db.taitajalinux.fi /etc/bind/named.conf.local)
if [[ $bindConfFile =~ "db.taitajalinux.fi" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikean niminen tietokanta ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärän niminen tietokanta ${NORMAL}"
fi

#Tietokannan NS tietue
bindNS=$(grep "NS\staitajalinux.fi." /etc/bind/db.taitajalinux.fi)
if [[ $bindNS =~ "taitajalinux.fi." ]]
then
	echo -e "${GREEN}/etc/bind/db.taitajalinux.fi tiedostossa on oikea domain nimi ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.taitajalinux.fi tiedostossa on väärän niminen domain nimi ${NORMAL}"
fi

#Tietokannan A tietue
bindA=$(grep "A\s192.168.1.30" /etc/bind/db.taitajalinux.fi)
if [[ $bindA =~ "192.168.1.30" ]]
then
	echo -e "${GREEN}/etc/bind/db.taitajalinux.fi tiedostossa on oikein tehty A-tietue ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.taitajalinux.fi tiedostossa on väärin tehty A-tietue ${NORMAL}"
fi

#DHCP muutos DNS-osoitteen vaihdon vuoksi
bindScopeDNS=$(grep "option domain-name-servers 192.168.1.30" /etc/dhcp/dhcpd.conf)
if [[ $bindScopeDNS =~ "option domain-name-servers 192.168.1.30;" ]]
then
	echo -e "${GREEN}DHCP palvelulle on muutettu oikea DNS-osoite ${NORMAL}" 
else
	echo -e "${RED}DHCP palvelulle ei ole muutettu oikeaa DNS-osoitetta ${NORMAL}"
fi

ufw53=$(ufw status verbose | grep '53')
if [[ $ufw53 =~ "53" ]]
then
	echo -e "${GREEN}UFW palomuurista on portti 53 avattu ${NORMAL}" 
else
	echo -e "${RED}UFW palomuurista on estetty portti 53 ${NORMAL}"
fi

echo -e "${YELLOW}Olethan testannut DNS-palvelun toiminnan työasemalta selaimen sekä nslookup ja dig työkalujen avulla? ${NORMAL}"

;; 

"010 Skriptaus ja Cron") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 010 ================ ${NORMAL}"
echo ""

echo -e "${YELLOW}Tiedät, että skripti ja ajastus toimivat jos kansioon /backup/ tulee uusia kansioita nimeltään varmuuskopio, joiden perässä on vuosi, kuukausi, päivä ja kellonaika. Esimerkiksi /backup/varmuuskopio/12102025_150242"
echo -e "${YELLOW}Onhan skriptillä suoritusoikeudet? ${NORMAL}"

#Onko varmuuskopio skripti olemassa
if test -f "/skriptit/varmuuskopio.sh"; then
	echo -e "${GREEN}Tiedosto /skriptit/varmuuskopio.sh on olemassa ${NORMAL}"
else
	echo -e "${RED}Tiedostoa /skriptit/varmuuskopio.sh ei ole olemassa ${NORMAL}"
fi

#Varmuuskopio skriptin sisältö
varmuuskopioTXT=$(grep "(date +%Y%m%d_%H%M%S)" /skriptit/varmuuskopio.sh)
if [[ $? != 0 ]];
then
	echo -e "${RED}Skriptin komento näyttäisi olevan väärin. Siinä ei näyttäisi olevan kohtaa (date +%Y%m%d_%H%M%S) ${NORMAL}"
else
	echo -e "${GREEN}Skriptin komento näyttäisi olevan oikein sillä cp -r komennosta löytyy kohta (date +%Y%m%d_%H%M%S)  ${NORMAL}"
fi

echo -e "${YELLOW}Skriptin tulisi olla ajastettuna /etc/crontab tiedostossa muodossa */15 * * * * /skriptit/ ${NORMAL}"

#Skriptin ajastus
cronJob=$( grep '^[^#]*\*/15' /etc/crontab)
if [[ -n $cronJob ]]
then
	echo -e "${GREEN}Skriptin ajastus tehty oikein /etc/crontab tiedostossa ${NORMAL}" 
else
	echo -e "${RED}Skriptin ajastus tehty väärin /etc/crontab tiedostossa ${NORMAL}"
fi

;; 

"Poistu") 
echo "Poistutaan tarkistusskriptistä" 

break 
;;

*) 

echo "Huono valinta $REPLY" 
;; 
esac 

done
