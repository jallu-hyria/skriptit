#!/bin/bash
# Versio 1.00. 3.6.2025. Jalmari Valimaan tikkukirjaimilla koodattu
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
options=("001 Linux asentaminen" "002 Linux komentoja" "003 Linux käyttäjät ja oikeudet" "004 Linux Kiintolevyt ja mounttaus" "005 Työaseman asentaminen" "006 DHCP palvelin" "007 SSH" "008 WWW Apache ja PHP" "009 DNS BIND9" "010 Fail2Ban" "011 Verkkojako Samba" "012 Palomuuri Iptables" "013 Skriptaus ja Cron" "014 placeholder" "015 Apache virtualhostit" "Poistu") 

# Luodaan menu ja määritellään miten käsitellään vaihtoehdot 
select opt in "${options[@]}" 
do 
case $opt in 

"001 Linux asentaminen") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 001 ================ ${NORMAL}"
echo ""

# IP-osoite ja aliverkonmaski
IPjaSMosoite=$(ip a | grep "192.168.0.30/24")
if [[ $? != 0 ]];
then
	echo -e "${RED}IP-osoite ja/tai aliverkonmaski ovat väärin. Niiden pitäisi olla 192.168.0.30 ja /24 eli 255.255.255.0 ${NORMAL}"
else
	echo -e "${GREEN}IP-osoite ja aliverkonmaski ovat oikein ${NORMAL}"
fi

# Oletusyhdyskäytävä
GWosoite=$(ip r | grep "192.168.0.1")
if [[ $? != 0 ]];
then
	echo -e "${RED}Oletusyhdyskäytävä on väärin. Sen pitäisi olla 192.168.0.1 ${NORMAL}"
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
tietokoneenNimi=$(hostname | grep "LNXSRV")
if [[ $? != 0 ]];
then
	echo -e "${RED}Tietokoneen nimi on väärin. Sen pitäisi olla LNXSRV ${NORMAL}"
else
	echo -e "${GREEN}Tietokoneen nimi on oikein ${NORMAL}"
fi

#Rootin salis
echo -e "${YELLOW}Onhan Rootin salasana Sala1234 ${NORMAL}"

#hyriataitajan tili löytyy
hyriataitajaNimi=$(grep "hyriataitaja" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjän nimi on väärin. Sen pitäisi olla hyriataitaja ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjän nimi on oikein ${NORMAL}"
fi

#hyriataitajan salis
echo -e "${YELLOW}Onhan käyttäjän hyriataitaja salasana Sala1234 ${NORMAL}"

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

#hyriataitajan sudo oikeudet
hyriataitajaSudo=$(grep "hyriataitaja ALL=(ALL:ALL) ALL" /etc/sudoers)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjällä hyriataitaja ei ole sudo oikeuksia ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjällä hyriataitaja on sudo oikeudet ${NORMAL}"
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
"002 Linux komentoja") 
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

#onko /home/hyriataitaja/kotitesti poistettu
if test -d "/home/hyriataitaja/kotitesti"; then
	echo -e "${RED}Kansio /home/hyriataitaja/kotitestit on olemassa ${NORMAL}"
else
	echo -e "${GREEN}Kansiota /home/hyriataitaja/kotitesti ei ole olemassa ${NORMAL}"
fi

#onko /kissat/ruoka/omistaja.txt olemassa
if test -f "/kissat/ruoka/omistaja.txt"; then
	echo -e "${GREEN}Tiedosto /kissat/ruoka/omistaja.txt on olemassa ${NORMAL}"
else
	echo -e "${RED}Tiedostoa /kissat/ruoka/omistaja.txt ei ole olemassa ${NORMAL}"
fi

#kissa omistaja.txt
omistajaTXT=$(grep "hyriataitaja" /kissat/ruoka/omistaja.txt)
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

#koira .poliisikoira.txt
poliisikoiraTXT=$(grep "rex" /koirat/.saksanpaimenkoira/.poliisikoira.txt)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}ls -a komennolla näkee piilotetut kansiot ja tiedostot ${NORMAL}"
echo -e "${YELLOW}Olethan harjoitellut 002.1 ohjeen Hyödyllisiä asioita, joissa opit mm. putkittamaan, lopettamaan komentoja sekä ohjaamaan tekstiä? ${NORMAL}"

#NTP
NTPconf=$(grep "server 0.fi.pool.ntp.org" /etc/ntpsec/ntp.conf)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston sisältö on väärin. Sieltä ei löydy poolia 0.fi.pool.ntp.org ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston sisältö on oikein eli siellä on oikea NTP pool ${NORMAL}"
fi

echo -e "${YELLOW}Olethan poistanut tai kommentoinut pois /etc/ntpsec/ntp.conf löytyvät muut poolit? ${NORMAL}"

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

