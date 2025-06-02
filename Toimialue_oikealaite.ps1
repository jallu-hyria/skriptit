# Versio 1.00. 9.5.2025. Jalmari Valimaan tikkukirjaimilla koodattu
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/   
              

function Show-Menu {
    param (
        [string]$Title = 'Toimialueen hallinta'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "Vihreä teksti tarkoittaa, että tehtävän kohta on oikein tehty" -ForegroundColor Green
    Write-Host "Punainen teksti tarkoittaa, että tehtävän kohta on todennäköisesti väärin tehty" -ForegroundColor Red
    Write-Host "Keltainen teksti tarkoittaa, että tehtävän kohta oli sellainen jota skripti ei osaa tarkistaa" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "Paina '1' tarkistaaksesi tehtävän: 	     001 Toimialue oikeilla laitteilla" 
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

    #Tietokoneen tarkistaminen
    $tietokoneenNimi = $env:COMPUTERNAME

    if ($tietokoneenNimi -eq "hdesk-dc01")
        {
        Write-Host "Tietokoneen nimi on $tietokoneenNimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokoneen nimi on $tietokoneenNimi eli väärin" -ForegroundColor Red
    }

    #IP-asetusten tarkistaminen
    $IP_osoite = (Get-Netipaddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).IPAddress

    #IP-osoite
    if ($IP_osoite -eq "192.168.200.10")
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
    if ($oletusYhdyskaytava -eq "192.168.200.1")
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

    #Internet yhteyden testaaminen
    $yhteysTesti = (Test-Connection 8.8.8.8 -Quiet)

    if ($yhteysTesti -eq "True")
        {
        Write-Host "Yhteyttä testattu osoitteeseen 8.8.8.8, yhteys onnistui" -ForegroundColor Green
        }
    else {
        Write-Host "Yhteyttä testattu osoitteeseen 8.8.8.8, yhteys ei onnistunut" -ForegroundColor Red
    }



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

    #tarja käyttäjä
    $kayttaja_tarja = (Get-ADUser -identity tarja).SamAccountName
    $kayttaja_tarjaPolku = (Get-ADUser -identity tarja).distinguishedName

    if ($kayttaja_tarja -eq "tarja")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_tarja on olemassa polussa: $kayttaja_tarjaPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_tarja ei löydetty polusta: $kayttaja_tarjaPolku" -ForegroundColor Red
    }

	Write-Host "Olethan delegoinut oikeuksia tarjalle?" -ForegroundColor Yellow

    $ryhma_ictpalvelutUsers =  (Get-ADGroup -Identity "ICT-palvelut").Name
    $ryhma_ictpalvelutUsersPolku =  (Get-ADGroup -Identity "ICT-palvelut").DistinguishedName

    if ($ryhma_ictpalvelutUsers -eq "ICT-palvelut")
        {
        Write-Host "Ryhmä nimeltään $ryhma_ictpalvelutUsers on olemassa polussa: $ryhma_ictpalvelutUsersPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_ictpalvelutUsers ei löydetty polusta: $ryhma_ictpalvelutUsersPolku" -ForegroundColor Red
    }

    #Ryhmien jäsenyydet
    $tarjaRyhma = (Get-ADGroupMember -Identity "ICT-palvelut" | Where-Object {$_.name -eq "tarja"}).name
    if ($tarjaRyhma -eq "tarja")
        {
        Write-Host "Käyttäjä nimeltään $tarjaRyhma on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $tarjaRyhma ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #viivi käyttäjä
    $kayttaja_viivi = (Get-ADUser -identity viivi).SamAccountName
    $kayttaja_viiviPolku = (Get-ADUser -identity viivi).distinguishedName

    if ($kayttaja_viivi -eq "viivi")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_viivi on olemassa polussa: $kayttaja_viiviPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_viivi ei löydetty polusta: $kayttaja_viiviPolku" -ForegroundColor Red
    }

    #sampo käyttäjä
    $kayttaja_sampo = (Get-ADUser -identity sampo).SamAccountName
    $kayttaja_sampoPolku = (Get-ADUser -identity sampo).distinguishedName

    if ($kayttaja_sampo -eq "sampo")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_sampo on olemassa polussa: $kayttaja_sampoPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_sampo ei löydetty polusta: $kayttaja_sampoPolku" -ForegroundColor Red
    }

    #sampon tili disabloitu
    $sampoDisabloitu = (Get-ADUser -identity sampo -properties * | Select-Object Enabled).Enabled
    if ($sampoDisabloitu -eq $False)
        {
        Write-Host "Käyttäjän sampo tili on disabloitu" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän sampo tiliä ei ole disabloitu" -ForegroundColor Red
    }

    #DHCP Scope
    $dhcpScope = (Get-DhcpServerv4Scope).ScopeId.IPAddressToString

    if ($dhcpScope -eq "192.168.200.0")
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
    if ($dhcpAlkuOsoite -eq "192.168.200.100")
        {
        Write-Host "DHCP jakoalue alkaa osoitteesta $dhcpAlkuOsoite" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalue alkaa osoitteesta $dhcpAlkuOsoite ja on väärin" -ForegroundColor Red
    }

    #DHCP loppuosoite
    $dhcpLoppuOsoite = (Get-DhcpServerv4Scope).EndRange.IPAddressToString
    if ($dhcpLoppuOsoite -eq "192.168.200.250")
        {
        Write-Host "DHCP jakoalue loppuu osoitteesta $dhcpLoppuOsoite" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakoalue loppuu osoitteesta $dhcpLoppuOsoite ja on väärin" -ForegroundColor Red
    }

    #DHCP GW
    $dhcpGW = (Get-DhcpServerv4OptionValue -ScopeId 192.168.200.0 | Where-Object {$_.OptionId -eq "3"}).Value
    if ($dhcpGW -eq "192.168.200.1")
        {
        Write-Host "DHCP jakaa oletusyhdyskäytävää: $dhcpGW" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakaa oletusyhdyskäytävää: $dhcpGW, joka on väärin" -ForegroundColor Red
    }
    #DHCP DNS
    $dhcpDNS = (Get-DhcpServerv4OptionValue -ScopeId 192.168.200.0 | Where-Object {$_.OptionId -eq "6"}).Value
    if ($dhcpDNS -eq "192.168.200.10")
        {
        Write-Host "DHCP jakaa DNS-osoitetta: $dhcpDNS" -ForegroundColor Green
        }
    else {
        Write-Host "DHCP jakaa DNS-osoitetta: $dhcpDNS, joka on väärin" -ForegroundColor Red
    }

    #Testataan, että DHCP on jakanut IP-osoitteet työasemille
    $dhcpTesti_1IP_1 = (Get-DhcpServerv4Lease -ScopeId 192.168.200.0 | Where-Object {$_.HostName -like "hdesk-wks01.hyriadesk.net"}).IPAddress.IPAddressToString
    if ($dhcpTesti_1IP_1 -eq $null)
        {
        Write-Host "Laite nimeltään hdesk-wks01 ei ole saanut IP-osoitteita" -ForegroundColor Red
        }
    else {
		Write-Host "Laite nimeltään hdesk-wks01 on saanut IP-osoitteet" -ForegroundColor Green		
    }

    $dhcpTesti_1IP_2 = (Get-DhcpServerv4Lease -ScopeId 192.168.200.0 | Where-Object {$_.HostName -like "hdesk-wks02.hyriadesk.net"}).IPAddress.IPAddressToString
    if ($dhcpTesti_1IP_2 -eq $null)
        {
        Write-Host "Laite nimeltään hdesk-wks02 ei ole saanut IP-osoitteita" -ForegroundColor Red
        }
    else {
		Write-Host "Laite nimeltään hdesk-wks02 on saanut IP-osoitteet" -ForegroundColor Green		
    }

    #Tietokone tili oikea polku
    $tietokone_hdesk_wks01 = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").Name
    $tietokone_hdesk_wks01Polku = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").DistinguishedName

    if ($tietokone_hdesk_wks01 -eq "hdesk-wks01")
        {
        Write-Host "Tietokone nimeltään $tietokone_hdesk_wks01 on olemassa polussa: $tietokone_hdesk_wks01Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään hdesk-wks01 ei löytynyt oikeasta polusta" -ForegroundColor Red
    }

    #Tietokone tili oikea polku
    $tietokone_hdesk_wks02 = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net").Name
    $tietokone_hdesk_wks02Polku = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net").DistinguishedName

    if ($tietokone_hdesk_wks02 -eq "hdesk-wks02")
        {
        Write-Host "Tietokone nimeltään $tietokone_hdesk_wks02 on olemassa polussa: $tietokone_hdesk_wks02Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään hdesk-wks02 ei löytynyt oikeasta polusta" -ForegroundColor Red
    }

    Write-Host "Sampon yrittäessä kirjautua hänelle tulee ilmoitus, että tili on poistettu käytöstä eli disabloitu" -ForegroundColor Yellow

    Write-Host "GPO/ryhmäkäytäntöjen tarkistuksen aikana C:\ aseman juureen luodaan useita .XML tyyppisiä tiedostoja. Niistä ei tarvitse murehtia!" -ForegroundColor Yellow

    #GPO Default domain policy
    $DefaultDomainPolicy = "Default Domain Policy"
    Get-GPOReport -Name $DefaultDomainPolicy -ReportType XML -Path C:\DefaultDomainPolicy.xml
    $DefaultDomainPolicyGPOpituus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern '<q1:Name>MinimumPasswordLength</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>12<"
    if ($DefaultDomainPolicyGPOpituus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy minimi salasana määritys on väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy minimi salasana määritys on oikein" -ForegroundColor Green
    }

    #GPO asenna Firefox
    $SelainAsennus = "SelainAsennus"
    Get-GPOReport -Name $SelainAsennus -ReportType XML -Path C:\SelainAsennus.xml
    $SelainAsennusGPO = Select-String -path C:\SelainAsennus.xml -Pattern '<q1:Name>Mozilla Firefox' -SimpleMatch -Context 0, 12 | Out-String -Stream | Select-String -Pattern " <q1:AutoInstall>true<"
    if ($SelainAsennusGPO -eq $null)
        {
        Write-Host "GPOn $SelainAsennus sääntö näyttäisi olevan väärin tehty." -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $SelainAsennus sääntö on oikein tehty" -ForegroundColor Green
    }

    #GPO Firefox Assigned
    $SelainAsennusTyyppiGPO = Select-String -path C:\SelainAsennus.xml -Pattern 'DeploymentType>Install'
    if ($SelainAsennusTyyppiGPO -eq $null)
        {
        Write-Host "GPOn $SelainAsennus sääntö on tehty niin, että se ei tule käyttäjien manuaalisesti asennettavaksi. Onhan se tyypiltään Assigned?" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $SelainAsennus sääntö on niin, että se on tyypiltään Assigned" -ForegroundColor Green
    }

    #Print-Server asennettu
    $PrintServerAsennettu = (Get-WindowsFeature  | Where-Object {$_.Name -eq "Print-Server"}).InstallState
    if ($PrintServerAsennettu -eq "Installed")
        {
        Write-Host "Print-Server-rooli on asennettu palvelimelle" -ForegroundColor Green
        }
    else {
        Write-Host "Print-Server-roolia ei ole asennettu palvelimelle" -ForegroundColor Red
    }

    Write-Host "Testaa, että tulostin tuli näkyville työasemalle ryhmäkäytäntöjen kautta!" -ForegroundColor Yellow

    #Onko verkkojako myynti olemassa?
    $netshare_myynti = Test-Path \\hdesk-dc01\myynti
    if ($netshare_myynti -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\hdesk-dc01\myynti" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\hdesk-dc01\myynti" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa Myynti
    $netshare_MyyntiOikeudet = (Get-SmbShareAccess -Name "Myynti" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_MyyntiOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa Myynti ryhmällä Everyone on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa Myynti ryhmällä Everyone ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #GPO Myynti verkkojaon tarkistaminen
    $HdeskGPONimi = "MyyntiOasema"
    Get-GPOReport -Name $HdeskGPONimi -ReportType XML -Path C:\MyyntiOasema.xml
    $MyyntiJakoOGPOAction = Select-String -path C:\MyyntiOasema.xml -Pattern 'letter="O"' -SimpleMatch
    if ($MyyntiJakoOGPOAction -eq $null)
        {
        Write-Host "GPOn $HdeskGPONimi verkkojaon asemakirjain asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $HdeskGPONimi verkkojaon asemakirjain asetukset ovat oikein" -ForegroundColor Green
    }

    Write-Host "Muista testata, että verkkojako ilmestyy työasemille ja se toimii!" -ForegroundColor Yellow

   }

    }

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause
 }
 until ($selection -eq 'q')
