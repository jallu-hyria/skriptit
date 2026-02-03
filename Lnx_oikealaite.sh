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
options=("001 Linux oikeilla laitteilla" "Poistu") 

# Luodaan menu ja määritellään miten käsitellään vaihtoehdot 
select opt in "${options[@]}" 
do 
case $opt in 

"001 Linux oikeilla laitteilla") 
echo ""
echo -e ${BLUE}"================ Tarkistetaan tehtävä 001 ================ ${NORMAL}"
echo ""

# IP-osoite ja aliverkonmaski
IPjaSMosoite=$(ip a | grep "192.168.200.10/24")
if [[ $? != 0 ]];
then
	echo -e "${RED}IP-osoite ja/tai aliverkonmaski ovat väärin. Niiden pitäisi olla 192.168.1.30 ja /24 eli 255.255.255.0 ${NORMAL}"
else
	echo -e "${GREEN}IP-osoite ja aliverkonmaski ovat oikein ${NORMAL}"
fi

# Oletusyhdyskäytävä
GWosoite=$(ip r | grep "192.168.200.1")
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
tietokoneenNimi=$(hostname | grep "lnx-palvelin-1")
if [[ $? != 0 ]];
then
	echo -e "${RED}Tietokoneen nimi on väärin. Sen pitäisi olla LNXSRVDEB ${NORMAL}"
else
	echo -e "${GREEN}Tietokoneen nimi on oikein ${NORMAL}"
fi

#Rootin salis
echo -e "${YELLOW}Onhan Rootin salasana Sala1234 ${NORMAL}"

#opettajan tili löytyy
asentajaNimi=$(grep "opettaja" /etc/passwd)
if [[ $? != 0 ]];
then
	echo -e "${RED}Käyttäjän nimi on väärin. Sen pitäisi olla opettajan ${NORMAL}"
else
	echo -e "${GREEN}Käyttäjän nimi on oikein ${NORMAL}"
fi

#opettajan salis
echo -e "${YELLOW}Onhan käyttäjän opettaja salasana Sala1234 ${NORMAL}"

#onko ryhmä olemassa?
hyrialaisetON=$(grep "hyrialaiset" /etc/group)
if [[ $? != 0 ]];
then
	echo -e "${RED}Ryhmää hyrialaiset ei ole olemassa ${NORMAL}"
else
	echo -e "${GREEN}Ryhmä hyrialaiset on olemassa ${NORMAL}"
fi

#onko käyttäjä oikeassa ryhmässä
opettajaRyhma=$(grep "hyrialaiset" /etc/group | grep "opettaja")
if [[ $? != 0 ]];
then
	echo -e "${RED}opettaja ei ole ryhmässä hyrialaiset${NORMAL}"
else
	echo -e "${GREEN}opettaja on ryhmässä hyrialaiset ${NORMAL}"
fi

#hyrialaiset sudo oikeudet
hyrialaisetSudo=$(grep "%hyrialaiset ALL=(ALL:ALL) ALL" /etc/sudoers)
if [[ $? != 0 ]];
then
	echo -e "${RED}Ryhmällä hyrialaiset ei ole sudo oikeuksia ${NORMAL}"
else
	echo -e "${GREEN}Ryhmällä hyrialaiset on sudo oikeudet ${NORMAL}"
fi

#DHCP osoitealue
scopeSubnet=$(grep "192.168.200.0/24" /etc/kea/kea-dhcp4.conf)
if [[ $scopeSubnet =~ "192.168.200.0/24" ]]
then
	echo -e "${GREEN}DHCP palvelun osoitealue on oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun osoitealue on väärin ${NORMAL}"
fi

#DHCP jaettavat osoitteet
scopeRange=$(grep "192.168.200.100 - 192.168.200.250" /etc/kea/kea-dhcp4.conf)
if [[ $scopeRange =~ "192.168.200.100 - 192.168.200.250" ]]
then
	echo -e "${GREEN}DHCP palvelun jaettavat osoitteet ovat oikein ${NORMAL}"
else	
	echo -e "${RED}DHCP palvelun jaettavat osoitteet ovat väärin ${NORMAL}"
fi

#DHCP GW osoite
scopeGW=$(grep "192.168.200.1" /etc/kea/kea-dhcp4.conf)
if [[ $scopeGW =~ "192.168.200.1" ]]
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

#SSH portti
sshPort=$(grep '^[^#]*Port' /etc/ssh/sshd_config)
if [[ $sshPort == "Port 55555" ]]
then
	echo -e "${GREEN}SSH portti on oikein  ${NORMAL}"
else	
	echo -e "${RED}SSH portti on väärin ${NORMAL}"
fi

documentRoot=$(grep -oP 'DocumentRoot \K.*' /etc/apache2/sites-enabled/000-default.conf)
if [[ $documentRoot == "/var/paras/" ]]
then
	echo -e "${GREEN}Verkkosivun documentRoot eli polku on oikein ${NORMAL}"
else	
	echo -e "${RED}Verkkosivun documentRoot eli polku on väärin  ${NORMAL}"
fi

#/var/paras/index.html sisältö
indexSisalto=$(grep "Linux on paras" /var/paras/index.html)
if [[ $? != 0 ]];
then
	echo -e "${RED}/var/paras/index.html sisältö on väärin. Onhan sisältö oikein ja kirjoitettu pienillä kirjaimilla? ${NORMAL}"
else
	echo -e "${GREEN}/var/paras/index.html sisältö on oikein ${NORMAL}"
fi

#Onko UFW päällä
ufwStatus=$(ufw status verbose | grep "Status")
if [[ $ufwStatus == "Status: active" ]]
then
	echo -e "${GREEN}UFW on päällä ${NORMAL}" 
else
	echo -e "${RED}UFW ei ole päälläl ${NORMAL}"
fi

#SSH portti 55555
ufwSSHport=$(grep -oP '^Port \K.*' /etc/ssh/sshd_config)
ufwAllowSSH=$(ufw show added | grep "allow $ufwSSHport")
if [[ -n $ufwAllowSSH ]]
then
	echo -e "${GREEN}UFW palomuurista on sallittu SSH portti 55555 ${NORMAL}" 
else
	echo -e "${RED}UFW palomuurista ei ole sallittu porttia 55555 ${NORMAL}"
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

echo -e "${YELLOW}Olethan testannut kaikkien palveluiden toiminnan työasemalta käsin? ${NORMAL}"

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