#/donotdelete sticky bit
donotdelete=$(ls -al / | grep donotdelete | grep "drwxr-xr-t")
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /donotdelete oikeudet ja stickybit ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /donotdelete oikeudet ja stickybit ovat oikein ${NORMAL}"
fi

#sallan sudo oikeudet
sallaSudo=$(grep "salla ALL=(ALL:ALL) ALL" /etc/sudoers)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjällä salla ei ole sudo oikeuksia ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjällä salla on sudo oikeudet ${NORMAL}"
fi

#mikon sudo oikeudet
mikkoSudo=$(grep "mikko ALL=(ALL) NOPASSWD:ALL" /etc/sudoers)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjällä mikko ei ole sudo oikeuksia ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjällä mikko on sudo oikeudet ${NORMAL}"
fi

;; 
"004 Linux Kiintolevyt ja mounttaus")
echo "" 
echo -e ${BLUE}"================ Tarkistetaan tehtävä 004 ================ ${NORMAL}"
echo ""

#testi5.txt
testi5TXT=$(grep "5 gigan levy" /virtuaalilevy5/testi5.txt)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston testi5.txt sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston testi5.txt sisältö on oikein ${NORMAL}"
fi

#5 gigan levy
levy5gb=$(grep "/virtuaalilevy5" /etc/fstab)
if [[ $? != 0 ]];
then
	echo -e "${RED}/etc/fstab ei löydy pysyvää mounttausta laitteelle /dev/sdb1 kansioon /virtuaalilevy5 ${NORMAL}"
else
	echo -e "${GREEN}/etc/fstab näyttäisi olevan oikein tehty levylle /dev/sdb1 kansioon /virtuaalilevy5 ${NORMAL}"
fi

echo -e "${YELLOW}Varmista kuitenkin ihan itse, että pysyvä mounttaus toimii ja palvelin käynnistyy normaalisti ${NORMAL}"

#testi20.txt
testi20TXT=$(grep "20 gigan levy" /isompilevy/testi20.txt)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston testi20.txt sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston testi20.txt sisältö on oikein ${NORMAL}"
fi

#20 gigan levy
kovoUUID=$(blkid -s UUID -o value /dev/sdc1)

echo -e "${YELLOW}Laitteen /dev/sdc1 UUID on: $kovoUUID ${NORMAL}"

levy20gb=$(grep "$kovoUUID" /etc/fstab)
if [[ $? != 0 ]];
then
	echo -e "${RED}/etc/fstab ei löydy pysyvää mounttausta laitteelle /dev/sdc1 kansioon /isompilevy ${NORMAL}"
else
	echo -e "${GREEN}/etc/fstab näyttäisi olevan oikein tehty levylle /dev/sdc1 (jonka UUID on $kovoUUID) kansioon /isompilevy ${NORMAL}"
fi

echo -e "${YELLOW}Varmista kuitenkin ihan itse, että pysyvä mounttaus toimii ja palvelin käynnistyy normaalisti ${NORMAL}"

;;

"005 Työaseman asentaminen")
echo "" 
echo -e ${BLUE}"================ Tarkistetaan tehtävä 005 ================ ${NORMAL}"
echo ""

echo -e ${YELLOW}"Tässä tehtävässä ei ole kohtia, joita skripti voisi tarkistaa palvelimelta ${NORMAL}"
;; 
 
"006 DHCP palvelin") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 006 ================ ${NORMAL}"
echo ""

#DHCP portti
echo -e "${YELLOW}Katso /etc/default/isc-dhcp-server tiedostosta portti, josta DHCP jakaa IP-asetuksia. ${NORMAL}"
echo -e "${YELLOW}Vastaahan se porttia, jolle on annettu IP-asetukset? Näet sen komennolla: ip a ${NORMAL}"

#DHCP osoitealue
scopeSubnet=$(grep "subnet 192.168.0.0 netmask 255.255.255.0" /etc/dhcp/dhcpd.conf)
if [[ $scopeSubnet =~ "subnet 192.168.0.0 netmask 255.255.255.0 {" ]]
then
	echo -e "${GREEN}DHCP palvelun osoitealue on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun osoitealue on väärin ${NORMAL}"
fi

#DHCP jaettavat osoitteet
scopeRange=$(grep "range 192.168.0.200 192.168.0.230" /etc/dhcp/dhcpd.conf)
if [[ $scopeRange =~ "range 192.168.0.200 192.168.0.230;" ]]
then
	echo -e "${GREEN}DHCP palvelun jaettavat osoitteet ovat oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jaettavat osoitteet ovat väärin ${NORMAL}"
fi

