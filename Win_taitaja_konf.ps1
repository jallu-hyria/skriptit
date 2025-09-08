# Versio 1.00. 20.5.2025 Jalmari Välimaan taitaja tikkukirjaimilla tehty
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/                 


function Show-Menu {
    param (
        [string]$Title = 'Taitaja Windows konfiguraation'
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
    Write-Host "Paina '10' tarkistaaksesi tehtävän: 	     010 Print Server" 
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
    if ($IP_osoite -eq "192.168.0.10")
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
    if ($oletusYhdyskaytava -eq "192.168.0.1")
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

    if ($tietokoneenNimi -eq "taitaja-srv-001")
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

    #NTP testaus
    $ntpTesti = w32tm /query /source
    if ($ntpTesti -like "0.pool.ntp.org*")
        {
        Write-Host "Palvelimelle on asetettu oikea NTP-palvelin joka on $ntpTesti" -ForegroundColor Green
        }
    else {
        Write-Host "Palvelimelle ei ole asetettu oikeaa NTP-palvelinta" -ForegroundColor Red
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
    if ($toimialueNimi -eq "taitajat.fi")
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
    $LOGPolku = "C:\toimialue\NTDS"
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
    $OU_rmkTietokoneet = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi').Name
    $OU_rmkTietokoneetPolku = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi').DistinguishedName

    if ($OU_rmkTietokoneet -eq "Tietokoneet")
        {
        Write-Host "OU nimeltään $OU_rmkTietokoneet on olemassa polussa: $OU_rmkTietokoneetPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_rmkTietokoneet ei löydetty polusta: $OU_rmkTietokoneetPolku" -ForegroundColor Red
    }

    #Riihimäki Käyttäjät OU
    $OU_rmkKayttajat = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi').Name
    $OU_rmkKayttajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi').DistinguishedName

    if ($OU_rmkKayttajat -eq "Käyttäjät")
        {
        Write-Host "OU nimeltään $OU_rmkKayttajat on olemassa polussa: $OU_rmkKayttajatPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_rmkKayttajat ei löydetty polusta: $OU_rmkKayttajatPolku" -ForegroundColor Red
    }

    #Turku Tietokoneet OU
    $OU_turkuTietokoneet = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Turku,OU=taitajat,DC=taitajat,DC=fi').Name
    $OU_turkuTietokoneetPolku = (Get-ADOrganizationalUnit -Identity 'OU=Tietokoneet,OU=Turku,OU=taitajat,DC=taitajat,DC=fi').DistinguishedName

    if ($OU_turkuTietokoneet -eq "Tietokoneet")
        {
        Write-Host "OU nimeltään $OU_turkuTietokoneet on olemassa polussa: $OU_turkuTietokoneetPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_turkuTietokoneet ei löydetty polusta: $OU_turkuTietokoneetPolku" -ForegroundColor Red
    }

    #Turku Käyttäjät OU
    $OU_turkuKayttajat = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Turku,OU=taitajat,DC=taitajat,DC=fi').Name
    $OU_turkuKayttajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Kayttajat,OU=Turku,OU=taitajat,DC=taitajat,DC=fi').DistinguishedName

    if ($OU_turkuKayttajat -eq "Käyttäjät")
        {
        Write-Host "OU nimeltään $OU_turkuKayttajat on olemassa polussa: $OU_turkuKayttajatPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_turkuKayttajat ei löydetty polusta: $OU_turkuKayttajatPolku" -ForegroundColor Red
    }

    #Valmenajat OU tarkistus
    $OU_Valmentajat = (Get-ADOrganizationalUnit -Identity 'OU=Valmentajat,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi').Name
    $OU_ValmentajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Valmentajat,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi').DistinguishedName

    if ($OU_Valmentajat -eq "Valmentajat")
        {
        Write-Host "OU nimeltään $OU_Valmentajat on olemassa polussa: $OU_ValmentajatPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_Valmentajat ei löydetty polusta: $OU_ValmentajatPolku" -ForegroundColor Red
    }

    #IT-tuki OU tarkistus
    $OU_ittuki = (Get-ADOrganizationalUnit -Identity 'OU=IT-tuki,DC=taitajat,DC=fi').Name
    $OU_ittukiPolku = (Get-ADOrganizationalUnit -Identity 'OU=IT-tuki,DC=taitajat,DC=fi').DistinguishedName

    if ($OU_ittuki -eq "IT-tuki")
        {
        Write-Host "OU nimeltään $OU_ittuki on olemassa polussa: $OU_ittukiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_ittuki ei löydetty polusta $OU_ittukiPolku" -ForegroundColor Red
    }

    #Riihimäki ryhmien tarkistus
    $ryhma_rmkDevices =  (Get-ADGroup -Identity "Napalmi").Name
    $ryhma_rmkDevicesPolku =  (Get-ADGroup -Identity "Napalmi").DistinguishedName

    if ($ryhma_rmkDevices -eq "Napalmi")
        {
        Write-Host "Ryhmä nimeltään $ryhma_rmkDevices on olemassa polussa: $ryhma_rmkDevicesPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_rmkDevices ei löydetty polusta $ryhma_rmkDevicesPolku" -ForegroundColor Red
    }

    $ryhma_rmkUsers =  (Get-ADGroup -Identity "ICT-asentajat").Name
    $ryhma_rmkUsersPolku =  (Get-ADGroup -Identity "ICT-asentajat").DistinguishedName

    if ($ryhma_rmkUsers -eq "ICT-asentajat")
        {
        Write-Host "Ryhmä nimeltään $ryhma_rmkUsers on olemassa polussa: $ryhma_rmkUsersPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_rmkUsers ei löydetty polusta: $ryhma_rmkUsersPolku" -ForegroundColor Red
    }

    #Turku ryhmien tarkistus
    $ryhma_turkuDevices =  (Get-ADGroup -Identity "Jimms").Name
    $ryhma_turkuDevicesPolku =  (Get-ADGroup -Identity "Jimms").DistinguishedName

    if ($ryhma_turkuDevices -eq "Jimms")
        {
        Write-Host "Ryhmä nimeltään $ryhma_turkuDevices on olemassa polussa: $ryhma_turkuDevicesPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_turkuDevices ei löydetty polusta $ryhma_turkuDevicesPolku" -ForegroundColor Red
    }

    $ryhma_turkuUsers =  (Get-ADGroup -Identity "datanomit").Name
    $ryhma_turkuUsersPolku =  (Get-ADGroup -Identity "datanomit").DistinguishedName

    if ($ryhma_turkuUsers -eq "datanomit")
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

    #Jallu käyttäjä
    $kayttaja_aleksi = (Get-ADUser -identity Jallu).SamAccountName
    $kayttaja_aleksiPolku = (Get-ADUser -identity Jallu).distinguishedName

    if ($kayttaja_aleksi -eq "Jallu")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_aleksi on olemassa polussa: $kayttaja_aleksiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_aleksi ei löydetty polusta: $kayttaja_aleksiPolku" -ForegroundColor Red
    }

    #TA099 tietokone
    $tietokone_ta099 = (Get-ADComputer -Filter * -SearchBase "OU=Valmentajat,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi").Name
    $tietokone_ta099Polku = (Get-ADComputer -Filter * -SearchBase "OU=Valmentajat,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi").DistinguishedName

    if ($tietokone_ta099 -eq "tk-ta-099-tehopc")
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
    $mattiRyhma = (Get-ADGroupMember -Identity "ICT-asentajat" | Where-Object {$_.name -eq "Matti"}).name
    if ($mattiRyhma -eq "Matti")
        {
        Write-Host "Käyttäjä nimeltään $mattiRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mattiRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    $mikkoRyhma = (Get-ADGroupMember -Identity "ICT-asentajat" | Where-Object {$_.name -eq "Mikko"}).name
    if ($mikkoRyhma -eq "Mikko")
        {
        Write-Host "Käyttäjä nimeltään $mikkoRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mikkoRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    $mariaRyhma = (Get-ADGroupMember -Identity "datanomit" | Where-Object {$_.name -eq "Maria"}).name
    if ($mariaRyhma -eq "Maria")
        {
        Write-Host "Käyttäjä nimeltään $mariaRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mariaRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    Write-Host "Delegoithan oikeuksia Juholle?" -ForegroundColor Yellow
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

    if ($dhcpScope -eq "192.168.0.0")
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
    if ($dhcpAlkuOsoite -eq "192.168.0.50")
        {
        Write-Host "DHCP jakoalue alkaa osoitteesta $dhcpAlkuOsoite" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalue alkaa osoitteesta $dhcpAlkuOsoite ja on väärin" -ForegroundColor Red
    }

    #DHCP loppuosoite
    $dhcpLoppuOsoite = (Get-DhcpServerv4Scope).EndRange.IPAddressToString
    if ($dhcpLoppuOsoite -eq "192.168.0.90")
        {
        Write-Host "DHCP jakoalue loppuu osoitteesta $dhcpLoppuOsoite" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalue loppuu osoitteesta $dhcpLoppuOsoite ja on väärin" -ForegroundColor Red
    }

    #DHCP exclusion alkuosoite
    $dhcpExclAlku = (Get-DhcpServerv4ExclusionRange).StartRange.IPAddressToString
    if ($dhcpExclAlku -eq "192.168.0.70")
        {
        Write-Host "DHCP jakoalueen poissulku (exclusion) alkaa osoitteesta $dhcpExclAlku" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalueen poissulku (exclusion) alkaa osoitteesta $dhcpExclAlku ja on väärin" -ForegroundColor Red
    }

    #DHCP exclusion loppuosoite
    $dhcpExclLoppu = (Get-DhcpServerv4ExclusionRange).EndRange.IPAddressToString
    if ($dhcpExclLoppu -eq "192.168.0.80")
        {
        Write-Host "DHCP jakoalueen poissulku (exclusion) loppuu osoitteeseen $dhcpExclLoppu" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalueen poissulku (exclusion) loppuu osoitteeseen $dhcpExclLoppu ja on väärin" -ForegroundColor Red
    }

    #DHCP vuokra aika
    $dhcpVuokra = (Get-DhcpServerv4Scope).LeaseDuration.Hours
    if ($dhcpVuokra -eq "12")
        {
        Write-Host "DHCP jakoalueen vuokraaika on: $dhcpVuokra tuntia" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalueen vuokraaika on: $dhcpVuokra tuntia, joka on väärin" -ForegroundColor Red
    }

    #DHCP GW
    $dhcpGW = (Get-DhcpServerv4OptionValue -ScopeId 192.168.0.0 | Where-Object {$_.OptionId -eq "3"}).Value
    if ($dhcpGW -eq "192.168.0.1")
        {
        Write-Host "DHCP jakaa oletusyhdyskäytävää: $dhcpGW" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakaa oletusyhdyskäytävää: $dhcpGW, joka on väärin" -ForegroundColor Red
    }
    #DHCP DNS
    $dhcpDNS = (Get-DhcpServerv4OptionValue -ScopeId 192.168.0.0 | Where-Object {$_.OptionId -eq "6"}).Value
    if ($dhcpDNS -eq "192.168.0.10")
        {
        Write-Host "DHCP jakaa DNS-osoitetta: $dhcpDNS" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakaa DNS-osoitetta: $dhcpDNS, joka on väärin" -ForegroundColor Red
    }

    #DHCP varaus
    $dhcpVarausIP = (Get-DhcpServerv4Reservation -ScopeId 192.168.0.0).IPAddress.IPAddressToString
    if ($dhcpVarausIP -eq "192.168.0.91")
        {
        Write-Host "Varaus on tehty IP-osoitteelle $dhcpVarausIP" -ForegroundColor Green
        }
    else {
        Write-Host "Varausta ei ole tehty IP-osoitteelle $dhcpVarausIP" -ForegroundColor Red
    }
    $dhcpVarausMAC = (Get-DhcpServerv4Reservation -ScopeId 192.168.0.0).ClientId
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
    if ($dhcpAutorisointi -eq "192.168.0.10")
        {
        Write-Host "DHCP palvelu on autorisoitu" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP palvelua ei ole autorisoitu" -ForegroundColor Red
    }

    $dhcpTestiIP = (Get-DhcpServerv4Lease -ScopeId 192.168.0.0 | Where-Object {$_.HostName -like "taitaja-ta-001.taitajat.fi"}).IPAddress.IPAddressToString
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
    $dhcpBackupPolku = Test-Path "C:\DHCP_backup\DhcpCfg"
    if ($dhcpBackupPolku -eq "True")
        {
        Write-Host "DHCP varmuuskopio (backup) löytyy sijainnista C:\DHCP_backup\DhcpCfg" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP varmuuskopio (backup) ei löytynyt sijainnista C:\DHCP_backup\DhcpCfg" -ForegroundColor Red
    }
    } 

    '5' {
    Write-Host "================ Tarkistetaan tehtävä 005 ================"

    #Oikeuksien delegointi ja kirjautumisajat
    Write-Host "Olethan delegoinut oikeuksia Juholle?" -ForegroundColor Yellow
    Write-Host "Onhan työasema liitetty toimialueelle?" -ForegroundColor Yellow

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
    if ($pekkaTietokone -eq "taitaja-ta-001")
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
    if ($jalmariKayttajanimi -eq "jalmari.valimaa@taitajat.fi")
        {
        Write-Host "Käyttäjän kirjautumistunnus on $jalmariKayttajanimi" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän kirjautumistunnus on $jalmariKayttajanimi eli väärin" -ForegroundColor Red
    }

    #Tietokone tili oikea polku
    $tietokone_ta001 = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi").Name
    $tietokone_ta001Polku = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=taitajat,DC=taitajat,DC=fi").DistinguishedName

    if ($tietokone_ta001 -eq "taitaja-ta-001")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta001 on olemassa polussa: $tietokone_ta001Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään taitaja-ta-001 ei löytynyt oikeasta polusta" -ForegroundColor Red
    }

    #Tietokone tili ryhmäjäsenyys
    $tietokoneRyhmaJasen = (Get-ADPrincipalGroupMembership (Get-ADComputer "taitaja-ta-001") | select-object name | Where-Object {$_.Name -eq "Napalmi"}).name
    if ($tietokoneRyhmaJasen -eq "Napalmi")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta001 ryhmässä: $tietokoneRyhmaJasen" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään $tietokone_ta001 ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #administrator tili nimi vaihdettu joksikin muuksi
    $ErrorActionPreference = "SilentlyContinue"
    $kayttaja_administrator = (Get-ADUser -identity administrator -ErrorAction SilentlyContinue).SamAccountName 
    $kayttaja_administratorPolku = (Get-ADUser -identity administrator -ErrorAction SilentlyContinue).DistinguishedName

    if ($kayttaja_administrator -eq "administrator")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_administrator on olemassa polussa: $kayttaja_administratorPolku" -ForegroundColor Red
        }
    else {
        Write-Host "Käyttäjää nimeltään administrator ei löydetty " -ForegroundColor Green
    }

    #taitaja_admin käyttäjä
    $kayttaja_taitaja_admin = (Get-ADUser -identity taitaja_admin).SamAccountName
    $kayttaja_taitaja_adminPolku = (Get-ADUser -identity taitaja_admin).distinguishedName

    if ($kayttaja_taitaja_admin -eq "taitaja_admin")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_taitaja_admin on olemassa polussa: $kayttaja_taitaja_adminPolku eli Administrator tili on luultavasti nimetty oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_taitaja_admin ei löydetty polusta: $kayttaja_taitaja_adminPolku eli Administrator tiliä ei ole luultavasti nimetty oikein" -ForegroundColor Red
    }

    } 

    '6' {
    Write-Host "================ Tarkistetaan tehtävä 006 ================"

    Write-Host "GPO/ryhmäkäytäntöjen tarkistuksen aikana C:\ aseman juureen luodaan useita .XML tyyppisiä tiedostoja. Niistä ei tarvitse murehtia!" -ForegroundColor Yellow

    #GPO Central Store sijainti
    $CentralStorekansioTarkistus = Test-Path -Path "C:\toimialue\SYSVOL\sysvol\taitajat.fi\Policies\PolicyDefinitions"
    if ($CentralStorekansioTarkistus -eq "True")
        {
        Write-Host "Vaikuttaisi siltä, että Central Store on käytössä polussa C:\toimialue\SYSVOL\sysvol\taitajat.fi\Policies\PolicyDefinitions" -ForegroundColor Green
        }
    else {
        Write-Host "Näyttää siltä, että Central Store ei ole käytössä. Skripti katsoo löytyykö se polusta C:\toimialue\SYSVOL\sysvol\taitajat.fi\Policies\PolicyDefinitions. Voiko se olla jossain muualla?" -ForegroundColor Red
    }

    #GPO Default domain policy
    $DefaultDomainPolicy = "Default Domain Policy"
    Get-GPOReport -Name $DefaultDomainPolicy -ReportType XML -Path C:\DefaultDomainPolicy.xml
    $DefaultDomainPolicyGPOpituus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern 'Name>MinimumPasswordLength<' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>8<"
    if ($DefaultDomainPolicyGPOpituus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy minimi salasana määritys on väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy minimi salasana määritys on oikein" -ForegroundColor Green
    }

    $DefaultDomainPolicyGPOlukitus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern 'Name>LockoutBadCount<' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>5<"
    if ($DefaultDomainPolicyGPOlukitus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy tilin lukitus säännöt ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy tilin lukitus säännöt ovat oikein" -ForegroundColor Green
    }

    #GPO estä Control panel
    $BlockControlPanel = "TurkuBlockControlPanel"
    Get-GPOReport -Name $BlockControlPanel -ReportType XML -Path C:\BlockControlPanel.xml
    $BlockControlPanelGPO = Select-String -path C:\BlockControlPanel.xml -Pattern 'Name>Prohibit access to Control Panel and PC settings<' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "State>Enabled<"
    if ($BlockControlPanelGPO -eq $null)
        {
        Write-Host "GPOn $BlockControlPanel sääntö on väärin eli Ohjauspaneelia ei ole estetty" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $BlockControlPanel sääntö on oikein eli Ohjauspaneeliin ei ole pääsyä" -ForegroundColor Green
    }

    #Onko verkkojako Softat olemassa?
    $netshare_Softat = Test-Path \\taitaja-srv-001\Softat
    if ($netshare_Softat -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\taitaja-srv-001\Softat" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\taitaja-srv-001\Softat" -ForegroundColor Red
    }

    #Chrome sovelluksen tarkistaminen
    $chromeSovellusTarkistus = Get-ChildItem -Path C:\Softat\ -Recurse -Filter *chrome*.msi
    if ($chromeSovellusTarkistus -eq $null)
        {
        Write-Host "Vaikuttaa siltä, että Chromen asennus pakettia ei löydy sijainnista C:\Softat\ ja/tai se ei ole tyypiltään .MSI tiedosto" -ForegroundColor Red
        }
    else {
        Write-Host "Vaikuttaa siltä, että Chromen asennus paketti löytyy sijainnista C:\Softat\ ja se on tyypiltään .MSI tiedosto" -ForegroundColor Green
    }

    #GPO asenna Chrome
    $ChromeAsennus = "ChromeAsennus"
    Get-GPOReport -Name $ChromeAsennus -ReportType XML -Path C:\ChromeAsennus.xml
    $ChromeAsennusGPO = Select-String -path C:\ChromeAsennus.xml -Pattern 'Name>Google Chrome<' -SimpleMatch -Context 0, 12 | Out-String -Stream | Select-String -Pattern " AutoInstall>true<"
    if ($ChromeAsennusGPO -eq $null)
        {
        Write-Host "GPOn $ChromeAsennus sääntö näyttäisi olevan väärin tehty." -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $ChromeAsennus sääntö on oikein tehty" -ForegroundColor Green
    }

    #GPO Chrome Assigned
    $ChromeAsennusTyyppiGPO = Select-String -path C:\ChromeAsennus.xml -Pattern 'DeploymentType>Install'
    if ($ChromeAsennusTyyppiGPO -eq $null)
        {
        Write-Host "GPOn $ChromeAsennus sääntö on tehty niin, että se ei tule käyttäjien manuaalisesti asennettavaksi. Onhan se tyypiltään Assigned?" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $ChromeAsennus sääntö on niin, että se on tyypiltään Assigned" -ForegroundColor Green
    }

    #GPO Edge
    $EdgeHomeButton = "EdgeHomeButton"
    Get-GPOReport -Name $EdgeHomeButton -ReportType XML -Path C:\EdgeHomeButton.xml
    $EdgeHomeButtonGPO = Select-String -path C:\EdgeHomeButton.xml -Pattern 'Name>Show Home button on toolbar<' -SimpleMatch -Context 0, 12 | Out-String -Stream | Select-String -Pattern "State>Enabled"
    if ($EdgeHomeButtonGPO -eq $null)
        {
        Write-Host "GPOn $EdgeHomeButton sääntö näyttäisi olevan väärin tehty." -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $EdgeHomeButton sääntö on oikein tehty" -ForegroundColor Green
    }

    Write-Host "gpudate /force komennolla saadaan pakotettua ryhmäkäytäntöjen päivitys työasemalla" -ForegroundColor Yellow
    Write-Host "Olethan testannut ryhmäkäytäntöjen toiminnan työasemalla?" -ForegroundColor Yellow


    #GPO backup sijainti
    $GPOkansioTarkistus = Test-Path -Path "C:\GPO_backup"
    if ($GPOkansioTarkistus -eq "True")
        {
        Write-Host "C:\GPO_backup kansio löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "C:\GPO_backup kansiota ei löydy" -ForegroundColor Red
    }

    #GPO Backup sisältö
    $GPOkansioSisalto = Get-ChildItem "C:\GPO_backup"
    if ($GPOkansioSisalto -eq $null)
        {
        Write-Host "Kansiossa C:\GPO_backup\ ei ole mitään sisältöä eli varmuuskopioita ei todennäköisesti ole otettu sinne" -ForegroundColor Red
        }
    else {
        Write-Host "Kansiossa C:\GPO_backup\ on jotain sisältöä eli varmuuskopiot on todennäköisesti otettu sinne" -ForegroundColor Green
    }

    $GPOLinkki = (Get-GPInheritance -Target "OU=Käyttäjät,OU=Turku,OU=Taitajat,DC=taitajat,DC=fi").GpoLinks
    if ($GPOLinkki -eq $null)
        {
        Write-Host "GPO TurkuBlockControlPanel on edelleen linkitetty OU:hun Turun Käyttäjät" -ForegroundColor Red
        }
    else {
        Write-Host "GPO TurkuBlockControlPanel linkki on poistettu OU:sta Turun Käyttäjät" -ForegroundColor Green
    }

    #GPO periytyvyys
    $GPOPeriytyvyys = (Get-GPInheritance -Target "OU=Valmentajat,OU=Riihimäki,OU=Taitajat,DC=taitajat,DC=fi").GpoInheritanceBlocked
    if ($GPOPeriytyvyys -eq "True")
        {
        Write-Host "Valmentajat OU:n GPO:iden periytyvyys on estetty" -ForegroundColor Green
        }
    else {
        Write-Host "Valmentajat OU:n GPO periytyvyys ei ole estetty" -ForegroundColor Red
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

    #GPO Default domain policy
    $DefaultDomainPolicy = "Default Domain Policy"
    Get-GPOReport -Name $DefaultDomainPolicy -ReportType XML -Path C:\DefaultDomainPolicy.xml
    $DefaultDomainPolicyValvonta = Select-String -path C:\DefaultDomainPolicy.xml -Pattern 'Name>AuditLogonEvents<' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SuccessAttempts>true<"
    if ($DefaultDomainPolicyValvonta -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy ei valvo kirjautumisyrityksiä" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy valvoo kirjautumisyrityksiä" -ForegroundColor Green
    }

    #GPO Remote Desktop
    $EnableRemoteDesktop = "EnableRemoteDesktop"
    Get-GPOReport -Name $EnableRemoteDesktop  -ReportType XML -Path C:\EnableRemoteDesktop.xml
    $EnableRemoteDesktop1 = Select-String -path C:\EnableRemoteDesktop.xml -Pattern 'Allow users to connect remotely by using Remote Desktop Services' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "<q2:State>Enabled<"
    if ($EnableRemoteDesktop1 -eq $null)
        {
        Write-Host "GPO $EnableRemoteDesktop Remote Desktop ei ole otettu käyttöön" -ForegroundColor Red
        }
    else {
        Write-Host "GPO $EnableRemoteDesktop Remote Desktop on otettu käyttöön" -ForegroundColor Green
    }

    $EnableRemoteDesktopPalomuuri = Select-String -path C:\EnableRemoteDesktop.xml -Pattern 'Svc>termservice<' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "LPort>3389<"
    if ($EnableRemoteDesktopPalomuuri -eq $null)
        {
        Write-Host "GPO $EnableRemoteDesktop Remote Desktop palomuuri sääntöä ei ole tehty" -ForegroundColor Red
        }
    else {
        Write-Host "GPO $EnableRemoteDesktop Remote Desktop palomuuri sääntö on tehty" -ForegroundColor Green
    }

    #GPO Remote Powershell
    $EnableRemotePowershell = "EnableRemotePowershell"
    Get-GPOReport -Name $EnableRemotePowershell  -ReportType XML -Path C:\EnableRemotePowershell.xml
    $EnableRemotePowershell1 = Select-String -path C:\EnableRemotePowershell.xml -Pattern 'Allow remote server management through WinRM' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "State>Enabled<"
    if ($EnableRemotePowershell1 -eq $null)
        {
        Write-Host "GPO $EnableRemotePowershell WinRM kautta hallintaa ei ole sallittu" -ForegroundColor Red
        }
    else {
        Write-Host "GPO $EnableRemotePowershell WinRM kautta hallinta on sallittu" -ForegroundColor Green
    }

    Get-GPOReport -Name $EnableRemotePowershell  -ReportType XML -Path C:\EnableRemotePowershell.xml
    $EnableRemotePowershell2 = Select-String -path C:\EnableRemotePowershell.xml -Pattern 'Properties startupType="AUTOMATIC" serviceName="WinRM"'
    if ($EnableRemotePowershell2 -eq $null)
        {
        Write-Host "GPO $EnableRemotePowershell WinRM ei käynnisty automaattisesti kun kone käynnistyy" -ForegroundColor Red
        }
    else {
        Write-Host "GPO $EnableRemotePowershell WinRM käynnistyy automaattisesti kun kone käynnistyy" -ForegroundColor Green
    }

    Get-GPOReport -Name $EnableRemotePowershell  -ReportType XML -Path C:\EnableRemotePowershell.xml
    $EnableRemotePowershell3 = Select-String -path C:\EnableRemotePowershell.xml -Pattern 'Name>WinRM<' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "StartupMode>Automatic<"

    if ($EnableRemotePowershell3 -eq $null)
        {
        Write-Host "GPO $EnableRemotePowershell WinRM (WS-Management) ei käynnisty automaattisesti" -ForegroundColor Red
        }
    else {
        Write-Host "GPO $EnableRemotePowershell WinRM (WS-Management) käynnistyy automaattisesti kun kone käynnistyy" -ForegroundColor Green
    }

    Get-GPOReport -Name $EnableRemotePowershell  -ReportType XML -Path C:\EnableRemotePowershell.xml
    $EnableRemotePowershell4 = Select-String -path C:\EnableRemotePowershell.xml -Pattern 'LPort>5985<'

    if ($EnableRemotePowershell4 -eq $null)
        {
        Write-Host "GPO $EnableRemotePowershell Remote Powershell ei ole sallittu palomuurista" -ForegroundColor Red
        }
    else {
        Write-Host "GPO $EnableRemotePowershell Remote Powershell on sallittu palomuurista" -ForegroundColor Green
    }

    #Testatan Remote Powershell toimivuus
    $TestRemotePowershell = (New-PSSession -ComputerName taitaja-ta-001).State
    if ($TestRemotePowershell -eq $null)
        {
        Write-Host "Remote Powershell yhteys tietokoneeseen taitaja-ta-001 ei onnistunut" -ForegroundColor Red
        }
    else {
        Write-Host "Remote Powershell yhteys tietokoneeseen taitaja-ta-001 onnistui" -ForegroundColor Green
    }

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
    $IIS_sisalto = Get-Content "C:\webbiserveri\index.html"
 
    if ($IIS_sisalto -eq "Taitaja nettisivu")
        {
        Write-Host "C:\webbiserveri\index.html tiedoston sisältö on oikein" -ForegroundColor Green
        }
    else {
        Write-Host "C:\webbiserveri\index.html tiedoston sisältö ei ole oikein" -ForegroundColor Red
    }

    Write-Host "Olethan testannut sivuston toiminnan työasemalta käsin?" -ForegroundColor Yellow

    #Sivun sisältö
    $IIStiedostot_sisalto = Get-Content "C:\webbiserveri\tiedostot\VIP.txt"
 
    if ($IIStiedostot_sisalto -eq "Petja")
        {
        Write-Host "C:\webbiserveri\tiedostot\VIP.txt tiedoston sisältö on oikein" -ForegroundColor Green
        }
    else {
        Write-Host "C:\webbiserveri\tiedostot\VIP.txt tiedoston sisältö ei ole oikein" -ForegroundColor Red
    }

    #IIS directory browsing
    $IIS_directoryBrowsing = (Get-WebConfigurationProperty -filter /system.webServer/directoryBrowse -name enabled -PSPath 'IIS:\Sites\Default Web Site').Value
    if ($IIS_directoryBrowsing -eq "True")
        {
        Write-Host "Sivuston directory browsing on päällä" -ForegroundColor Green
        }
    else {
        Write-Host "Sivuston directory browsing ei ole päällä" -ForegroundColor Red
    }

    Write-Host "Olethan testannut sivuston toiminnan työasemalta käsin? Eli myös Directory Browsing toimii?" -ForegroundColor Yellow

    #IIS https
    $IIShttps = (Get-IISSiteBinding "Default Web Site") | Where-Object -Property Protocol -eq https
    if ($IIShttps -eq $null)
        {
        Write-Host "IIS ei ole käytössä HTTPS" -ForegroundColor Red
        }
    else {
        Write-Host "IIS on käytössä HTTPS" -ForegroundColor Green
    }

    #443 portin testaaminen
    $portti443Testi = (Test-NetConnection 192.168.0.10 -Port 443).TcpTestSucceeded

    if ($portti443Testi -eq "True")
        {
        Write-Host "Yhteyttä testattu 192.168.0.10 porttiin 443 - onnistui" -ForegroundColor Green
        }
    else {
        Write-Host "Yhteyttä testattu 192.168.0.10 porttiin 443 - ei onnistunut" -ForegroundColor Red
    }
    
    #DNS forward zone
    $DNS_fwZone = (Get-DnsServerZone | Where-Object {$_.ZoneName -eq "taitajasivu.local"}).ZoneName
    if ($DNS_fwZone -eq "taitajasivu.local")
        {
        Write-Host "DNS alue $DNS_fwZone löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "DNS aluetta $DNS_fwZone ei löydetty" -ForegroundColor Red
    }

    #A tietue
    $DNS_aTietue = (Get-DnsServerResourceRecord -ZoneName "taitajasivu.local" | Where-Object {$_.RecordType -eq "A"}).RecordData.IPv4Address.IPAddressToString
    if ($DNS_aTietue -eq "192.168.0.10")
        {
        Write-Host "DNS alueelta löytyy oikea A-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa A-tietuetta" -ForegroundColor Red
    }

    #CNAME tietue
    $DNS_CNAMETietue = (Get-DnsServerResourceRecord -ZoneName "taitajasivu.local" | Where-Object {$_.RecordType -eq "CNAME"}).HostName
    if ($DNS_CNAMETietue -eq "www")
        {
        Write-Host "DNS alueelta löytyy oikea www CNAME-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa www CNAME-tietuetta" -ForegroundColor Red
    }

    #CNAME tietue
    $DNS_CNAMETietue1 = (Get-DnsServerResourceRecord -ZoneName "taitajasivu.local" | Where-Object {$_.RecordType -eq "CNAME"}).HostName
    if ($DNS_CNAMETietue1 -eq "hyria")
        {
        Write-Host "DNS alueelta löytyy oikea hyria CNAME-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa hyria CNAME-tietuetta" -ForegroundColor Red
    }

    Write-Host "Olethan testannut sivuston/DNS toiminnan työaseman selaimen sekä nslookup työkalun kautta?" -ForegroundColor Yellow

    #Reverse Lookupzone
    $DNS_reverseZone = (Get-DnsServerZone | Where-Object {$_.ZoneName -eq "0.168.192.in-addr.arpa"}).ZoneName
    if ($DNS_reverseZone -eq "0.168.192.in-addr.arpa")
        {
        Write-Host "DNS alue $DNS_reverseZone löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "DNS aluetta $DNS_reverseZone ei löydetty" -ForegroundColor Red
    }

    #PTR tietue
    $DNS_ptrTietue = (Get-DnsServerResourceRecord -ZoneName "0.168.192.in-addr.arpa" | Where-Object {$_.RecordType -eq "ptr"}).HostName
    if ($DNS_ptrTietue -eq "10")
        {
        Write-Host "DNS alueelta löytyy oikea PTR-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa PTR-tietuetta" -ForegroundColor Red
    }

    Write-Host "Olethan testannut DNS Reversen toiminnan työaseman nslookup työkalun kautta?" -ForegroundColor Yellow

    #DNS forwarders
    $DNS_forwarders = (Get-DnsServerForwarder).IPAddress.IPAddressToString
    if ($DNS_forwarders -eq "8.8.8.8")
        {
        Write-Host "DNS forwarder osoite on $DNS_forwarders eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "DNS forwarder osoite on $DNS_forwarders eli väärin" -ForegroundColor Red
    }

    Write-Host "Kuunteleehan DNS-palvelin vain IPv4 osoitettaan?" -ForegroundColor Yellow

    #DNS scavenging
    $DNS_scavenging = (Get-DnsServerScavenging).ScavengingInterval.TotalDays
    if ($DNS_scavenging -eq "4")
        {
        Write-Host "DNS scavenging aika on $DNS_scavenging päivää eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "DNS scavenging aika ei ole $DNS_scavenging päivää $DNS_scavenging eli väärin" -ForegroundColor Red
    }  

    Write-Host "Muista vielä varmistaa kaiken toiminta!" -ForegroundColor Yellow

    } 

    '9' {
    Write-Host "================ Tarkistetaan tehtävä 009 ================"

    #Onko verkkojako JakoKansio olemassa?
    $netshare_JakoKansio = Test-Path \\taitaja-srv-001\jakokansio
    if ($netshare_JakoKansio -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\taitaja-srv-001\jakokansio" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\taitaja-srv-001\jakokansio" -ForegroundColor Red
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

    #Onko verkkojaon Listattu kunnossa jakokansio
    $netshare_jakokansioListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "jakokansio"}).DistinguishedName
    if ($netshare_jakokansioListattu -eq "CN=jakokansio,OU=taitajat,DC=taitajat,DC=fi")
        {
        Write-Host "Verkkojako jakokansio on listattu toimialueeseen polkuun $netshare_jakokansioListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojako jakokansio ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    #fsrm txt estetty
    $fsrm_txt = ((get-fsrmfilegroup) | Where-Object {$_.Name -eq "txt_blocked"}).IncludePattern
    if ($fsrm_txt -eq "*.txt")
        {
        Write-Host "File Screen Group on olemassa, joka estää *.txt tyyppiset tiedostot" -ForegroundColor Green
        }
    else {
        Write-Host "Oikeaa File Screen Groupia ei löydetty" -ForegroundColor Red
    }

    #fsrm onko oikeassa jaossa rajoitus
    $fsrm_rajoitus = (Get-FsrmFileScreen | Where-Object {$_.Path -eq "C:\JakoKansio"}).IncludeGroup
    $fsrm_polku = (Get-FsrmFileScreen | Where-Object {$_.Path -eq "C:\JakoKansio"}).Path
    if ($fsrm_rajoitus -eq "txt_blocked")
        {
        Write-Host "Rajoitus on tehty oikeaan verkkojakoon $fsrm_polku" -ForegroundColor Green
        }
    else {
        Write-Host "Rajoitus on tehty väärään verkkojakoon, sen pitäisi olla polussa $fsrm_polku" -ForegroundColor Red
    }

    #fsrm onko quota tehty JakoKansio
    $fsrm_quota = ((Get-FsrmQuotaTemplate) | Where-Object {$_.Name -eq "2mb_quota"}).Size
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
    $netshare_yhteinen = Test-Path \\taitaja-srv-001\yhteinen
    if ($netshare_yhteinen -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\taitaja-srv-001\yhteinen" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\taitaja-srv-001\yhteinen" -ForegroundColor Red
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
    $fsrm_quota2 = ((Get-FsrmQuotaTemplate) | Where-Object {$_.Name -eq "20gb_quota"}).Size
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

    Write-Host "Skripti ei osaa katsoa onko Quotassa ilmoitusta jos 25% ylittyy. Olethan tehnyt sen?" -ForegroundColor Yellow

    #fsrm ps1 estetty
    $fsrm_ps1 = ((get-fsrmfilegroup) | Where-Object {$_.Name -eq "script_blocked"}).IncludePattern
    if ($fsrm_ps1 -eq "*.ps1")
        {
        Write-Host "File Screen Group on olemassa, joka estää *.ps1 tyyppiset tiedostot" -ForegroundColor Green
        }
    else {
        Write-Host "Oikeaa File Screen Groupia ei löydetty" -ForegroundColor Red
    }

    #fsrm onko oikeassa jaossa rajoitus
    $fsrm_rajoitusPS1 = (Get-FsrmFileScreen | Where-Object {$_.Path -eq "C:\yhteinen"}).IncludeGroup
    $fsrm_polkuPS1 = (Get-FsrmFileScreen | Where-Object {$_.Path -eq "C:\yhteinen"}).Path
    if ($fsrm_rajoitusPS1 -eq "script_blocked")
        {
        Write-Host "Rajoitus on tehty oikeaan verkkojakoon $fsrm_polkuPS1" -ForegroundColor Green
        }
    else {
        Write-Host "Rajoitus on tehty väärään verkkojakoon, sen pitäisi olla polussa $fsrm_polkuPS1" -ForegroundColor Red
    }

    #Onko verkkojaon Listattu kunnossa YhteinenJako
    $netshare_YhteinenListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "Yhteinen"}).DistinguishedName
    if ($netshare_YhteinenListattu -eq "CN=Yhteinen,OU=taitajat,DC=taitajat,DC=fi")
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

    $YhteinenPGPOPolku = Select-String -path C:\YhteinenP.xml -Pattern 'path="\\taitaja-SRV-001\Yhteinen"' -SimpleMatch
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

    #Onko verkkojaon oikeudet kunnossa kotikansio
    $netshare_kotikansioOikeudet = (Get-SmbShareAccess -Name "kotikansio" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_kotikansioOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa kotikansio ryhmällä Everyone on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa kotikansio ryhmällä Everyone ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #Onko verkkojaon Listattu kunnossa kotikansio
    $netshare_kotikansioListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "kotikansio"}).DistinguishedName
    if ($netshare_kotikansioListattu -eq "CN=kotikansio,OU=taitajat,DC=taitajat,DC=fi")
        {
        Write-Host "Verkkojako kotikansio on listattu toimialueeseen polkuun $netshare_kotikansioListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojako kotikansio ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    #Mikon kotikansio     
    $MikonKotikansio = (Get-ADUser -identity Mikko -properties *).HomeDirectory
    if ($MikonKotikansio -eq "\\taitaja-SRV-001\kotikansio\Mikko")
        {
        Write-Host "Mikkolle on määritetty kotikansio hakemistoon: \\taitaja-SRV-001\kotikansio\Mikko" -ForegroundColor Green
        }
    else {
        Write-Host "Mikkolle ei ole määritetty oikeaa kotikansiota hakemistoon \\taitaja-SRV-001\kotikansio\Mikko" -ForegroundColor Red
    }  

    #Mikon kotikansio asemakirjain    
    $MikonKotikansioKirjain = (Get-ADUser -identity Mikko -properties *).HomeDrive
    if ($MikonKotikansioKirjain -eq "H:")
        {
        Write-Host "Mikkolle on määritetty kotikansion asemakirjaimeksi H:" -ForegroundColor Green
        }
    else {
        Write-Host "Mikkolle ei ole määritetty kotikansion asemakirjaimeksi H:" -ForegroundColor Red
    }  

    Write-Host "Onhan sama toiminnallisuus lisätty myös muille Riihimäen käyttäjille ja toiminta testattu?" -ForegroundColor Yellow

    #tiedoston ja sisällön tarkistaminen
    $muistioTarkistus = Test-Path -Path C:\kotikansio\Mikko\muistio.txt
    if ($muistioTarkistus -eq "True")
        {
        Write-Host "muistio.txt tiedosto löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "muistio.txt tiedostoa ei löydy" -ForegroundColor Red
    }

    $muistioSisalto = Get-Content "C:\kotikansio\Mikko\muistio.txt"
    if ($muistioSisalto -eq "Kokous perjantaina")
        {
        Write-Host "muistio.txt tiedoston sisältö on oikein ja siinä lukee: $muistioSisalto" -ForegroundColor Green
        }
    else {
        Write-Host "muistio.txt tiedoston sisältö ei ole oikein" -ForegroundColor Red
    }

    Write-Host "Muista vielä varmistaa kaiken toiminta työasemalta käsin!" -ForegroundColor Yellow

    } 

    '10' {
    Write-Host "================ Tarkistetaan tehtävä 010 ================"

    #Print-Server asennettu
    $PrintServerAsennettu = (Get-WindowsFeature  | Where-Object {$_.Name -eq "Print-Server"}).InstallState
    if ($PrintServerAsennettu -eq "Installed")
        {
        Write-Host "Print-Server-rooli on asennettu palvelimelle" -ForegroundColor Green
        }
    else {
        Write-Host "Print-Server-roolia ei ole asennettu palvelimelle" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenPortti = (get-printer -Name "Taitajat testitulostin").PortName
    if ($TulostimenPortti -eq "LPT1:")
        {
        Write-Host "Tulostimen portti on $TulostimenPortti eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen portti on $TulostimenPortti eli väärin" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenAjuri = (get-printer -Name "Taitajat testitulostin").DriverName
    if ($TulostimenAjuri -eq "Microsoft PS Class Driver")
        {
        Write-Host "Tulostimen Ajuri on $TulostimenAjuri eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen Ajuri on $TulostimenAjuri eli väärin" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenNimi = (get-printer -Name "Taitajat testitulostin").Name
    if ($TulostimenNimi -eq "Taitajat testitulostin")
        {
        Write-Host "Tulostimen Nimi on $TulostimenNimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen Nimi on $TulostimenNimi eli väärin" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenJakonimi = (get-printer -Name "Taitajat testitulostin").ShareName
    if ($TulostimenJakonimi -eq "Taitajat testitulostin")
        {
        Write-Host "Tulostimen Jakonimi on $TulostimenJakonimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen Jakonimi on $TulostimenJakonimi eli väärin" -ForegroundColor Red
    }

    #Tulostimen GPO
    $TulostinGPO = (Get-GPO -Name "Taitajat testitulostin").DisplayName
    if ($TulostinGPO -like "Taitajat testitulostin")
        {
        Write-Host "Toimialueella on GPO, jonka nimi on Taitajat testitulostin" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole GPO:ta, jonka nimi olisi Taitajat testitulostin" -ForegroundColor Red
    }

    Write-Host "Joudut kuitenkin itse testaamaan ryhmäkäytännön eli GPO:n toiminnan" -ForegroundColor Yellow

    #Tulostimen lisäys AD:hen
    $TulostinListattu = (Get-AdObject -filter "objectCategory -eq 'printqueue'" -Properties PrinterName).PrinterName
    if ($TulostinListattu -eq "Taitajat testitulostin")
        {
        Write-Host "Tulostin on listattu toimialueelle nimellä $TulostinListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostinta ei ole listattu toimialueelle nimellä $TulostinListattu" -ForegroundColor Red
    }

    #Tulostimet OU
    $OU_tulostin = (Get-ADOrganizationalUnit -Identity 'OU=Tulostimet,OU=Taitajat,DC=Taitajat,DC=fi').Name
    $OU_tulostinPolku = (Get-ADOrganizationalUnit -Identity 'OU=Tulostimet,OU=Taitajat,DC=Taitajat,DC=fi').DistinguishedName

    if ($OU_tulostin -eq "Tulostimet")
        {
        Write-Host "OU nimeltään $OU_tulostin on olemassa polussa: $OU_tulostinPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_tulostin ei löydetty polusta: $OU_tulostinPolku" -ForegroundColor Red
    }

    #Tulostimen lisäys AD:hen
    $TulostinADssa = (Get-AdObject -filter "objectCategory -eq 'printqueue'" -Properties DistinguishedName).DistinguishedName
    if ($TulostinADssa -eq "CN=taitaja-SRV-001-Taitajat testitulostin,OU=Tulostimet,OU=Taitajat,DC=Taitajat,DC=fi")
        {
        Write-Host "Tulostin on oikeassa OU:ssa polussa: $TulostinADssa" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostin ei ole oikeassa OU:ssa polussa: $TulostinADssa" -ForegroundColor Red
    }

    Write-Host "Olethan testannut tulostimen toiminnan työasemalta käsin?" -ForegroundColor Yellow
    Write-Host "Toimihan Matille tehty rajoitus?" -ForegroundColor Yellow
    Write-Host "Yötulostimen toiminnan joudut itse testaamaan kokonaan!" -ForegroundColor Yellow

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
    $netshare_salaisetkansiotDomainAdminsOikeudet = (Get-SmbShareAccess -Name "salaisetkansiot" | Where-Object {$_.AccountName -eq "taitajat\Domain Admins"}).AccessRight
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
    $netshare_salaisetkansiotLeenaOikeudet = (Get-SmbShareAccess -Name "salaisetkansiot" | Where-Object {$_.AccountName -eq "taitajat\Leena"}).AccessControlType
    if ($netshare_salaisetkansiotLeenaOikeudet -eq "Deny")
        {
        Write-Host "Verkkojaossa salaisetkansiot käyttäjällä Leena on estetty oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa salaisetkansiot käyttäjällä Leena on väärät oikeudet" -ForegroundColor Red
    }	

    #Oikeuksien testaus Leenalla
    Write-Host "Testasithan, että oikeudet toimivat Leenalla?" -ForegroundColor Yellow
	
    #piilojako polun tarkistaminen
    $piilojakoPolku = "C:\piilojako"
    $piilojakoPolkuTarkistus = Test-Path -Path $piilojakoPolku

    if ($piilojakoPolkuTarkistus -eq "True")
        {
        Write-Host "Kansio $piilojakoPolku on olemassa" -ForegroundColor Green
        }
    else {
        Write-Host "Kansiota $piilojakoPolku ei ole olemassa" -ForegroundColor Red
    }

    #Onko verkkojako hidden$ olemassa?
    $netshare_hidden = Test-Path "\\taitaja-srv-001\hidden$"
    if ($netshare_hidden -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\taitaja-srv-001\hidden$" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\taitaja-srv-001\hidden$" -ForegroundColor Red
    }

    $waldoSisalto = Get-Content "C:\piilojako\waldo.txt"
    if ($waldoSisalto -eq "piilossa!")
        {
        Write-Host "waldo.txt tiedoston sisältö on oikein ja siinä lukee: $waldoSisalto" -ForegroundColor Green
        }
    else {
        Write-Host "waldo.txt tiedoston sisältö ei ole oikein" -ForegroundColor Red
    }

    Write-Host "Osaathan ottaa yhteyden piilotettuun verkkonjakoon työasemalta ja olet testannut toiminnan?" -ForegroundColor Yellow

    }

    '13' {
    Write-Host "================ Tarkistetaan tehtävä 013 ================"

    #srv2 toimialueella?
    $srv002 = (Get-ADComputer -Identity "taitaja-srv-002").Name
    if ($srv002 -eq "taitaja-srv-002")
        {
        Write-Host "Toimialueella on palvelin nimeltään $srv002" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole toista palvelinta nimeltään taitaja-srv-002" -ForegroundColor Red
    }

    #DHCP failoverin nimi
    $failoverName = (Get-DhcpServerv4Failover).Name
    if ($failoverName -eq "taitajat_dhcp_failover")
        {
        Write-Host "DHCP failoverin nimi on $failoverName" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP failoverin nimi on $failoverName joka on väärin" -ForegroundColor Red
    }

    #DHCP failover kumppanin nimi
    $failoverPartner = (Get-DhcpServerv4Failover).PartnerServer
    if ($failoverPartner -eq "taitaja-srv-002.taitajat.net")
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

    Write-Host "Olethan tarkistanut, että DHCP failover toimi, kun sammutit taitaja-srv-001 palvelimen? Eli 002 palvelin jakoi IP-asetuksia työasemille!" -ForegroundColor Yellow
    
 }
 }   

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause

 }
 until ($selection -eq 'q')

