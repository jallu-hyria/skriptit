# Versio 1.00. 12.2.2025. Jalmari Valimaan tikkukirjaimilla koodattu
# Versio 1.01. 10.4.2025. Lisätty GPO tarkistukset
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/                 


function Show-Menu {
    param (
        [string]$Title = 'Windows-järjestelmän hallinta'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "Vihreä teksti tarkoittaa, että tehtävän kohta on oikein tehty" -ForegroundColor Green
    Write-Host "Punainen teksti tarkoittaa, että tehtävän kohta on todennäköisesti väärin tehty" -ForegroundColor Red
    Write-Host "Keltainen teksti tarkoittaa, että tehtävän kohta oli sellainen jota skripti ei osaa tarkistaa" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "Paina '1' tarkistaaksesi tehtävän: 	     001 Perusasetukset" 
    Write-Host "Paina '2' tarkistaaksesi tehtävän: 	     002 Toimialueen rakentaminen" 
    Write-Host "Paina '3' tarkistaaksesi tehtävän: 	     003 Käyttäjät, ryhmät ja organisaatiot" 
    Write-Host "Paina '4' tarkistaaksesi tehtävän: 	     004 DHCP" 
    Write-Host "Paina '5' tarkistaaksesi tehtävän: 	     005 Toimialueen perustoiminnot" 
    Write-Host "Paina '6' tarkistaaksesi tehtävän: 	     006 Ryhmäkäytännöt"
    Write-Host "Paina '7' tarkistaaksesi tehtävän: 	     007 Etäyhteydet ja valvonta" 
    Write-Host "Paina '8' tarkistaaksesi tehtävän: 	     008 WWW ja DNS" 
    Write-Host "Paina '9' tarkistaaksesi tehtävän: 	     009 Verkkojaot" 
    Write-Host "Paina '12' tarkistaaksesi tehtävän: 	     012 Verkkojakojen oikeudet" 
    Write-Host "Paina '13' tarkistaaksesi tehtävän: 	     013 Kahdentaminen" 
    Write-Host "Paina 'Q' lopettakseesi" 
    Write-Host ""
}

do
 {
    Show-Menu
    $selection = Read-Host "Valitse tehtävä, jonka haluat tarkistaa skriptillä"
    switch ($selection)
    {


    '1' {
    Write-Host "================ Tarkistetaan tehtävä 001 ================"
    Write-Host "Olethan tutustunut Server Manageriin? ;)" -ForegroundColor Yellow

    #IP-asetusten tarkistaminen
    $IP_osoite = (Get-Netipaddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).IPAddress

    #IP-osoite
    if ($IP_osoite -eq "192.168.1.20")
        {
        Write-Host "IP-osoite on $IP_osoite eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "IP-osoite on $IP_osoite eli väärin" -ForegroundColor Red
    }

    #Aliverkonmaski
    $aliverkonMaski = (Get-Netipaddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).PrefixLength

    if ($aliverkonMaski -eq "24")
        {
        Write-Host "Aliverkonmaski on /$aliverkonMaski eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Aliverkonmaski on /$aliverkonMaski eli väärin" -ForegroundColor Red
    }

    #Oletusyhdyskäytävä
    $oletusYhdyskaytava = (Get-NetIPConfiguration -InterfaceAlias "Ethernet").IPv4DefaultGateway.NextHop
    if ($oletusYhdyskaytava -eq "192.168.1.1")
        {
        Write-Host "Oletusyhdyskäytävä on $oletusYhdyskaytava eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Oletusyhdyskäytävä on $oletusYhdyskaytava eli väärin" -ForegroundColor Red
    }

    #DNS-osoite
    $dnsOsoite = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).ServerAddresses

    if ($dnsOsoite -eq "8.8.8.8")
        {
        Write-Host "DNS on $dnsOsoite eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "DNS on $dnsOsoite eli väärin" -ForegroundColor Red
    }

    #Tietokoneen tarkistaminen
    $tietokoneenNimi = $env:COMPUTERNAME

    if ($tietokoneenNimi -eq "WINDOWS-SRV-001")
        {
        Write-Host "Tietokoneen nimi on $tietokoneenNimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokoneen nimi on $tietokoneenNimi eli väärin" -ForegroundColor Red
    }

    #Päivämäärä ja kellonaika
    $pvm = Get-Date
    Write-Host "Päivämäärä ja kellonaika ovat: $pvm, ovathan ne oikein?" -ForegroundColor Yellow

    #Aikavyöhyke
    $aikaVyohyke = (Get-TimeZone).DisplayName
    $oikeaVyohyke = "Helsinki"

    if ($aikaVyohyke -like "*$oikeaVyohyke*") 
        {
        Write-Host "Aikavyöhyke on $aikaVyohyke. --- Helsinki (Suomi) on samassa aikavyöhykkeessä" -ForegroundColor Green
        } 
    else {
        Write-Host "Aiavyöhyke on $aikaVyohyke ei välttämättä ole oikein, mutta tähän voi vaikuttaa myös oma sijaintsi." -ForegroundColor Yellow
    }

    #Internet yhteyden testaaminen
    $yhteysTesti = (Test-Connection 8.8.8.8 -Quiet)

    if ($yhteysTesti -eq "True")
        {
        Write-Host "Yhteyttä testattu osoitteeseen 8.8.8.8, yhteys onnistui" -ForegroundColor Green
        }
    else {
        Write-Host "Yhteyttä testattu osoitteeseen 8.8.8.8, yhteys ei onnistunut" -ForegroundColor Red
    }

    #Chrome ja Firefox tarkistaminen
    Write-Host "Varmista, että jompikumpi Chrome tai Firefox on asennettu!" -ForegroundColor Yellow
    $chromePolku = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    $firefoxPolku = "C:\Program Files\Mozilla Firefox\firefox.exe"
    $chromeTarkistus = Test-Path -Path $chromePolku
    $firefoxTarkistus = Test-Path -Path $firefoxPolku
    
    if ($chromeTarkistus -eq "True")
        {
        Write-Host "Chrome löytyy sijainnista $chromePolku" -ForegroundColor Green
        }
    else {
        Write-Host "Chromea ei löydy sijainnista $chromePolku" -ForegroundColor Red
    }

    if ($firefoxTarkistus -eq "True")
        {
        Write-Host "Firefox löytyy sijainnista $firefoxPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Firefoxia ei löydy sijainnista $firefoxPolku" -ForegroundColor Red
    }

    
    } 

    '2' {
    Write-Host "================ Tarkistetaan tehtävä 002 ================"

    #Toimialueen polun tarkistaminen
    $toimialuePolku = "C:\toimialue"
    $toimialuePolkuTarkistus = Test-Path -Path $toimialuePolku

    if ($toimialuePolkuTarkistus -eq "True")
        {
        Write-Host "Kansio $toimialuePolku on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Kansiota $toimialuePolku ei ole olemassa" -ForegroundColor Red
    }

    #Toimialueen nimen tarkistamine
    $toimialueNimi = (Get-ADDomain).DNSRoot
    if ($toimialueNimi -eq "hyriadesk.net")
        {
        Write-Host "Toimialueen nimi on $toimialueNimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueen nimi on $toimialueNimi eli väärin" -ForegroundColor Red
    }

    #Recovery mode salasana
    Write-Host "Asetithan Active Directory Restore Moden salasanaksi oikean? ;)" -ForegroundColor Yellow

    #DNS asennettu
    $DNSAsennettu = (Get-WindowsFeature  | Where-Object {$_.Name -eq "DNS"}).InstallState
    if ($DNSAsennettu -eq "Installed")
        {
        Write-Host "DNS-rooli on asennettu palvelimelle" -ForegroundColor Green
        }
    else {
        Write-Host "DNS-roolia ei ole asennettu palvelimelle" -ForegroundColor Red
    }

    #DB polku
    $DBPolku = "C:\toimialue\DB"
    $DBPolkuTarkistus = Test-Path -Path $DBPolku

    if ($DBPolkuTarkistus -eq "True")
        {
        Write-Host "Kansio $DBPolku on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Kansiota $DBPolku ei ole olemassa" -ForegroundColor Red
    }

    #Log polku
    $LOGPolku = "C:\toimialue\Log"
    $LOGPolkuTarkistus = Test-Path -Path $LOGPolku

    if ($DBPolkuTarkistus -eq "True")
        {
        Write-Host "Kansio $LOGPolku on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Kansiota $LOGPolku ei ole olemassa" -ForegroundColor Red
    }

    #SYSVOL polku
    $SYSVOLPolku = "C:\toimialue\SYSVOL"
    $SYSVOLPolkuTarkistus = Test-Path -Path $SYSVOLPolku

    if ($DBPolkuTarkistus -eq "True")
        {
        Write-Host "Kansio $SYSVOLPolku on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Kansiota $SYSVOLPolku ei ole olemassa" -ForegroundColor Red
    }

    #Yhteenvedon skripti työpöydällä
    Write-Host "Latasithan yhteenvedon skriptin työpöydällesi? ;)" -ForegroundColor Yellow

    } 

    '3' {
    Write-Host "================ Tarkistetaan tehtävä 003 ================"


    #Riihimäki Tietokoneet OU
    $OU_rmkTietokoneet = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net').Name
    $OU_rmkTietokoneetPolku = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_rmkTietokoneet -eq "Tietokoneet")
        {
        Write-Host "OU nimeltään $OU_rmkTietokoneet on olemassa polussa: $OU_rmkTietokoneetPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_rmkTietokoneet ei löydetty polusta: $OU_rmkTietokoneetPolku" -ForegroundColor Red
    }

    #Riihimäki Käyttäjät OU
    $OU_rmkKayttajat = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net').Name
    $OU_rmkKayttajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_rmkKayttajat -eq "Käyttäjät")
        {
        Write-Host "OU nimeltään $OU_rmkKayttajat on olemassa polussa: $OU_rmkKayttajatPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_rmkKayttajat ei löydetty polusta: $OU_rmkKayttajatPolku" -ForegroundColor Red
    }

    #Turku Tietokoneet OU
    $OU_turkuTietokoneet = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net').Name
    $OU_turkuTietokoneetPolku = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_turkuTietokoneet -eq "Tietokoneet")
        {
        Write-Host "OU nimeltään $OU_turkuTietokoneet on olemassa polussa: $OU_turkuTietokoneetPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_turkuTietokoneet ei löydetty polusta: $OU_turkuTietokoneetPolku" -ForegroundColor Red
    }

    #Turku Käyttäjät OU
    $OU_turkuKayttajat = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net').Name
    $OU_turkuKayttajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_turkuKayttajat -eq "Käyttäjät")
        {
        Write-Host "OU nimeltään $OU_turkuKayttajat on olemassa polussa: $OU_turkuKayttajatPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_turkuKayttajat ei löydetty polusta: $OU_turkuKayttajatPolku" -ForegroundColor Red
    }

    #Valmenajat OU tarkistus
    $OU_Valmentajat = (Get-ADOrganizationalUnit -Identity 'OU=Valmentajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net').Name
    $OU_ValmentajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Valmentajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_Valmentajat -eq "Valmentajat")
        {
        Write-Host "OU nimeltään $OU_Valmentajat on olemassa polussa: $OU_ValmentajatPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_Valmentajat ei löydetty polusta: $OU_ValmentajatPolku" -ForegroundColor Red
    }

    #IT-tuki OU tarkistus
    $OU_ittuki = (Get-ADOrganizationalUnit -Identity 'OU=IT-tuki,DC=hyriadesk,DC=net').Name
    $OU_ittukiPolku = (Get-ADOrganizationalUnit -Identity 'OU=IT-tuki,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_ittuki -eq "IT-tuki")
        {
        Write-Host "OU nimeltään $OU_ittuki on olemassa polussa: $OU_ittukiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_ittuki ei löydetty polusta $OU_ittukiPolku" -ForegroundColor Red
    }

    #Riihimäki ryhmien tarkistus
    $ryhma_rmkDevices =  (Get-ADGroup -Identity "RiihimakiDevices").Name
    $ryhma_rmkDevicesPolku =  (Get-ADGroup -Identity "RiihimakiDevices").DistinguishedName

    if ($ryhma_rmkDevices -eq "RiihimakiDevices")
        {
        Write-Host "Ryhmä nimeltään $ryhma_rmkDevices on olemassa polussa: $ryhma_rmkDevicesPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_rmkDevices ei löydetty polusta $ryhma_rmkDevicesPolku" -ForegroundColor Red
    }

    $ryhma_rmkUsers =  (Get-ADGroup -Identity "RiihimakiUsers").Name
    $ryhma_rmkUsersPolku =  (Get-ADGroup -Identity "RiihimakiUsers").DistinguishedName

    if ($ryhma_rmkUsers -eq "RiihimakiUsers")
        {
        Write-Host "Ryhmä nimeltään $ryhma_rmkUsers on olemassa polussa: $ryhma_rmkUsersPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_rmkUsers ei löydetty polusta: $ryhma_rmkUsersPolku" -ForegroundColor Red
    }

    #Turku ryhmien tarkistus
    $ryhma_turkuDevices =  (Get-ADGroup -Identity "TurkuDevices").Name
    $ryhma_turkuDevicesPolku =  (Get-ADGroup -Identity "TurkuDevices").DistinguishedName

    if ($ryhma_turkuDevices -eq "TurkuDevices")
        {
        Write-Host "Ryhmä nimeltään $ryhma_turkuDevices on olemassa polussa: $ryhma_turkuDevicesPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_turkuDevices ei löydetty polusta $ryhma_turkuDevicesPolku" -ForegroundColor Red
    }

    $ryhma_turkuUsers =  (Get-ADGroup -Identity "TurkuUsers").Name
    $ryhma_turkuUsersPolku =  (Get-ADGroup -Identity "TurkuUsers").DistinguishedName

    if ($ryhma_turkuUsers -eq "TurkuUsers")
        {
        Write-Host "Ryhmä nimeltään $ryhma_turkuUsers on olemassa polussa: $ryhma_turkuUsersPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_turkuUsers ei löydetty polusta: $ryhma_turkuUsersPolku" -ForegroundColor Red
    }

    #Mallikäyttäjän tarkistus
    $kayttaja_malliUser = (Get-ADUser -identity template_user).SamAccountName
    $kayttaja_malliUserPolku = (Get-ADUser -identity template_user).distinguishedName

    if ($kayttaja_malliUser -eq "template_user")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUser on olemassa polussa: $kayttaja_malliUserPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUser ei löydetty polusta: $kayttaja_malliUserPolku" -ForegroundColor Red
    }

    #Mallikäyttäjän salasanan vaihto seuraavalla kirjautumisella
    $changePasswordAtNextLogon = (Get-ADUser -identity template_user -properties * | Select-Object pwdlastset).pwdlastset
    if ($changePasswordAtNextLogon -ne "0")
        {
        Write-Host "Käyttäjän $kayttaja_malliUser ei tarvitse vaihtaa salasanaa seuraavalla kirjautumiskerralla" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän $kayttaja_malliUser tulee vaihtaa salasana seuraavalla kirjautumiskerralla" -ForegroundColor Red
    }

    #Matti käyttäjä
    $kayttaja_matti = (Get-ADUser -identity matti).SamAccountName
    $kayttaja_mattiPolku = (Get-ADUser -identity matti).distinguishedName

    if ($kayttaja_matti -eq "matti")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_matti on olemassa polussa: $kayttaja_mattiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_matti ei löydetty polusta: $kayttaja_mattiPolku" -ForegroundColor Red
    }

    #Mikko käyttäjä
    $kayttaja_mikko = (Get-ADUser -identity mikko).SamAccountName
    $kayttaja_mikkoPolku = (Get-ADUser -identity mikko).distinguishedName

    if ($kayttaja_mikko -eq "mikko")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_mikko on olemassa polussa: $kayttaja_mikkoPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_mikko ei löydetty polusta: $kayttaja_mikkoPolku" -ForegroundColor Red
    }

    #Jussi käyttäjä
    $kayttaja_jussi = (Get-ADUser -identity jussi).SamAccountName
    $kayttaja_jussiPolku = (Get-ADUser -identity jussi).distinguishedName

    if ($kayttaja_jussi -eq "jussi")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_jussi on olemassa polussa: $kayttaja_jussiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_jussi ei löydetty polusta: $kayttaja_jussiPolku" -ForegroundColor Red
    }

    #Juho käyttäjä
    $kayttaja_juho = (Get-ADUser -identity juho).SamAccountName
    $kayttaja_juhoPolku = (Get-ADUser -identity juho).distinguishedName

    if ($kayttaja_juho -eq "juho")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_juho on olemassa polussa: $kayttaja_juhoPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_juho ei löydetty polusta: $kayttaja_juhoPolku" -ForegroundColor Red
    }

    #Maria käyttäjä
    $kayttaja_maria = (Get-ADUser -identity maria).SamAccountName
    $kayttaja_mariaPolku = (Get-ADUser -identity maria).distinguishedName

    if ($kayttaja_maria -eq "maria")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_maria on olemassa polussa: $kayttaja_mariaPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_maria ei löydetty polusta: $kayttaja_mariaPolku" -ForegroundColor Red
    }

    #Leena käyttäjä
    $kayttaja_leena = (Get-ADUser -identity leena).SamAccountName
    $kayttaja_leenaPolku = (Get-ADUser -identity leena).distinguishedName

    if ($kayttaja_leena -eq "leena")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_leena on olemassa polussa: $kayttaja_leenaPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_leena ei löydetty polusta: $kayttaja_leenaPolku" -ForegroundColor Red
    }

    #Aleksi käyttäjä
    $kayttaja_aleksi = (Get-ADUser -identity aleksi).SamAccountName
    $kayttaja_aleksiPolku = (Get-ADUser -identity aleksi).distinguishedName

    if ($kayttaja_aleksi -eq "aleksi")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_aleksi on olemassa polussa: $kayttaja_aleksiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_aleksi ei löydetty polusta: $kayttaja_aleksiPolku" -ForegroundColor Red
    }

    #TA099 tietokone
    $tietokone_ta099 = (Get-ADComputer -Filter * -SearchBase "OU=Valmentajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").Name
    $tietokone_ta099Polku = (Get-ADComputer -Filter * -SearchBase "OU=Valmentajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").DistinguishedName

    if ($tietokone_ta099 -eq "windows-ta-099")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta099 on olemassa polussa: $tietokone_ta099Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään windows-ta-099 ei löytynyt oikeasta paikasta" -ForegroundColor Red
    }

    #AD roskakori
    If ((Get-ADOptionalFeature -Filter {Name -like "Recycle*"}).EnabledScopes) 
        {
        Write-Host "Toimialueen roskakori on käytössä" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueen roskakori ei ole käytössä" -ForegroundColor Red
        }


    #Ryhmien jäsenyydet
    $mattiRyhma = (Get-ADGroupMember -Identity "TurkuUsers" | Where-Object {$_.name -eq "Matti"}).name
    if ($mattiRyhma -eq "Matti")
        {
        Write-Host "Käyttäjä nimeltään $mattiRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mattiRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    $mikkoRyhma = (Get-ADGroupMember -Identity "TurkuUsers" | Where-Object {$_.name -eq "Mikko"}).name
    if ($mikkoRyhma -eq "Mikko")
        {
        Write-Host "Käyttäjä nimeltään $mikkoRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mikkoRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    $mariaRyhma = (Get-ADGroupMember -Identity "RiihimakiUsers" | Where-Object {$_.name -eq "Maria"}).name
    if ($mariaRyhma -eq "Maria")
        {
        Write-Host "Käyttäjä nimeltään $mariaRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mariaRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #PICCI OU tarkistus
    $OU_PICCI = (Get-ADOrganizationalUnit -Identity 'OU=PICCI,DC=hyriadesk,DC=net').Name
    $OU_PICCIPolku = (Get-ADOrganizationalUnit -Identity 'OU=PICCI,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_PICCI -eq "PICCI")
        {
        Write-Host "OU nimeltään $OU_PICCI ei löydetty eli se on poistettu tai väärässä sijainnissa" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_PICCI on olemassa polussa: $OU_PICCI" -ForegroundColor Red
    }

    #Elsan palauttaminen roskakorista
    Write-Host "Palautithan Elsan tili toimialueen roskakorista? ;)" -ForegroundColor Yellow

    #Maria käyttäjän lisätiedot
    $puhNro = (Get-ADUser -identity Maria -properties * | Select-Object OfficePhone).OfficePhone
    $kaupunki = (Get-ADUser -identity Maria -properties * | Select-Object city).city
    $toimisto = (Get-ADUser -identity Maria -properties * | Select-Object Office).Office
    $osoite = (Get-ADUser -identity Maria -properties * | Select-Object StreetAddress).StreetAddress     
    Write-Host "Käyttäjän Maria puhelinnumero on: $puhnro, Osoite on: $osoite, Kaupunki on: $kaupunki, ja toimisto on: $toimisto" -ForegroundColor Yellow

    #Juhon UPN
    $juhoUPN = (Get-ADUser -identity Juho).UserPrincipalName
    Write-Host "Juhon UPN on: $juhoUPN" -ForegroundColor Yellow

    }

    '4' {
    Write-Host "================ Tarkistetaan tehtävä 004 ================"

    #DHCP Scope
    $dhcpScope = (Get-DhcpServerv4Scope).ScopeId.IPAddressToString

    if ($dhcpScope -eq "192.168.1.0")
        {
        Write-Host "DHCP verkkoalue on $dhcpScope" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP verkkoalue on $dhcpScope ja on väärin" -ForegroundColor Red
    }
    
    #DHCP maski
    $dhcpMaski = (Get-DhcpServerv4Scope).SubnetMask.IPAddressToString
    if ($dhcpMaski -eq "255.255.255.0")
        {
        Write-Host "DHCP verkkoalueen aliverkonmaski on $dhcpMaski" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP verkkoalueen aliverkonmaski on $dhcpMaski ja on väärin" -ForegroundColor Red
    }

    #DHCP alkuosoite
    $dhcpAlkuOsoite = (Get-DhcpServerv4Scope).StartRange.IPAddressToString
    if ($dhcpAlkuOsoite -eq "192.168.1.50")
        {
        Write-Host "DHCP jakoalue alkaa osoitteesta $dhcpAlkuOsoite" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalue alkaa osoitteesta $dhcpAlkuOsoite ja on väärin" -ForegroundColor Red
    }

    #DHCP loppuosoite
    $dhcpLoppuOsoite = (Get-DhcpServerv4Scope).EndRange.IPAddressToString
    if ($dhcpLoppuOsoite -eq "192.168.1.90")
        {
        Write-Host "DHCP jakoalue loppuu osoitteesta $dhcpLoppuOsoite" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalue loppuu osoitteesta $dhcpLoppuOsoite ja on väärin" -ForegroundColor Red
    }

    #DHCP exclusion alkuosoite
    $dhcpExclAlku = (Get-DhcpServerv4ExclusionRange).StartRange.IPAddressToString
    if ($dhcpExclAlku -eq "192.168.1.70")
        {
        Write-Host "DHCP jakoalueen poissulku (exclusion) alkaa osoitteesta $dhcpExclAlku" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalueen poissulku (exclusion) alkaa osoitteesta $dhcpExclAlku ja on väärin" -ForegroundColor Red
    }

    #DHCP exclusion loppuosoite
    $dhcpExclLoppu = (Get-DhcpServerv4ExclusionRange).EndRange.IPAddressToString
    if ($dhcpExclLoppu -eq "192.168.1.80")
        {
        Write-Host "DHCP jakoalueen poissulku (exclusion) loppuu osoitteeseen $dhcpExclLoppu" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalueen poissulku (exclusion) loppuu osoitteeseen $dhcpExclLoppu ja on väärin" -ForegroundColor Red
    }

    #DHCP vuokra aika
    $dhcpVuokra = (Get-DhcpServerv4Scope).LeaseDuration.Hours
    if ($dhcpVuokra -eq "15")
        {
        Write-Host "DHCP jakoalueen vuokraaika on: $dhcpVuokra tuntia" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalueen vuokraaika on: $dhcpVuokra tuntia, joka on väärin" -ForegroundColor Red
    }

    #DHCP GW
    $dhcpGW = (Get-DhcpServerv4OptionValue -ScopeId 192.168.1.0 | Where-Object {$_.OptionId -eq "3"}).Value
    if ($dhcpGW -eq "192.168.1.1")
        {
        Write-Host "DHCP jakaa oletusyhdyskäytävää: $dhcpGW" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakaa oletusyhdyskäytävää: $dhcpGW, joka on väärin" -ForegroundColor Red
    }
    #DHCP DNS
    $dhcpDNS = (Get-DhcpServerv4OptionValue -ScopeId 192.168.1.0 | Where-Object {$_.OptionId -eq "6"}).Value
    if ($dhcpDNS -eq "192.168.1.20")
        {
        Write-Host "DHCP jakaa DNS-osoitetta: $dhcpDNS" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakaa DNS-osoitetta: $dhcpDNS, joka on väärin" -ForegroundColor Red
    }

    #DHCP varaus
    $dhcpVarausIP = (Get-DhcpServerv4Reservation -ScopeId 192.168.1.0).IPAddress.IPAddressToString
    if ($dhcpVarausIP -eq "192.168.1.91")
        {
        Write-Host "Varaus on tehty IP-osoitteelle $dhcpVarausIP" -ForegroundColor Green
        }
    else {
        Write-Host "Varausta ei ole tehty IP-osoitteelle $dhcpVarausIP" -ForegroundColor Red
    }
    $dhcpVarausMAC = (Get-DhcpServerv4Reservation -ScopeId 192.168.1.0).ClientId
    if ($dhcpVarausMAC -eq "00-01-02-03-ab-df")
        {
        Write-Host "Varaus on tehty MAC-osoitteelle $dhcpVarausMAC" -ForegroundColor Green
        }
    else {
        Write-Host "Varausta ei ole tehty MAC-osoitteelle $dhcpVarausMAC" -ForegroundColor Red
    }

    #DHCP bindaus ja autorisointi
    $dhcpBindaus = (Get-DhcpServerv4Binding).InterfaceAlias
    $dhcpBindausIP = (Get-DhcpServerv4Binding).IPAddress.IPAddressToString
    Write-Host "DHCP palvelu on bindattu verkkokortille: $dhcpBindaus, jonka IP-osoite on: $dhcpBindausIP" -ForegroundColor Yellow

    $dhcpAutorisointi = (Get-DhcpServerInDC).IPAddress.IPAddressToString
    if ($dhcpAutorisointi -eq "192.168.1.20")
        {
        Write-Host "DHCP palvelu on autorisoitu" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP palvelua ei ole autorisoitu" -ForegroundColor Red
    }

    $dhcpTestiIP = (Get-DhcpServerv4Lease -ScopeId 192.168.1.0 | Where-Object {$_.HostName -like "windows-ta-001.hyriadesk.net"}).IPAddress.IPAddressToString
    $dhcpTesti = (Test-Connection $dhcpTestiIP -Quiet)

    if ($dhcpTesti -eq "True")
        {
        Write-Host "Yhteyttä testattu osoitteeseen $dhcpTestiIP (laite nimeltään windows-ta-001), yhteys onnistui" -ForegroundColor Green
        }
    else {
        Write-Host "Yhteyttä testattu osoitteeseen $dhcpTestiIP (laite nimeltään windows-ta-001), yhteys ei onnistunut. Onhan palomuurista sallittu pingaaminen?" -ForegroundColor Red
    }

    #DHCP tilastot ja database polku
    Write-Host "Olethan muuttanut DHCP:n tilastojen päivittymisajan tapahtumaan 5 minuutin välein?" -ForegroundColor Yellow
    Write-Host "DHCP tietokannan polku löytyy polusta C:\WINDOWS\system32\dhcp" -ForegroundColor Yellow

    #DHCP backup tarkistus
    $dhcpBackupPolku = Test-Path "C:\DHCPbackup\DhcpCfg"
    if ($dhcpBackupPolku -eq "True")
        {
        Write-Host "DHCP varmuuskopio (backup) löytyy sijainnista C:\DHCPbackup\DhcpCfg" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP varmuuskopio (backup) ei löytynyt sijainnista C:\DHCPbackup\DhcpCfg" -ForegroundColor Red
    }


    } 

    '5' {
    Write-Host "================ Tarkistetaan tehtävä 005 ================"

    #Oikeuksien delegointi ja kirjautumisajat
    Write-Host "Olethan delegoinut oikeuksia Juholle?" -ForegroundColor Yellow
    Write-Host "Olethan määrittänyt kirjautumisajat käyttäjälle Jussi?" -ForegroundColor Yellow

    #Laurin tili disabloitu
    $lauriDisabloitu = (Get-ADUser -identity Lauri -properties * | Select-Object Enabled).Enabled
    if ($lauriDisabloitu -eq $False)
        {
        Write-Host "Käyttäjän Lauri tili on disabloitu" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän Lauri tiliä ei ole disabloitu" -ForegroundColor Red
    }

    #Millan tili poistettu
    $ErrorActionPreference = "SilentlyContinue"
    $kayttaja_milla = (Get-ADUser -identity milla -ErrorAction SilentlyContinue).SamAccountName 
    $kayttaja_millaPolku = (Get-ADUser -identity milla -ErrorAction SilentlyContinue).DistinguishedName

    if ($kayttaja_milla -eq "milla")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_milla on olemassa polussa: $kayttaja_millaPolku" -ForegroundColor Red
        }
    else {
        Write-Host "Käyttäjää nimeltään Milla ei löydetty " -ForegroundColor Green
    }

    #Pekan tilin salasana
    Write-Host "Onhan Pekan tilin salasana pyydetty?" -ForegroundColor Yellow
    
    #Pekan tilin vanheneminen
    $pekkaTiliVanhenee = (Get-ADUser -Identity Pekka -Properties *).AccountExpirationDate
    Write-Host "Pekan tili vanhenee $pekkaTiliVanhenee, onhan se vuoden päässä tästä päivästä?" -ForegroundColor Yellow

    #Pekan tietokone
    $pekkaTietokone = (Get-ADUser -Identity Pekka -Properties *).LogonWorkstations
    if ($pekkaTietokone -eq "windows-ta-001")
        {
        Write-Host "Pekan tietokone on $pekkaTietokone" -ForegroundColor Green
        }
    else {
        Write-Host "Pekan tietokone on $pekkaTietokone ja se on väärin" -ForegroundColor Red
    }

    Write-Host "Työasemalta käsin Pekka voi vaihtaa salasanansa esimerkiksi CTRL + ALT + DEL pikanäppäinyhdistelmän kautta" -ForegroundColor Yellow
    
    #Jalmari nimi
    $jalmariNimi = (Get-ADUser -Identity "jalmari.valimaa" -Properties *).Name
    if ($jalmariNimi -eq "Jalmari Välimaa")
        {
        Write-Host "Käyttäjän nimi on $jalmariNimi" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän nimi on $jalmariNimi eli väärin" -ForegroundColor Red
    }

    #Jalmari käyttäjätunnus
    $jalmariKayttajanimi = (Get-ADUser -Identity "jalmari.valimaa" -Properties *).UserPrincipalName
    if ($jalmariKayttajanimi -eq "jalmari.valimaa@hyriadesk.net")
        {
        Write-Host "Käyttäjän kirjautumistunnus on $jalmariKayttajanimi" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän kirjautumistunnus on $jalmariKayttajanimi eli väärin" -ForegroundColor Red
    }

    #Tietokone tili oikea polku
    $tietokone_ta001 = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").Name
    $tietokone_ta001Polku = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").DistinguishedName

    if ($tietokone_ta001 -eq "windows-ta-001")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta001 on olemassa polussa: $tietokone_ta001Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään windows-ta-001 ei löytynyt oikeasta polusta" -ForegroundColor Red
    }

    #Tietokone tili ryhmäjäsenyys
    $tietokoneRyhmaJasen = (Get-ADPrincipalGroupMembership (Get-ADComputer "windows-ta-001") | select-object name | Where-Object {$_.Name -eq "RiihimakiDevices"}).name
    if ($tietokoneRyhmaJasen -eq "RiihimakiDevices")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta001 ryhmässä: $tietokoneRyhmaJasen" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään $tietokone_ta001 ei ole oikeassa ryhmässä" -ForegroundColor Red
    }
    } 

    '6' {
    Write-Host "================ Tarkistetaan tehtävä 006 ================"

    Write-Host "GPO/ryhmäkäytäntöjen tarkistuksen aikana C:\ aseman juureen luodaan useita .XML tyyppisiä tiedostoja. Niistä ei tarvitse murehtia!" -ForegroundColor Yellow

    #GPO Default domain policy
    $DefaultDomainPolicy = "Default Domain Policy"
    Get-GPOReport -Name $DefaultDomainPolicy -ReportType XML -Path C:\DefaultDomainPolicy.xml
    $DefaultDomainPolicyGPOpituus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern '<q1:Name>MinimumPasswordLength</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>6<"
    if ($DefaultDomainPolicyGPOpituus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy minimi salasana määritys on väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy minimi salasana määritys on oikein" -ForegroundColor Green
    }

    $DefaultDomainPolicyGPOmonimutkaisuus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern '<q1:Name>PasswordComplexity</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingBoolean>true<"
    if ($DefaultDomainPolicyGPOmonimutkaisuus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy monimutkaisuus säännöt ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy monimutkaisuus säännöt ovat oikein" -ForegroundColor Green
    }

    $DefaultDomainPolicyGPOlukitus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern '<q1:Name>LockoutBadCount</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>5<"
    if ($DefaultDomainPolicyGPOlukitus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy tilin lukitus säännöt ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy tilin lukitus säännöt ovat oikein" -ForegroundColor Green
    }

    #GPO estä Control panel
    $BlockControlPanel = "BlockControlPanel"
    Get-GPOReport -Name $BlockControlPanel -ReportType XML -Path C:\BlockControlPanel.xml
    $BlockControlPanelGPO = Select-String -path C:\BlockControlPanel.xml -Pattern '<q1:Name>Prohibit access to Control Panel and PC settings</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "State>Enabled<"
    if ($BlockControlPanelGPO -eq $null)
        {
        Write-Host "GPOn $BlockControlPanel sääntö on väärin eli Ohjauspaneelia ei ole estetty" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $BlockControlPanel sääntö on oikein eli Ohjauspaneeliin ei ole pääsyä" -ForegroundColor Green
    }

    Write-Host "gpudate /force komennolla saadaan pakotettua ryhmäkäytäntöjen päivitys työasemalla" -ForegroundColor Yellow
    Write-Host "Olethan testannut ryhmäkäytäntöjen toiminnan työasemalla?" -ForegroundColor Yellow

    #GPO backup sijainti
    $GPOkansioTarkistus = Test-Path -Path "C:\GPOBackup"
    if ($GPOkansioTarkistus -eq "True")
        {
        Write-Host "C:\GPOBackup kansio löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "C:\GPOBackup kansiota ei löydy" -ForegroundColor Red
    }

    #GPO Backup sisältö
    $GPOkansioSisalto = Get-ChildItem "C:\GPOBackup\"
    if ($GPOkansioSisalto -eq $null)
        {
        Write-Host "Kansiossa C:\GPOBackup\ ei ole mitään sisältöä eli varmuuskopioita ei todennäköisesti ole otettu sinne" -ForegroundColor Red
        }
    else {
        Write-Host "Kansiossa C:\GPOBackup\ on jotain sisältöä eli varmuuskopiot on todennäköisesti otettu sinne" -ForegroundColor Green
    }

    }

    '7' {
    Write-Host "================ Tarkistetaan tehtävä 007 ================"

    #Onko RDP sallittu
    $RDPSallittu = (Get-WmiObject -class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices -ComputerName .).AllowTSConnections
    if ($RDPSallittu -eq "1")
        {
        Write-Host "RDP etäyhteys on sallittu" -ForegroundColor Green
        }
    else {
        Write-Host "RDP etäyhteyttä ei ole sallittu" -ForegroundColor Red
    }

    #Onko Juho Remote Desktop Users ryhmässä
    $juhoRDP = (Get-ADGroupMember -Identity "Remote Desktop Users" | Where-Object {$_.name -eq "Juho"}).name
    if ($juhoRDP -eq "Juho")
        {
        Write-Host "Käyttäjä nimeltään $juhoRDP on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $juhoRDP ei ole oikeassa ryhmässä" -ForegroundColor Red
    }
    #Muista testata
    Write-Host "Testaa, että Juho pystyy muodostamaan RDP-etäyhteyden työasemalta palvelimelle" -ForegroundColor Yellow

    #Teamviewer asennettu?
    $teamviewerPolku = "C:\Program Files\TeamViewer\TeamViewer.exe"
    $teamviewerTarkistus = Test-Path -Path $teamviewerPolku
    
    if ($teamviewerTarkistus -eq "True")
        {
        Write-Host "TeamViewer löytyy sijainnista $teamviewerPolku" -ForegroundColor Green
        }
    else {
        Write-Host "TeamViewera ei löydy sijainnista $teamviewerPolku" -ForegroundColor Red
    }

    #Muista testata Teamviewer
    Write-Host "Testaa, että TeamViewer yhteys toimii työaseman ja palvelimen välillä" -ForegroundColor Yellow
    } 

    '8' {
    Write-Host "================ Tarkistetaan tehtävä 008 ================"
 
    #IIS Oletushakemisto
    $IIS_oletusHakemisto = (Get-IISSite "Default Web Site").Applications.VirtualDirectories.PhysicalPath
    if ($IIS_oletusHakemisto -eq "C:\webbiserveri")
        {
        Write-Host "Sivuston oletushakemisto on $IIS_oletusHakemisto" -ForegroundColor Green
        }
    else {
        Write-Host "Sivuston oletushakemisto on $IIS_oletusHakemisto joka on väärin" -ForegroundColor Red
    }

    #Sivun sisältö
    $IIS_sisalto = Get-Content C:\webbiserveri\index.html
    Write-Host "Sivuston sisältö on seuraava:" -ForegroundColor Yellow
    Write-Host "$IIS_sisalto" -ForegroundColor Yellow

    Write-Host "Olethan testannut sivuston toiminnan työasemalta käsin?" -ForegroundColor Yellow

    #DNS forward zone
    $DNS_fwZone = (Get-DnsServerZone | Where-Object {$_.ZoneName -eq "hyriadesk.fi"}).ZoneName
    if ($DNS_fwZone -eq "hyriadesk.fi")
        {
        Write-Host "DNS alue $DNS_fwZone löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "DNS aluetta $DNS_fwZone ei löydetty" -ForegroundColor Red
    }

    #A tietue
    $DNS_aTietue = (Get-DnsServerResourceRecord -ZoneName "hyriadesk.fi" | Where-Object {$_.RecordType -eq "A"}).RecordData.IPv4Address.IPAddressToString
    if ($DNS_aTietue -eq "192.168.1.20")
        {
        Write-Host "DNS alueelta löytyy oikea A-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa A-tietuetta" -ForegroundColor Red
    }

    #CNAME tietue
    $DNS_CNAMETietue = (Get-DnsServerResourceRecord -ZoneName "hyriadesk.fi" | Where-Object {$_.RecordType -eq "CNAME"}).HostName
    if ($DNS_CNAMETietue -eq "www")
        {
        Write-Host "DNS alueelta löytyy oikea CNAME-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa CNAME-tietuetta" -ForegroundColor Red
    }

    Write-Host "Olethan testannut sivuston/DNS toiminnan työaseman selaimen sekä nslookup työkalun kautta?" -ForegroundColor Yellow

    #Reverse Lookupzone
    $DNS_reverseZone = (Get-DnsServerZone | Where-Object {$_.ZoneName -eq "1.168.192.in-addr.arpa"}).ZoneName
    if ($DNS_reverseZone -eq "1.168.192.in-addr.arpa")
        {
        Write-Host "DNS alue $DNS_reverseZone löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "DNS aluetta $DNS_reverseZone ei löydetty" -ForegroundColor Red
    }

    #PTR tietue
    $DNS_ptrTietue = (Get-DnsServerResourceRecord -ZoneName "1.168.192.in-addr.arpa" | Where-Object {$_.RecordType -eq "ptr"}).HostName
    if ($DNS_ptrTietue -eq "20")
        {
        Write-Host "DNS alueelta löytyy oikea PTR-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa PTR-tietuetta" -ForegroundColor Red
    }

    #DNS forwarders
    $DNS_forwarders = (Get-DnsServerForwarder).IPAddress.IPAddressToString
    if ($DNS_forwarders -eq "8.8.8.8")
        {
        Write-Host "DNS forwarder osoite on $DNS_forwarders eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "DNS forwarder osoite on $DNS_forwarders eli väärin" -ForegroundColor Red
    }

    Write-Host "Muista vielä varmistaa kaiken toiminta!" -ForegroundColor Yellow

    } 

    '9' {
    Write-Host "================ Tarkistetaan tehtävä 009 ================"

    #Onko verkkojako JakoKansio olemassa?
    $netshare_JakoKansio = Test-Path \\windows-srv-001\jakokansio
    if ($netshare_JakoKansio -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\windows-srv-001\jakokansio" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\windows-srv-001\jakokansio" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa JakoKansio
    $netshare_JakoKansioOikeudet = (Get-SmbShareAccess -Name "JakoKansio" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_JakoKansioOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa JakoKansio ryhmällä Everyone on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa JakoKansio ryhmällä Everyone ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #fsrm txt estetty
    $fsrm_txt = ((get-fsrmfilegroup) |  Where-Object {$_.Name -eq "txt_blocked"}).IncludePattern
    if ($fsrm_txt -eq "*.txt")
        {
        Write-Host "File Screen Group on olemassa, joka estää *.txt tyyppiset tiedostot" -ForegroundColor Green
        }
    else {
        Write-Host "Oikeaa File Screen Groupia ei löydetty" -ForegroundColor Red
    }

    #fsrm onko oikeassa jaossa rajoitus
    $fsrm_rajoitus = (Get-FsrmFileScreen |  Where-Object {$_.Path -eq "C:\JakoKansio"}).IncludeGroup
    $fsrm_polku = (Get-FsrmFileScreen |  Where-Object {$_.Path -eq "C:\JakoKansio"}).Path
    if ($fsrm_rajoitus -eq "txt_blocked")
        {
        Write-Host "Rajoitus on tehty oikeaan verkkojakoon $fsrm_polku" -ForegroundColor Green
        }
    else {
        Write-Host "Rajoitus on tehty väärään verkkojakoon, sen pitäisi olla polussa $fsrm_polku" -ForegroundColor Red
    }

    #fsrm onko quota tehty JakoKansio
    $fsrm_quota = ((Get-FsrmQuotaTemplate) |  Where-Object {$_.Name -eq "2mb_quota"}).Size
    if ($fsrm_quota -eq "2097152")
        {
        Write-Host "2MB Quota template on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Quota templatea ei ole olemassa tai sen rajoituskoko on väärin" -ForegroundColor Red
    }

    #fsrm onko quota oikeassa verkkojaossa JakoKansio
    $fsrm_quotaRajoitus = (Get-FsrmQuota |  Where-Object {$_.Path -eq "C:\JakoKansio"}).Template
    $fsrm_quotaPolku = (Get-FsrmQuota |  Where-Object {$_.Path -eq "C:\JakoKansio"}).Path

    if ($fsrm_quotaRajoitus -eq "2mb_quota")
        {
        Write-Host "Quota on tehty verkkojakoon $fsrm_quotaPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Quota on tehty väärään verkkojakoon, sen pitäisi olla polussa $fsrm_quotaPolku" -ForegroundColor Red
    }

    #Onko verkkojako yhteinen olemassa?
    $netshare_yhteinen = Test-Path \\windows-srv-001\yhteinen
    if ($netshare_yhteinen -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\windows-srv-001\yhteinen" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\windows-srv-001\yhteinen" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa yhteinen
    $netshare_yhteinenOikeudet = (Get-SmbShareAccess -Name "yhteinen" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_yhteinenOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa yhteinen ryhmällä Everyone on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa yhteinen ryhmällä Everyone ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #fsrm onko quota tehty yhteinen
    $fsrm_quota2 = ((Get-FsrmQuotaTemplate) |  Where-Object {$_.Name -eq "20gb_quota"}).Size
    if ($fsrm_quota2 -eq "21474836480")
        {
        Write-Host "20GB Quota template on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Quota templatea ei ole olemassa tai sen rajoituskoko on väärin" -ForegroundColor Red
    }

    #fsrm onko quota oikeassa verkkojaossa yhteinen
    $fsrm_quota2Rajoitus = (Get-FsrmQuota |  Where-Object {$_.Path -eq "C:\yhteinen"}).Template
    $fsrm_quota2Polku = (Get-FsrmQuota |  Where-Object {$_.Path -eq "C:\yhteinen"}).Path

    if ($fsrm_quota2Rajoitus -eq "20gb_quota")
        {
        Write-Host "Quota on tehty verkkojakoon $fsrm_quota2Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Quota on tehty väärään verkkojakoon, sen pitäisi olla polussa $fsrm_quota2Polku" -ForegroundColor Red
    }

    #Onko verkkojaon Listattu kunnossa YhteinenJako
    $netshare_YhteinenListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "YhteinenJako"}).DistinguishedName
    if ($netshare_YhteinenListattu -eq "CN=YhteinenJako,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Verkkojako Yhteinen on listattu toimialueeseen polkuun $netshare_YhteinenListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojako Yhteinen ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    Write-Host "GPO/ryhmäkäytäntöjen tarkistuksen aikana C:\ aseman juureen luodaan useita .XML tyyppisiä tiedostoja. Niistä ei tarvitse murehtia!" -ForegroundColor Yellow

    #GPO Yhteinen verkkojaon tarkistaminen
    $YhteinenGPONimi = "YhteinenP"
    Get-GPOReport -Name $YhteinenGPONimi -ReportType XML -Path C:\YhteinenP.xml
    $YhteinenPGPOAction = Select-String -path C:\YhteinenP.xml -Pattern 'Properties action="C' -SimpleMatch

    if ($YhteinenPGPOAction -eq $null)
        {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon Action ei ole Create" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon Action on Create" -ForegroundColor Green
    }

    $YhteinenPGPOShow = Select-String -path C:\YhteinenP.xml -Pattern 'thisDrive="SHOW" allDrives="SHOW"' -SimpleMatch
    if ($YhteinenPGPOShow -eq $null)
        {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon Show drive asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon Show drive asetukset ovat oikein" -ForegroundColor Green
    }

    $YhteinenPGPOPolku = Select-String -path C:\YhteinenP.xml -Pattern 'path="\\WINDOWS-SRV-001\Yhteinen"' -SimpleMatch
    if ($YhteinenPGPOPolku -eq $null)
        {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon polku asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon polku asetukset ovat oikein" -ForegroundColor Green
    }

	$YhteinenPGPOPolkuKirjain = Select-String -path C:\YhteinenP.xml -Pattern 'letter="P"' -SimpleMatch
    if ($YhteinenPGPOPolkuKirjain -eq $null)
        {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon asemakirjain asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $YhteinenGPONimi verkkojaon asemakirjain asetukset ovat oikein" -ForegroundColor Green
    }

    Write-Host "Muista vielä varmistaa kaiken toiminta työasemalta käsin!" -ForegroundColor Yellow

    } 

    '12' {
    Write-Host "================ Tarkistetaan tehtävä 012 ================"
 

    #Ville käyttäjä
    $kayttaja_ville = (Get-ADUser -identity ville).SamAccountName
    $kayttaja_villePolku = (Get-ADUser -identity ville).distinguishedName

    if ($kayttaja_ville -eq "ville")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_ville on olemassa polussa: $kayttaja_villePolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_ville ei löydetty polusta: $kayttaja_villePolku" -ForegroundColor Red
    }

    #Ryhmien jäsenyydet
    $villeRyhma = (Get-ADGroupMember -Identity "Domain Admins" | Where-Object {$_.name -eq "Ville"}).name
    if ($villeRyhma -eq "Ville")
        {
        Write-Host "Käyttäjä nimeltään $villeRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $villeRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #adminit polun tarkistaminen
    $adminitPolku = "C:\adminit"
    $adminitPolkuTarkistus = Test-Path -Path $adminitPolku

    if ($adminitPolkuTarkistus -eq "True")
        {
        Write-Host "Kansio $adminitPolku on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Kansiota $adminitPolku ei ole olemassa" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa salaisetkansiot - Everyone
    $netshare_salaisetkansiotEveryoneOikeudet = (Get-SmbShareAccess -Name "salaisetkansiot" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_salaisetkansiotEveryoneOikeudet -eq "Read")
        {
        Write-Host "Verkkojaossa salaisetkansiot ryhmällä Everyone on vain lukuoikeudett" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa salaisetkansiot ryhmällä Everyone on väärät oikeudet" -ForegroundColor Red
    }
	
    #Onko verkkojaon oikeudet kunnossa salaisetkansiot - Domain Admins
    $netshare_salaisetkansiotDomainAdminsOikeudet = (Get-SmbShareAccess -Name "salaisetkansiot" | Where-Object {$_.AccountName -eq "Hyriadesk\Domain Admins"}).AccessRight
    if ($netshare_salaisetkansiotDomainAdminsOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa salaisetkansiot ryhmällä Domain Admins on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa salaisetkansiot ryhmällä Domain Admins ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #Oikeuksien testaus ja GPO
    Write-Host "Muistithan lisätä jaon toimialueeseen ja ryhmäkäytännöillä U: asemaksi?" -ForegroundColor Yellow
    Write-Host "Testasithan, että oikeudet toimivat?" -ForegroundColor Yellow

    #Onko verkkojaon oikeudet kunnossa salaisetkansiot - Leena
    $netshare_salaisetkansiotLeenaOikeudet = (Get-SmbShareAccess -Name "salaisetkansiot" | Where-Object {$_.AccountName -eq "Hyriadesk\Leena"}).AccessControlType
    if ($netshare_salaisetkansiotLeenaOikeudet -eq "Deny")
        {
        Write-Host "Verkkojaossa salaisetkansiot käyttäjällä Leena on estetty oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa salaisetkansiot käyttäjällä Leena on väärät oikeudet" -ForegroundColor Red
    }	

    #Oikeuksien testaus Leenalla
    Write-Host "Testasithan, että oikeudet toimivat Leenalla?" -ForegroundColor Yellow
	
    }

    '13' {
    Write-Host "================ Tarkistetaan tehtävä 013 ================"

    #srv2 toimialueella?
    $srv002 = (Get-ADComputer -Identity "Windows-srv-002").Name
    if ($srv002 -eq "windows-srv-002")
        {
        Write-Host "Toimialueella on palvelin nimeltään $srv002" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole toista palvelinta" -ForegroundColor Red
    }

    #DHCP failoverin nimi
    $failoverName = (Get-DhcpServerv4Failover).Name
    if ($failoverName -eq "hyriadesk_dhcp_failover")
        {
        Write-Host "DHCP failoverin nimi on $failoverName" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP failoverin nimi on $failoverName joka on väärin" -ForegroundColor Red
    }

    #DHCP failover kumppanin nimi
    $failoverPartner = (Get-DhcpServerv4Failover).PartnerServer
    if ($failoverPartner -eq "windows-srv-002.hyriadesk.net")
        {
        Write-Host "DHCP failoverin kumppanin nimi on $failoverPartner" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP failoverin kumppanin nimi on $failoverPartner joka on väärin" -ForegroundColor Red
    }

    #DHCP failover mode
    $failoverMode = (Get-DhcpServerv4Failover).Mode
    if ($failoverMode -eq "HotStandby")
        {
        Write-Host "DHCP failoverin toimintamoodi on $failoverMode" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP failoverin toimintamoodi on $failoverMode joka on väärin" -ForegroundColor Red
    }

    Write-Host "Olethan tarkistanut, että DHCP failover toimi, kun sammutit windows-srv-001 palvelimen? Eli 002 palvelin jakoi IP-asetuksia työasemille!" -ForegroundColor Yellow
    
    
 }
 }
    

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause

 }
 until ($selection -eq 'q')