#DHCP GW osoite
scopeGW=$(grep "option routers 192.168.0.1" /etc/dhcp/dhcpd.conf)
if [[ $scopeGW =~ "option routers 192.168.0.1;" ]]
then
	echo -e "${GREEN}DHCP palvelun jakama oletusyhdyskäytävän osoite on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jakama oletusyhdyskäytävän osoite on väärin ${NORMAL}"
fi

#DHCP DNS osoite
scopeDNS=$(grep "option domain-name-servers 8.8.8.8" /etc/dhcp/dhcpd.conf)
if [[ $scopeDNS =~ "option domain-name-servers 8.8.8.8;" ]]
then
	echo -e "${GREEN}DHCP palvelun jakama DNS osoite on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jakama DNS osoite on väärin ${NORMAL}"
fi

#DHCP autorisointi
authStatus=$(grep -E '^[^#]*authoritative;' /etc/dhcp/dhcpd.conf)
if [[ $authStatus == "authoritative;" ]]
then
	echo -e "${GREEN}DHCP palvelu on autorisoitu ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelu ei ole autorisoitu ${NORMAL}"
fi

#DHCP varaus
reservationHost=$(grep "host LNXTAITAJA {" /etc/dhcp/dhcpd.conf)
if [[ $reservationHost =~ "host LNXTAITAJA {" ]]
then
	echo -e "${GREEN}DHCP varauksen laitenimi on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP varauksen laitenimi ei ole oikein ${NORMAL}"
fi

reservationMAC=$(grep "hardware ethernet 00:01:02:03:AB:DF;" /etc/dhcp/dhcpd.conf)
if [[ $reservationMAC =~ "hardware ethernet 00:01:02:03:AB:DF" ]]
then
	echo -e "${GREEN}DHCP varauksen MAC-osoite on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP varauksen MAC-osoite ei ole oikein ${NORMAL}"
fi

reservationIP=$(grep "fixed-address 192.168.0.225" /etc/dhcp/dhcpd.conf)
if [[ $reservationIP =~ "fixed-address 192.168.0.225" ]]
then
	echo -e "${GREEN}DHCP varauksen IP-osoite on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP varauksen IP-osoite ei ole oikein ${NORMAL}"
fi

#DHCP status
dhcpStatus=$(systemctl status isc-dhcp-server | grep "Active:")
if [[ $dhcpStatus =~ "Active: active" ]]
then
	echo -e "${GREEN}DHCP palvelu on käytössä ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelu ei ole käytössä ${NORMAL}"
fi

echo -e "${YELLOW}Testasithan yhteyden Linux työasemaan pingaamalla niitä? ${NORMAL}"
echo -e "${YELLOW}Saihan LNXWSK001 työasema IP-asetukset DHCP-palvelulta eli se ei enää käytä kiinteitä IP-asetuksia? ${NORMAL}"

#Palvelimelta varmistus onko IP-asetuksia jaettu
lnxwksDHCP=$(grep "LNXWKS001" /var/lib/dhcp/dhcpd.leases)
if [[ $? != 0 ]];
then
	echo -e "${RED}Työasemalle LNXWKS001 ei ole jaettu IP-osoite ${NORMAL}"
else
	echo -e "${GREEN}Työasemalle LNXWKS001 on jaettu IP-osoite ${NORMAL}"
fi

;;
"007 SSH") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 007 ================ ${NORMAL}"
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
if [[ $sshLoginGraceTime == "LoginGraceTime 30" ]]
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
etcBANNER=$(grep "Hyrian Taitajat" /etc/banner)
if [[ $? != 0 ]];
then
	echo -e "${RED}/etc/banner tiedoston sisältö on väärin. ${NORMAL}"
else
	echo -e "${GREEN}/etc/banner tiedoston sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}Olethan käynnistänyt ssh palvelun uudestaan systemctl komennolla? ${NORMAL}"
echo -e "${YELLOW}Olethan testannut SSH-yhteyden toiminnan työasemilta palvelimelle? ${NORMAL}"

#SSH Kayttaja
sshKayttaja=$(grep '^[^#]*AllowUsers' /etc/ssh/sshd_config)
if [[ $sshKayttaja == "AllowUsers ville" ]]
then
	echo -e "${GREEN}Vain ville saa kirjautua SSH kautta ${NORMAL}"
else	
	echo -e "${RED}Kirjautumista ei ole rajoitettu vain villeen ${NORMAL}"
fi

;; 

"008 WWW Apache ja PHP") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 008 ================ ${NORMAL}"
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
indexSisalto=$(grep "hyriataitaja testaa" /var/verkkosivut/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/verkkosivut/index.html sisältö on väärin. ${NORMAL}"
else
	echo -e "${GREEN}/var/verkkosivut/index.html sisältö on oikein ${NORMAL}"
fi

#/var/verkkosivut/suklaa/index.html sisältö
suklaaSisalto=$(grep "fazerin sininen" /var/verkkosivut/suklaa/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/verkkosivut/suklaa/index.html sisältö on väärin. ${NORMAL}"
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

echo -e "${YELLOW}chocolate.html sivun saa auki kirjoittamalla selaimeen <palvelimen-IP-osoite/suklaa/chocolate.html> ${NORMAL}"
echo -e "${YELLOW}chocolate.html pitää kirjoittaa manuaalisesti osoiterivin loppuun sillä oletuksena vain index.html nimiset sivut avataan automaattisesti ${NORMAL}"

#/var/verkkosivut/phptesti/index.php sisältö
phptestiSisalto=$(grep "<?php phpinfo(); ?>" /var/verkkosivut/phptesti/index.php)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/verkkosivut/phptesti/index.php sisältö on väärin ${NORMAL}"
else
	echo -e "${GREEN}/var/verkkosivut/phptesti/index.php sisältö on oikein ${NORMAL}"
fi

#/home/ville/omatsivut/index.html sisältö
villeSisalto=$(grep "linux on paras!" /home/ville/omatsivut/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/home/ville/omatsivut/index.html sisältö on väärin ${NORMAL}"
else
	echo -e "${GREEN}/home/ville/omatsivut/index.html sisältö on oikein ${NORMAL}"
fi

#villensivut Tiedoston oikeudet
villensivut=$(ls -al /home/ville/omatsivut | grep index.html | grep rwxr-xr-x)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston /home/ville/omatsivut/index.html oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston /home/ville/omatsivut/index.html oikeudet ovat oikein ${NORMAL}"
fi

#/etc/skel/omatsivut/index.html sisältö
skelSisalto=$(grep "Build your own site here!" /etc/skel/omatsivut/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/etc/skel/omatsivut/index.html sisältö on väärin ${NORMAL}"
else
	echo -e "${GREEN}/etc/skel/omatsivut/index.html sisältö on oikein ${NORMAL}"
fi

#/home/petja/omatsivut/index.html sisältö
petjaskelSisalto=$(grep "Build your own site here!" /home/petja/omatsivut/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/home/petja/omatsivut/index.html sisältö on väärin ${NORMAL}"
else
	echo -e "${GREEN}/home/petja/omatsivut/index.html sisältö on oikein ${NORMAL}"
fi

#petjansivut Tiedoston oikeudet
petjansivut=$(ls -al /home/petja/omatsivut | grep index.html | grep rwxr-xr-x)
if [[ $? != 0 ]];
then
	echo -e "${RED}Tiedoston /home/petja/omatsivut/index.html oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Tiedoston /home/petja/omatsivut/index.html oikeudet ovat oikein ${NORMAL}"
fi

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
bindA=$(grep "A\s192.168.0.30" /etc/bind/db.taitajalinux.fi)
if [[ $bindA =~ "192.168.0.30" ]]
then
	echo -e "${GREEN}/etc/bind/db.taitajalinux.fi tiedostossa on oikein tehty A-tietue ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.taitajalinux.fi tiedostossa on väärin tehty A-tietue ${NORMAL}"
fi

#DHCP muutos DNS-osoitteen vaihdon vuoksi
bindScopeDNS=$(grep "option domain-name-servers 192.168.0.30" /etc/dhcp/dhcpd.conf)
if [[ $bindScopeDNS =~ "option domain-name-servers 192.168.0.30;" ]]
then
	echo -e "${GREEN}DHCP palvelulle on muutettu oikea DNS-osoite ${NORMAL}" 
else
	echo -e "${RED}DHCP palvelulle ei ole muutettu oikeaa DNS-osoitetta ${NORMAL}"
fi

echo -e "${YELLOW}Olethan testannut DNS-palvelun toiminnan työasemalta selaimen sekä nslookup ja dig työkalujen avulla? ${NORMAL}"

#forwarders
forwarders=$(grep 8.8.8.8 /etc/bind/named.conf.options)
if [[ $forwarders =~ "8.8.8.8;" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.options tiedostossa on oikea forwarders osoite ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.options tiedostossa on väärä forwarders osoite ${NORMAL}"
fi

#Reverse lookup
bindConfZoneReverse=$(grep 'zone "0.168.192.in-addr.arpa" {' /etc/bind/named.conf.local)
if [[ $bindConfZoneReverse =~ "0.168.192.in-addr.arpa" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikea domain nimi reverselle ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärä domain nimi reverselle ${NORMAL}"
fi

#Tietokannan nimi reverselle
bindConfZoneReverseDB=$(grep db.0.168.192 /etc/bind/named.conf.local)
if [[ $bindConfZoneReverseDB =~ "db.0.168.192" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikean niminen tietokanta reverselle ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärän niminen tietokanta reverselle ${NORMAL}"
fi

#Tietokannan NS tietue reverse
bindNSreverse=$(grep "NS\staitajalinux.fi." /etc/bind/db.0.168.192)
if [[ $bindNSreverse =~ "taitajalinux.fi." ]]
then
	echo -e "${GREEN}/etc/bind/db.0.168.192 tiedostossa on oikea domain nimi reverselle ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.0.168.192 tiedostossa on väärän niminen domain nimi reverselle ${NORMAL}"
fi

#Tietokannan PTR tietue reverse
bindNSreversePTR=$(grep "30\sIN" /etc/bind/db.0.168.192)
if [[ $bindNSreversePTR =~ "taitajalinux.fi." ]]
then
	echo -e "${GREEN}/etc/bind/db.0.168.192 tiedostossa on oikea PTR tietue ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.0.168.192 tiedostossa on väärän niminen PTR tietue ${NORMAL}"
fi

echo -e "${YELLOW}Olethan testannut DNS-palvelun toiminnan työasemalta selaimen sekä nslookup ja dig työkalujen avulla myös Reverse lookup zone osalta? ${NORMAL}"

;;

"010 Fail2Ban") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 010 ================ ${NORMAL}"
echo ""

#fail2ban tarkistus
f2bport=$(grep "1337" /etc/fail2ban/jail.conf)
if [[ $f2bport =~ "1337" ]]
then
	echo -e "${GREEN}/etc/fail2ban/jail.conf fail2ban käyttää oikeaa porttia SSHD varten ${NORMAL}" 
else
	echo -e "${RED}/etc/fail2ban/jail.conf tiedostossa on väärä porttia SSHD varten ${NORMAL}"
fi

#fail2ban tarkistus
f2bmaxretry=$(grep "maxretry = 5" /etc/fail2ban/jail.conf)
if [[ $f2bmaxretry =~ "maxretry = 5" ]]
then
	echo -e "${GREEN}/etc/fail2ban/jail.conf fail2ban maxretry on 5 ${NORMAL}" 
else
	echo -e "${RED}/etc/fail2ban/jail.conf tiedostossa maxretry ei ole 5 ${NORMAL}"
fi

#fail2ban tarkistus
f2bbantime=$(grep "bantime = 180" /etc/fail2ban/jail.conf)
if [[ $f2bbantime =~ "bantime = 180" ]]
then
	echo -e "${GREEN}/etc/fail2ban/jail.conf fail2ban bantime on 180 ${NORMAL}" 
else
	echo -e "${RED}/etc/fail2ban/jail.conf tiedostossa bantime ei ole 180 ${NORMAL}"
fi

#fail2ban tarkistus
f2bbackend=$(grep "backend = systemd" /etc/fail2ban/jail.conf)
if [[ $f2bbackend =~ "backend = systemd" ]]
then
	echo -e "${GREEN}/etc/fail2ban/jail.conf fail2ban backend on systemd ${NORMAL}" 
else
	echo -e "${RED}/etc/fail2ban/jail.conf tiedostossa backend ei ole systemd ${NORMAL}"
fi

#fail2ban tarkistus
f2benabled=$(grep "enabled = true" /etc/fail2ban/jail.conf)
if [[ $f2benabled =~ "enabled = true" ]]
then
	echo -e "${GREEN}/etc/fail2ban/jail.conf fail2ban on enabloitu SSHD palvelulle ${NORMAL}" 
else
	echo -e "${RED}/etc/fail2ban/jail.conf tiedostossa backend ei ole enabloitu SSHD palvelulle ${NORMAL}"
fi

echo -e "${YELLOW}Olethan testannut fail2ban toimivuuden eli se estää SSHD yhteyden 5 epäonnistuneen kirjautumisen jälkeen? ${NORMAL}"
echo -e "${YELLOW}Tulihan bänneistä merkinnät fail2ban-client status ja iptables -S komentojen syötteeseen? ${NORMAL}"

;; 

"011 Verkkojako Samba") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 011 ================ ${NORMAL}"
echo ""

#sambatestaajan tili löytyy
sambatestaajaNimi=$(grep "sambatestaaja" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjän nimi on väärin. Sen pitäisi olla sambatestaaja ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjän nimi on oikein ${NORMAL}"
fi

#sambatestaajan Samba tili löytyy
sambatestaajaSambatili=$(pdbedit -L -v | grep "sambatestaaja")
if [[ $? != 0 ]];
then
	echo -e "${RED}Samba käyttäjää nimeltään sambatestaaja ei löydetty ${NORMAL}"
else
	echo -e "${GREEN}Samba käyttäjä nimeltään sambatestaaja löydettiin ${NORMAL}"
fi

#/jakokansio kansion oikeudet
jakokansio=$(ls -al / | grep jakokansio | grep drwxrwxrwx)
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /jakokansio oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /jakokansio oikeudet ovat oikein ${NORMAL}"
fi

#samba tarkistus
smbenabled=$(grep "\[jako\]" /etc/samba/smb.conf)
if [[ $smbenabled == "[jako]" ]]
then
	echo -e "${GREEN}/etc/samba/smb.conf on verkkojako nimeltään jako ${NORMAL}" 
else
	echo -e "${RED}/etc/samba/smb.conf ei ole verkkojako nimeltään jako ${NORMAL}"
fi

#samba tarkistus
smbpolku=$(grep "/jakokansio" /etc/samba/smb.conf)
if [[ $smbpolku =~ "/jakokansio" ]]
then
	echo -e "${GREEN}/etc/samba/smb.conf verkkojaon [jako] polku on oikein ${NORMAL}" 
else
	echo -e "${RED}/etc/samba/smb.conf verkkojaon [jako] polku on väärin ${NORMAL}"
fi

#aleksin tili löytyy
aleksiNimi=$(grep "aleksi" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjän nimi on väärin. Sen pitäisi olla aleksi ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjän nimi on oikein ${NORMAL}"
fi

#aleksin Samba tili löytyy
aleksiSambatili=$(pdbedit -L -v | grep "aleksi")
if [[ $? != 0 ]];
then
	echo -e "${RED}Samba käyttäjää nimeltään aleksi ei löydetty ${NORMAL}"
else
	echo -e "${GREEN}Samba käyttäjä nimeltään aleksi löydettiin ${NORMAL}"
fi

#/hidden kansion oikeudet
hidden=$(ls -al / | grep hidden | grep drwx------)
if [[ $? != 0 ]];
then
	echo -e "${RED}Kansion /hidden oikeudet ovat väärin ${NORMAL}"
else
	echo -e "${GREEN}Kansion /hidden oikeudet ovat oikein ${NORMAL}"
fi

#samba tarkistus
smbenabledHidden=$(grep "\[piilojako\]" /etc/samba/smb.conf)
if [[ $smbenabledHidden == "[piilojako]" ]]
then
	echo -e "${GREEN}/etc/samba/smb.conf on verkkojako nimeltään piilojako ${NORMAL}" 
else
	echo -e "${RED}/etc/samba/smb.conf ei ole verkkojako nimeltään piilojako ${NORMAL}"
fi

#samba tarkistus
smbpolkuHidden=$(grep "/hidden" /etc/samba/smb.conf)
if [[ $smbpolkuHidden =~ "/hidden" ]]
then
	echo -e "${GREEN}/etc/samba/smb.conf verkkojaon [piilojako] polku on oikein ${NORMAL}" 
else
	echo -e "${RED}/etc/samba/smb.conf verkkojaon [piilojako] polku on väärin ${NORMAL}"
fi

echo -e "${YELLOW}Varmista, että piilotettua verkkojakoa ei näy eli se on oikeasti piilossa. Tämän saat selville File Explorer ja linux työaseman Files ohjelman avulla. ${NORMAL}"
echo -e "${YELLOW}Hyödynnä Taitaja materiaaleista löytyvät 011 Linux Samba ohjeen kohtaa: Piilotettu samba jako ${NORMAL}"

;; 

"012 Palomuuri Iptables")

echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 011 ================ ${NORMAL}"
echo ""

#iptables tarkistus
iptablesSSH=$(grep "A INPUT -p tcp -m tcp --dport 1337 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesSSH == "-A INPUT -p tcp -m tcp --dport 1337 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 1337 ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 1337 ${NORMAL}"
fi

#iptables tarkistus
iptablesDROP=$(grep "INPUT DROP" /etc/iptables/rules.v4)
if [[ $iptablesDROP =~ "INPUT DROP" ]]
then
	echo -e "${GREEN}Palomuurista on estetty kaikki liikenne paitsi erikseen sallitut ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole estetty kaikki liikenne paitsi erikseen sallitut ${NORMAL}"
fi

#iptables tarkistus
iptablesHTTP=$(grep "A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesHTTP == "-A INPUT -p tcp -m tcp --dport 80 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 80 ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 80 ${NORMAL}"
fi

#iptables tarkistus
iptablesHTTPS=$(grep "A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesHTTPS == "-A INPUT -p tcp -m tcp --dport 443 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 443 ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 443 ${NORMAL}"
fi

#iptables tarkistus
iptablesDNSudp=$(grep "A INPUT -p udp -m udp --dport 53 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesDNSudp == "-A INPUT -p udp -m udp --dport 53 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 53 udp ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 53 udp ${NORMAL}"
fi

#iptables tarkistus
iptablesDNStcp=$(grep "A INPUT -p tcp -m tcp --dport 53 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesDNStcp == "-A INPUT -p tcp -m tcp --dport 53 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 53 tcp ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 53 tcp ${NORMAL}"
fi

#iptables tarkistus
iptablesDHCPudp=$(grep "A INPUT -p udp -m udp --dport 67 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesDHCPudp == "-A INPUT -p udp -m udp --dport 67 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 67 ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 67 ${NORMAL}"
fi

#iptables tarkistus
iptablesSMB139=$(grep "A INPUT -p tcp -m tcp --dport 139 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesSMB139 == "-A INPUT -p tcp -m tcp --dport 139 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 139 ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 139 ${NORMAL}"
fi

#iptables tarkistus
iptablesSMB445=$(grep "A INPUT -p tcp -m tcp --dport 445 -j ACCEPT" /etc/iptables/rules.v4)
if [[ $iptablesSMB445 == "-A INPUT -p tcp -m tcp --dport 445 -j ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista on sallittu portti 445 ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei ole sallittu porttia 445 ${NORMAL}"
fi

#iptables tarkistus
iptablesPING=$(grep "A INPUT -p icmp -m icmp" /etc/iptables/rules.v4)
if [[ $iptablesPING =~ "ACCEPT" ]]
then
	echo -e "${GREEN}Palomuurista näyttäisi olevan sallittu pingaaminen ${NORMAL}" 
else
	echo -e "${RED}Palomuurista ei näyttäisi olevan sallittu pingaamista ${NORMAL}"
fi

echo -e "${YELLOW}Muista testata, että pingaaminen onnistuu! ${NORMAL}" 

#onko /etc/iptables/rules.v4 olemassa
if test -f "/etc/iptables/rules.v4"; then
	echo -e "${GREEN}Tiedosto /etc/iptables/rules.v4 on olemassa. Sinne palomuurin asetukset tallennetaan ${NORMAL}"
else
	echo -e "${RED}Tiedostoa /etc/iptables/rules.v4 ei ole olemassa. Sinne palomuurin asetukset tallennetaan ${NORMAL}"
fi

echo -e "${YELLOW}Olethan testannut palomuurin toiminnan eli sallitut portit toimivat? ${NORMAL}" 

;;

"013 Skriptaus ja Cron") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 013 ================ ${NORMAL}"
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

echo -e "${YELLOW}Toimiihan skripti eli se tekee varmuuskopioita ensin minuutin ja muutoksen jälkeen 15 minuutin välein ${NORMAL}"

#Skriptin ajastus
cronJob=$( grep '^[^#]*\*/15' /etc/crontab)
if [[ -n $cronJob ]]
then
	echo -e "${GREEN}Skriptin ajastus tehty oikein /etc/crontab tiedostossa ${NORMAL}" 
else
	echo -e "${RED}Skriptin ajastus tehty väärin /etc/crontab tiedostossa ${NORMAL}"
fi

echo -e "${YELLOW}Skriptin tulisi olla ajastettuna /etc/crontab tiedostossa muodossa */15 * * * * /skriptit/ ${NORMAL}"

;;

"014 placeholder")
echo ""
echo -e ${BLUE}"================ Täällä ei ole mitään :) ================ ${NORMAL}"
echo ""

;;

"015 Apache virtualhostit") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 015 ================ ${NORMAL}"
echo ""

#testisivu.fi
documentRootTestisivu=$(grep -oP 'DocumentRoot \K.*' /etc/apache2/sites-enabled/testisivu.fi.conf)
if [[ $documentRootTestisivu == "/testisivu" ]]
then
	echo -e "${GREEN}Verkkosivun documentRoot eli polku on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun documentRoot eli polku on väärin  ${NORMAL}"
fi

#testisivu.fi
serverNameTestisivu=$(grep "ServerName testisivu.fi" /etc/apache2/sites-enabled/testisivu.fi.conf)
if [[ $serverNameTestisivu =~ "ServerName testisivu.fi" ]]
then
	echo -e "${GREEN}Verkkosivun serverName on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun serverName on väärin  ${NORMAL}"
fi

#/testisivu/index.html sisältö
indexSisaltoTestisivu=$(grep "testisivu" /testisivu/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/testisivu/index.html sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}/testisivu/index.html sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}Onhan sivut aktivoitu a2ensite komennolla? Jos ylläolevat ovat punaisella niin sitä ei todennäköisesti ole tehty ${NORMAL}"

#Domain nimi testisivu.fi
bindConfZone=$(grep 'zone "testisivu.fi" {' /etc/bind/named.conf.local)
if [[ $bindConfZone =~ "testisivu.fi" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikea domain nimi testisivu.fi ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärä domain nimi, sieltä ei löydy testisivu.fi ${NORMAL}"
fi

#Tietokannan nimi testisivu.fi
bindConfFileTestisivu=$(grep db.testisivu.fi /etc/bind/named.conf.local)
if [[ $bindConfFileTestisivu =~ "db.testisivu.fi" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikean niminen tietokanta ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärän niminen tietokanta ${NORMAL}"
fi

#Tietokannan NS tietue testisivu.fi
bindNSTestisivu=$(grep "NS\stestisivu.fi." /etc/bind/db.testisivu.fi)
if [[ $bindNSTestisivu =~ "testisivu.fi." ]]
then
	echo -e "${GREEN}/etc/bind/db.testisivu.fi tiedostossa on oikea domain nimi ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.testisivu.fi tiedostossa on väärän niminen domain nimi ${NORMAL}"
fi

#Tietokannan A tietue testisivu.fi
bindATestisivu=$(grep "A\s192.168.0.30" /etc/bind/db.testisivu.fi)
if [[ $bindATestisivu =~ "192.168.0.30" ]]
then
	echo -e "${GREEN}/etc/bind/db.testisivu.fi tiedostossa on oikein tehty A-tietue ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.testisivu.fi tiedostossa on väärin tehty A-tietue ${NORMAL}"
fi

#demo.com
documentRootdemo=$(grep -oP 'DocumentRoot \K.*' /etc/apache2/sites-enabled/demo.com.conf)
if [[ $documentRootdemo == "/var/www/demo" ]]
then
	echo -e "${GREEN}Verkkosivun documentRoot eli polku on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun documentRoot eli polku on väärin  ${NORMAL}"
fi

#demo.com
serverNamedemo=$(grep "ServerName demo.com" /etc/apache2/sites-enabled/demo.com.conf)
if [[ $serverNamedemo =~ "ServerName demo.com" ]]
then
	echo -e "${GREEN}Verkkosivun serverName on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun serverName on väärin  ${NORMAL}"
fi

#demo.com
serverAliasdemo=$(grep "ServerAlias www.demo.com" /etc/apache2/sites-enabled/demo.com.conf)
if [[ $serverAliasdemo =~ "ServerAlias www.demo.com" ]]
then
	echo -e "${GREEN}Verkkosivun ServerAlias on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun ServerAlias on väärin  ${NORMAL}"
fi

#/demo/index.html sisältö
indexSisaltodemo=$(grep "demo" /var/www/demo/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/demo/index.html sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}/demo/index.html sisältö on oikein ${NORMAL}"
fi

echo -e "${YELLOW}Onhan sivut aktivoitu a2ensite komennolla? Jos ylläolevat ovat punaisella niin sitä ei todennäköisesti ole tehty ${NORMAL}"

#Domain nimi demo.com
bindConfZone=$(grep 'zone "demo.com" {' /etc/bind/named.conf.local)
if [[ $bindConfZone =~ "demo.com" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikea domain nimi demo.com ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärä domain nimi, sieltä ei löydy demo.com ${NORMAL}"
fi

#Tietokannan nimi demo.com
bindConfFiledemo=$(grep db.demo.com /etc/bind/named.conf.local)
if [[ $bindConfFiledemo =~ "db.demo.com" ]]
then
	echo -e "${GREEN}/etc/bind/named.conf.local tiedostossa on oikean niminen tietokanta ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/named.conf.local tiedostossa on väärän niminen tietokanta ${NORMAL}"
fi

#Tietokannan NS tietue demo.com
bindNSdemo=$(grep "NS\sdemo.com." /etc/bind/db.demo.com)
if [[ $bindNSdemo =~ "demo.com." ]]
then
	echo -e "${GREEN}/etc/bind/db.demo.com tiedostossa on oikea domain nimi ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.demo.com tiedostossa on väärän niminen domain nimi ${NORMAL}"
fi

#Tietokannan A tietue demo.com
bindAdemo=$(grep "A\s192.168.0.30" /etc/bind/db.demo.com)
if [[ $bindAdemo =~ "192.168.0.30" ]]
then
	echo -e "${GREEN}/etc/bind/db.demo.com tiedostossa on oikein tehty A-tietue ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.demo.com tiedostossa on väärin tehty A-tietue ${NORMAL}"
fi

#Tietokannan CNAME tietue demo.com
bindCNAMEdemo=$(grep "www" /etc/bind/db.demo.com)
if [[ $bindCNAMEdemo =~ "CNAME" ]]
then
	echo -e "${GREEN}/etc/bind/db.demo.com tiedostossa on oikein tehty CNAME-tietue ${NORMAL}" 
else
	echo -e "${RED}/etc/bind/db.demo.com tiedostossa on väärin tehty CNAME-tietue ${NORMAL}"
fi

echo -e "${YELLOW}Toimivathan molemmat sivut työasemalta käsin selaimen kautta? ${NORMAL}"

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
