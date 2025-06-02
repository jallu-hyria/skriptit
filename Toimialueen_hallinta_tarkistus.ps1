# Versio 1.00. 19.4.2025. Jalmari Valimaan tikkukirjaimilla koodattu
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

    Write-Host "Paina '2' tarkistaaksesi tehtävän: 	     002 Käyttäjien ja objektien hallinta" 
    Write-Host "Paina '3' tarkistaaksesi tehtävän: 	     003 Oikeuksien testaus" 
    Write-Host "Paina '4' tarkistaaksesi tehtävän: 	     004 Käyttäjätilien hallinta" 
    Write-Host "Paina '5' tarkistaaksesi tehtävän: 	     005 Ryhmäkäytännöt" 
    Write-Host "Paina '6' tarkistaaksesi tehtävän: 	     006 Tulostimien hallinta" 
    Write-Host "Paina '7' tarkistaaksesi tehtävän: 	     007 Verkkojaot" 
    Write-Host "Paina '8' tarkistaaksesi tehtävän: 	     008 Kotikansiot ja backup" 
    Write-Host "Paina '9' tarkistaaksesi tehtävän: 	     009 Sovellukset" 
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
   }


    '2' {
    Write-Host "================ Tarkistetaan tehtävä 002 ================"

    #AD roskakori
    If ((Get-ADOptionalFeature -Filter {Name -like "Recycle*"}).EnabledScopes) 
        {
        Write-Host "Toimialueen roskakori on käytössä" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueen roskakori ei ole käytössä" -ForegroundColor Red
        }

    #RMK Mallikäyttäjän tarkistus
    $kayttaja_malliUserRMK = (Get-ADUser -identity _template_user_RMK).SamAccountName
    $kayttaja_malliUserPolkuRMK = (Get-ADUser -identity _template_user_RMK).distinguishedName

    if ($kayttaja_malliUserRMK -eq "_template_user_RMK")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserRMK on olemassa polussa: $kayttaja_malliUserPolkuRMK" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserRMK ei löydetty polusta: $kayttaja_malliUserPolkuRMK" -ForegroundColor Red
        }

    #RMK Mallikäyttäjän salasanan vaihto seuraavalla kirjautumisella
    $changePasswordAtNextLogon = (Get-ADUser -identity _template_user_RMK -properties * | Select-Object pwdlastset).pwdlastset
    if ($changePasswordAtNextLogon -ne "0")
        {
        Write-Host "Käyttäjän $kayttaja_malliUserRMK ei tarvitse vaihtaa salasanaa seuraavalla kirjautumiskerralla" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän $kayttaja_malliUserRMK tulee vaihtaa salasana seuraavalla kirjautumiskerralla" -ForegroundColor Red
    }

    #RMK mallikäyttäjän ryhmäjäsenyys
    $RMKtemplateRyhma = (Get-ADGroupMember -Identity "RiihimakiUsers" | Where-Object {$_.name -eq "_template_user_RMK"}).name
    if ($RMKtemplateRyhma -eq "_template_user_RMK")
        {
        Write-Host "Käyttäjä nimeltään $RMKtemplateRyhma on oikeassa ryhmässä nimeltään RiihimakiUsers" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $RMKtemplateRyhma ei ole oikeassa ryhmässä nimeltään RiihimakiUsers" -ForegroundColor Red
    }

    #RMK mallikäyttäjän toimisto    
    $RMKtemplateToimisto = (Get-ADUser -identity _template_user_RMK -properties * | Select-Object Office).Office
    if ($RMKtemplateToimisto -eq "Riihimäki")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserRMK on oikeassa toimistossa" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserRMK ei ole oikeassa toimistossa" -ForegroundColor Red
    }    
       
    #RMK mallikäyttäjän WWW-sivut    
    $RMKtemplateWWW = (Get-ADUser -identity _template_user_RMK -properties * | Select-Object WWWHomePage).WWWHomePage
    if ($RMKtemplateWWW -eq "hyriadesk.net")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_malliUserRMK on oikea WWW-sivu" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_malliUserRMK ei ole oikea WWW-sivu" -ForegroundColor Red
    }  

    #TKU Mallikäyttäjän tarkistus
    $kayttaja_malliUserTKU = (Get-ADUser -identity _template_user_TKU).SamAccountName
    $kayttaja_malliUserPolkuTKU = (Get-ADUser -identity _template_user_TKU).distinguishedName

    if ($kayttaja_malliUserTKU -eq "_template_user_TKU")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserTKU on olemassa polussa: $kayttaja_malliUserPolkuTKU" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserTKU ei löydetty polusta: $kayttaja_malliUserPolkuTKU" -ForegroundColor Red
        }

    #TKU Mallikäyttäjän salasanan vaihto seuraavalla kirjautumisella
    $changePasswordAtNextLogon = (Get-ADUser -identity _template_user_TKU -properties * | Select-Object pwdlastset).pwdlastset
    if ($changePasswordAtNextLogon -ne "0")
        {
        Write-Host "Käyttäjän $kayttaja_malliUserTKU ei tarvitse vaihtaa salasanaa seuraavalla kirjautumiskerralla" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän $kayttaja_malliUserTKU tulee vaihtaa salasana seuraavalla kirjautumiskerralla" -ForegroundColor Red
    }

    #TKU mallikäyttäjän ryhmäjäsenyys
    $TKUtemplateRyhma = (Get-ADGroupMember -Identity "TurkuUsers" | Where-Object {$_.name -eq "_template_user_TKU"}).name
    if ($TKUtemplateRyhma -eq "_template_user_TKU")
        {
        Write-Host "Käyttäjä nimeltään $TKUtemplateRyhma on oikeassa ryhmässä nimeltään TurkuUsers" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $TKUtemplateRyhma ei ole oikeassa ryhmässä nimeltään TurkuUsers" -ForegroundColor Red
    }


    #TKU mallikäyttäjän toimisto    
    $TKUtemplateToimisto = (Get-ADUser -identity _template_user_TKU -properties * | Select-Object Office).Office
    if ($TKUtemplateToimisto -eq "Turku")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserTKU on oikeassa toimistossa" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_malliUserTKU ei ole oikeassa toimistossa" -ForegroundColor Red
    }    
       
    #TKU mallikäyttäjän WWW-sivut    
    $TKUtemplateWWW = (Get-ADUser -identity _template_user_TKU -properties * | Select-Object WWWHomePage).WWWHomePage
    if ($TKUtemplateWWW -eq "hyriadesk.net")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_malliUserTKU on oikea WWW-sivu" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_malliUserTKU ei ole oikea WWW-sivu" -ForegroundColor Red
    }  

    #Viivi käyttäjä
    $kayttaja_Viivi = (Get-ADUser -identity Viivi).SamAccountName
    $kayttaja_ViiviPolku = (Get-ADUser -identity Viivi).distinguishedName

    if ($kayttaja_Viivi -eq "Viivi")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Viivi on olemassa polussa: $kayttaja_ViiviPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Viivi ei löydetty polusta: $kayttaja_ViiviPolku" -ForegroundColor Red
        }

    #Viivin puhelinnumero  
    $ViiviPuhnro = (Get-ADUser -identity Viivi -properties * | Select-Object telephoneNumber).telephoneNumber
    if ($ViiviPuhnro -eq "040 123 4567")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Viivi on oikea puhelinnumero" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Viivi ei ole oikea puhelinnumero. Otithan huomioon välilyönnit numerossa?" -ForegroundColor Red
    } 

    #Viivin titteli  
    $ViiviTitteli = (Get-ADUser -identity Viivi -properties * | Select-Object Title).Title
    if ($ViiviTitteli -eq "Sihteeri")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Viivi on oikea titteli" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Viivi ei ole oikea titteli" -ForegroundColor Red
    } 

    #Sami käyttäjä
    $kayttaja_Sami = (Get-ADUser -identity Sami).SamAccountName
    $kayttaja_SamiPolku = (Get-ADUser -identity Sami).distinguishedName

    if ($kayttaja_Sami -eq "Sami")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Sami on olemassa polussa: $kayttaja_SamiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Sami ei löydetty polusta: $kayttaja_SamiPolku" -ForegroundColor Red
        }

    #Samin puhelinnumero  
    $SamiPuhnro = (Get-ADUser -identity Sami -properties * | Select-Object telephoneNumber).telephoneNumber
    if ($SamiPuhnro -eq "040 123 1231")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Sami on oikea puhelinnumero" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Sami ei ole oikea puhelinnumero. Otithan huomioon välilyönnit numerossa?" -ForegroundColor Red
    } 

    #Samin titteli  
    $SamiTitteli = (Get-ADUser -identity Sami -properties * | Select-Object Title).Title
    if ($SamiTitteli -eq "Myyjä")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Sami on oikea titteli" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Sami ei ole oikea titteli" -ForegroundColor Red
    } 

    #Sampo käyttäjä
    $kayttaja_Sampo = (Get-ADUser -identity Sampo).SamAccountName
    $kayttaja_SampoPolku = (Get-ADUser -identity Sampo).distinguishedName

    if ($kayttaja_Sampo -eq "Sampo")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Sampo on olemassa polussa: $kayttaja_SampoPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Sampo ei löydetty polusta: $kayttaja_SampoPolku" -ForegroundColor Red
        }

    #Sampon titteli  
    $SampoTitteli = (Get-ADUser -identity Sampo -properties * | Select-Object Title).Title
    if ($SampoTitteli -eq "Apulaisjohtaja")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Sampo on oikea titteli" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Sampo ei ole oikea titteli" -ForegroundColor Red
    } 

    #Tove käyttäjä
    $kayttaja_Tove = (Get-ADUser -identity Tove).SamAccountName
    $kayttaja_TovePolku = (Get-ADUser -identity Tove).distinguishedName

    if ($kayttaja_Tove -eq "Tove")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Tove on olemassa polussa: $kayttaja_TovePolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Tove ei löydetty polusta: $kayttaja_TovePolku" -ForegroundColor Red
        }

    #Toven titteli  
    $ToveTitteli = (Get-ADUser -identity Tove -properties * | Select-Object Title).Title
    if ($ToveTitteli -eq "Sihteeri")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Tove on oikea titteli" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Tove ei ole oikea titteli" -ForegroundColor Red
    } 
	
    #Toven esihenkilö  
    $ToveTitteli = (Get-ADUser -identity Tove -properties * | Select-Object Manager).Manager
    if ($ToveTitteli -eq "CN=Sampo,OU=Käyttäjät,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Tove on oikea esihenkilö" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Tove ei ole oikea esihenkilö" -ForegroundColor Red
    } 

    #ICT-palvelut jäsenyydet
    $juhoRyhmä = (Get-ADGroupMember -Identity "ICT-palvelut" | Where-Object {$_.name -eq "Juho"}).name
    if ($juhoRyhmä -eq "Juho")
        {
        Write-Host "Käyttäjä nimeltään $juhoRyhmä on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $juhoRyhmä ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #AllUsers jäsenyydet
    $RiihimakiUsersRyhmä = (Get-ADGroupMember -Identity "AllUsers" | Where-Object {$_.name -eq "RiihimakiUsers"}).name
    if ($RiihimakiUsersRyhmä -eq "RiihimakiUsers")
        {
        Write-Host "Ryhmä nimeltään $RiihimakiUsersRyhmä on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $RiihimakiUsersRyhmä ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #AllUsers jäsenyydet
    $TurkuUsersRyhmä = (Get-ADGroupMember -Identity "AllUsers" | Where-Object {$_.name -eq "TurkuUsers"}).name
    if ($TurkuUsersRyhmä -eq "TurkuUsers")
        {
        Write-Host "Ryhmä nimeltään $TurkuUsersRyhmä on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $TurkuUsersRyhmä ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #AllDevices jäsenyydet
    $RiihimakiDevicesRyhmä = (Get-ADGroupMember -Identity "AllDevices" | Where-Object {$_.name -eq "RiihimakiDevices"}).name
    if ($RiihimakiDevicesRyhmä -eq "RiihimakiDevices")
        {
        Write-Host "Ryhmä nimeltään $RiihimakiDevicesRyhmä on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $RiihimakiDevicesRyhmä ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #AllDevices jäsenyydet
    $TurkuDevicesRyhmä = (Get-ADGroupMember -Identity "AllDevices" | Where-Object {$_.name -eq "TurkuDevices"}).name
    if ($TurkuDevicesRyhmä -eq "TurkuDevices")
        {
        Write-Host "Ryhmä nimeltään $TurkuDevicesRyhmä on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $TurkuDevicesRyhmä ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #Distribution ryhmien tarkistus
    $ryhma_distribution =  (Get-ADGroup -Identity "DistributionUsers").Name
    $ryhma_distributionPolku =  (Get-ADGroup -Identity "DistributionUsers").DistinguishedName

    if ($ryhma_distribution -eq "DistributionUsers")
        {
        Write-Host "Ryhmä nimeltään $ryhma_distribution on olemassa polussa: $ryhma_distributionPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_distribution ei löydetty polusta $ryhma_distributionPolku" -ForegroundColor Red
    }

    #Distribution ryhmien tarkistus
    $ryhma_distributionTyyppi = (Get-ADGroup -Identity DistributionUsers).GroupCategory
    if ($ryhma_distributionTyyppi -eq "Distribution")
        {
        Write-Host "Ryhmä nimeltään $ryhma_distributionTyyppi on oikean tyyppinen" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmä nimeltään $ryhma_distributionTyyppi ei ole oikein tyyppinen" -ForegroundColor Red
    }

    #Matti käyttäjä
    $kayttaja_Matti = (Get-ADUser -identity Matti).SamAccountName
    $kayttaja_MattiPolku = (Get-ADUser -identity Matti).distinguishedName

    if ($kayttaja_MattiPolku -eq "CN=matti,OU=Käyttäjät,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Matti on olemassa polussa: $kayttaja_MattiPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Matti ei löydetty polusta: $kayttaja_MattiPolku" -ForegroundColor Red
    }

    #Matti jäsenyydet
    $mattiRyhmä = (Get-ADGroupMember -Identity "RiihimakiUsers" | Where-Object {$_.name -eq "Matti"}).name
    if ($mattiRyhmä -eq "Matti")
        {
        Write-Host "Käyttäjä nimeltään $mattiRyhmä on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $mattiRyhmä ei ole oikeassa ryhmässä" -ForegroundColor Red
    }

    #Valmentajat OU tarkistus
    $ErrorActionPreference = "SilentlyContinue"
    $OU_Valmentajat = (Get-ADOrganizationalUnit -Identity 'OU=Valmentajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net' -ErrorAction SilentlyContinue).Name
    $OU_ValmentajatPolku = (Get-ADOrganizationalUnit -Identity 'OU=Valmentajat,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net' -ErrorAction SilentlyContinue).DistinguishedName

    if ($OU_Valmentajat -eq "Valmentajat")
        {
        Write-Host "OU nimeltään $OU_Valmentajat on olemassa polussa: $OU_ValmentajatPolku" -ForegroundColor Red

        }
    else {
        Write-Host "OU nimeltään Valmentajat ei löydetty eli se on poistettu tai väärässä sijainnissa" -ForegroundColor Green
    }
    
    #Kaapo käyttäjä
    $kayttaja_Kaapo = (Get-ADUser -identity Kaapo).SamAccountName
    $kayttaja_KaapoPolku = (Get-ADUser -identity Kaapo).distinguishedName

    if ($kayttaja_Kaapo -eq "Kaapo")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Kaapo on olemassa polussa: $kayttaja_KaapoPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Kaapo ei löydetty polusta: $kayttaja_KaapoPolku" -ForegroundColor Red
        }

    #Kaapon titteli  
    $KaapoTitteli = (Get-ADUser -identity Kaapo -properties * | Select-Object Title).Title
    if ($KaapoTitteli -eq "Kesätyöntekijä")
        {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Kaapo on oikea titteli" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään $kayttaja_Kaapo ei ole oikea titteli" -ForegroundColor Red
    } 

    Write-Host "Olethan harjoitellut toimialueen hakutyökalun käyttöä sekä suodatusta?" -ForegroundColor Yellow

    }

    '3' {
    Write-Host "================ Tarkistetaan tehtävä 003 ================"

    #Janikan ryhmäjäsenyys
    $JanikanRyhma = (Get-ADGroupMember -Identity "ICT-Palvelut" | Where-Object {$_.name -eq "Janika"}).name
    if ($JanikanRyhma -eq "Janika")
        {
        Write-Host "Käyttäjä nimeltään $JanikanRyhma on oikeassa ryhmässä nimeltään ICT-Palvelut" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $JanikanRyhma ei ole oikeassa ryhmässä nimeltään ICT-Palvelut" -ForegroundColor Red
    }

    #Onervan ryhmäjäsenyys
    $OnervanRyhma = (Get-ADGroupMember -Identity "ICT-Palvelut" | Where-Object {$_.name -eq "Onerva"}).name
    if ($OnervanRyhma -eq "Onerva")
        {
        Write-Host "Käyttäjä nimeltään $OnervanRyhma on oikeassa ryhmässä nimeltään ICT-Palvelut" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $OnervanRyhma ei ole oikeassa ryhmässä nimeltään ICT-Palvelut" -ForegroundColor Red
    }

    Write-Host "Olethan delegoinut oikeudet Janikalle ja Onervalle, jotta he voivat liittää tietokoneita toimialueelle??" -ForegroundColor Yellow

    #windows-ta-002 
    $ta002DHCP = (Get-DhcpServerv4Lease -ScopeId 192.168.1.0 | Where-Object {$_.HostName -like "windows-ta-002.hyriadesk.net"}).HostName
    if ($ta002DHCP -eq "windows-ta-002.hyriadesk.net")
        {
        Write-Host "Työasema $ta002DHCP löytyy ja se on saanut osoitteet DHCP-palvelulta" -ForegroundColor Green
        }
    else {
        Write-Host "Työasema windows-ta-002 ei löytynyt eikä se ole luultavasti saanut IP-asetuksia DHCP-palvelulta" -ForegroundColor Red
    }

    #windows-ta-003 
    $ta003DHCP = (Get-DhcpServerv4Lease -ScopeId 192.168.1.0 | Where-Object {$_.HostName -like "windows-ta-003.hyriadesk.net"}).HostName
    if ($ta003DHCP -eq "windows-ta-003.hyriadesk.net")
        {
        Write-Host "Työasema $ta003DHCP löytyy ja se on saanut osoitteet DHCP-palvelulta" -ForegroundColor Green
        }
    else {
        Write-Host "Työasema windows-ta-003 ei löytynyt eikä se ole luultavasti saanut IP-asetuksia DHCP-palvelulta" -ForegroundColor Red
    }

    #TA002 tietokonetili
    $tietokone_ta002 = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").Name
    $tietokone_ta002Polku = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net").DistinguishedName

    if ($tietokone_ta002 -eq "windows-ta-002")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta002 on olemassa polussa: $tietokone_ta002Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään windows-ta-002 ei löytynyt oikeasta paikasta" -ForegroundColor Red
    }

    #TA003 tietokonetili
    $tietokone_ta003 = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net").Name
    $tietokone_ta003Polku = (Get-ADComputer -Filter * -SearchBase "OU=Tietokoneet,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net").DistinguishedName

    if ($tietokone_ta003 -eq "windows-ta-003")
        {
        Write-Host "Tietokone nimeltään $tietokone_ta003 on olemassa polussa: $tietokone_ta003Polku" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokone nimeltään windows-ta-003 ei löytynyt oikeasta paikasta" -ForegroundColor Red
    }

    Write-Host "Peruskäyttäjä ei voi asentaa sovelluksia, sillä hänellä ei ole oikeuksia tehdä niin toimialueella" -ForegroundColor Yellow
    Write-Host "Janikalla ei myöskään ole oikeuksia tehdä isompia muutoksia, pelkästään vaihtaa muiden salasanoja sekä liittää tietokoneita toimialueelle" -ForegroundColor Yellow
    Write-Host "Toimialueen administrator käyttäjä voi tehdä lähes mitä tahansa, kuten asentaa sovelluksia" -ForegroundColor Yellow

    #Janikan ryhmäjäsenyys admin
    $JanikanRyhma = (Get-ADGroupMember -Identity "Administrators" | Where-Object {$_.name -eq "Janika"}).name
    if ($JanikanRyhma -eq "Janika")
        {
        Write-Host "Käyttäjä nimeltään $JanikanRyhma on oikeassa ryhmässä nimeltään Administrators" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $JanikanRyhma ei ole oikeassa ryhmässä nimeltään Administrators" -ForegroundColor Red
    }

    #Janikan ryhmäjäsenyys domain admins
    $JanikanRyhma = (Get-ADGroupMember -Identity "Domain Admins" | Where-Object {$_.name -eq "Janika"}).name
    if ($JanikanRyhma -eq "Janika")
        {
        Write-Host "Käyttäjä nimeltään $JanikanRyhma on oikeassa ryhmässä nimeltään Domain Admins" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $JanikanRyhma ei ole oikeassa ryhmässä nimeltään Domain Admins" -ForegroundColor Red
    }

    Write-Host "Janika pystyy asentamaan sovelluksia, kun hänelle annetaan enemmän oikeuksia toimialueelle" -ForegroundColor Yellow
    
    }
    
    '4' {
    Write-Host "================ Tarkistetaan tehtävä 004 ================"
    Write-Host "Viivin kirjautuessa tulisi tulla ilmoitus siitä, että tili on poistettu käytöstä eli disabloitu" -ForegroundColor Yellow
    Write-Host "Samille tulee kehoitus vaihtaa salasana kun hän yrittää kirjautua" -ForegroundColor Yellow
    Write-Host "Sampon kirjautuessa tulee ilmoitus siitä, että tili on vanhentunut" -ForegroundColor Yellow
    Write-Host "Kaapon kirjautuessa tulee ilmoitus, että tiliä ei ole olemassa" -ForegroundColor Yellow
    Write-Host "Toven kirjautuessa tulee ilmoitus, että aikarajoitukset rajoittavat kirjautumista" -ForegroundColor Yellow
    Write-Host "Juholle kirjautuessa tulee ilmoitus väärästä salasanasta" -ForegroundColor Yellow
    Write-Host "whoami komennolla näkee millä käyttäjätilillä ja mihin domainiin olet kirjautunut. Syöte voisi näyttää esim tältä: hyriadesk\administrator" -ForegroundColor Yellow

    #Ilmari käyttäjä
    $kayttaja_Ilmari = (Get-ADUser -identity Ilmari).SamAccountName
    $kayttaja_IlmariPolku = (Get-ADUser -identity Ilmari).distinguishedName

    if ($kayttaja_Ilmari -eq "Ilmari")
        {
        Write-Host "Käyttäjä nimeltään $kayttaja_Ilmari on olemassa polussa: $kayttaja_IlmariPolku" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjä nimeltään $kayttaja_Ilmari ei löydetty polusta: $kayttaja_IlmariPolku" -ForegroundColor Red
    }

    Write-Host "Kun Ilmari kirjatuu toimialueelle hänen tulee käyttää kirjautumistunnusta Ilmari eikä Sampo" -ForegroundColor Yellow
    Write-Host "Viivi voi itse vaihtaa toimialueen salasanan työasemalta käsin CTRL + ALT + DEL näppäinyhdistelmällä -> Change a password" -ForegroundColor Yellow
    Write-Host "Työaseman paikalliselle käyttäjätilille pääsee käsiksi kun tietä paikallisen kirjautumistunnuksen ja kirjautumisikkunassa syöttää .\ merkkien jälkeen tunnuksen. .\ määrittävät että kirjautuminen tapahtuu paikallisella tunnuksella" -ForegroundColor Yellow
    Write-Host "Kun käyttäjä soittaa ja pyytää salasanan nollausta on erittäin tärkeää varmistaa, että kyseessä on oikea henkilö. Henkilö voisi olla myös ulkopuolinen paha taho, joka yrittää murtautua jollekin tilille!" -ForegroundColor Yellow

    } 

    '5' {
    Write-Host "================ Tarkistetaan tehtävä 005 ================"

    Write-Host "GPO/ryhmäkäytäntöjen tarkistuksen aikana C:\ aseman juureen luodaan useita .XML tyyppisiä tiedostoja. Niistä ei tarvitse murehtia!" -ForegroundColor Yellow

    #GPO Default domain policy
    $DefaultDomainPolicy = "Default Domain Policy"
    Get-GPOReport -Name $DefaultDomainPolicy -ReportType XML -Path C:\DefaultDomainPolicy.xml
    $DefaultDomainPolicyGPOpituus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern '<q1:Name>MinimumPasswordLength</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>10<"
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

    $DefaultDomainPolicyGPOlukitus = Select-String -path C:\DefaultDomainPolicy.xml -Pattern '<q1:Name>LockoutBadCount</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "SettingNumber>4<"
    if ($DefaultDomainPolicyGPOlukitus -eq $null)
        {
        Write-Host "GPOn $DefaultDomainPolicy tilin lukitus säännöt ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $DefaultDomainPolicy tilin lukitus säännöt ovat oikein" -ForegroundColor Green
    }

    #GPO estä Control panel
    $EstaOhjauspaneeli = "EstäOhjauspaneeli"
    Get-GPOReport -Name $EstaOhjauspaneeli -ReportType XML -Path C:\EstaOhjauspaneeli.xml
    $EstaOhjauspaneeliGPO = Select-String -path C:\EstaOhjauspaneeli.xml -Pattern '<q1:Name>Prohibit access to Control Panel and PC settings</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "State>Enabled<"
    if ($EstaOhjauspaneeliGPO -eq $null)
        {
        Write-Host "GPOn $EstaOhjauspaneeli sääntö on väärin eli Ohjauspaneelia ei ole estetty" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $EstaOhjauspaneeli sääntö on oikein eli Ohjauspaneeliin ei ole pääsyä" -ForegroundColor Green
    }

    #GPO estä Rekisteri
    $EstaRekisteri = "EstäRekisteri"
    Get-GPOReport -Name $EstaRekisteri -ReportType XML -Path C:\EstaRekisteri.xml
    $EstaRekisteriGPO = Select-String -path C:\EstaRekisteri.xml -Pattern '<q1:Name>Prevent access to registry editing tools</q1:Name>' -SimpleMatch -Context 0, 1 | Out-String -Stream | Select-String -Pattern "State>Enabled<"
    if ($EstaRekisteriGPO -eq $null)
        {
        Write-Host "GPOn $EstaRekisteri sääntö on väärin eli Rekisteriä ei ole estetty" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $EstaRekisteri sääntö on oikein eli Rekisteriin ei ole pääsyä" -ForegroundColor Green
    }

    #Windows Store GPO
    $WindowsStoreGPO = (Get-GPO -Name "EstäWindowsKauppa").DisplayName
    if ($WindowsStoreGPO -like "EstäWindowsKauppa")
        {
        Write-Host "Toimialueella on GPO, jonka nimi on EstäWindowsKauppa" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole GPO:ta, jonka nimi olisi EstäWindowsKauppa" -ForegroundColor Red
    }

    Write-Host "Skripti ei osaa tarkistaa oletko estänyt Windows Storen GPO:lla, koska vaihtoehtoja on useita. Muista dokumentoida GPO ja sen toimivuus dokumentaatiossa!" -ForegroundColor Yellow
    Write-Host "gpupdate /force komennolla voit päivittää ryhmäkäytännöt" -ForegroundColor Yellow
    Write-Host "Riihimäen käyttäjillä ei pidä olla pääsyä Ohjauspaneeliin" -ForegroundColor Yellow
    Write-Host "Janika voi käyttää Ohjauspaneelia koska hän on IT-tuki organisaatioyksikössä ja GPO tehtiin Riihimäen / Käyttäjät OU:n alle eikä siten vaikuta häneen" -ForegroundColor Yellow
    Write-Host "Turun käyttäjillä ei pidä olla pääsyä Rekisteriin" -ForegroundColor Yellow
    Write-Host "Janika voi käyttää Rekisteriä koska hän on IT-tuki organisaatioyksikössä ja GPO tehtiin Turun / Käyttäjät OU:n alle eikä siten vaikuta häneen" -ForegroundColor Yellow
    Write-Host "gpresult komennolla voi hakea työasemalta siihen vaikuttavat ryhmäkäytännöt. Oikeilla parametreilla sen saa HTML muotoon. Katso ohjeita komennolla: gpresult /?" -ForegroundColor Yellow

    }

    '6' {
    Write-Host "================ Tarkistetaan tehtävä 006 ================"

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
    $TulostimenPortti = (get-printer -Name "HyriaDesk testitulostin").PortName
    if ($TulostimenPortti -eq "LPT1:")
        {
        Write-Host "Tulostimen portti on $TulostimenPortti eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen portti on $TulostimenPortti eli väärin" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenAjuri = (get-printer -Name "HyriaDesk testitulostin").DriverName
    if ($TulostimenAjuri -eq "Microsoft PS Class Driver")
        {
        Write-Host "Tulostimen Ajuri on $TulostimenAjuri eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen Ajuri on $TulostimenAjuri eli väärin" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenNimi = (get-printer -Name "HyriaDesk testitulostin").Name
    if ($TulostimenNimi -eq "HyriaDesk testitulostin")
        {
        Write-Host "Tulostimen Nimi on $TulostimenNimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen Nimi on $TulostimenNimi eli väärin" -ForegroundColor Red
    }

    #Tulostimen asetus
    $TulostimenJakonimi = (get-printer -Name "HyriaDesk testitulostin").ShareName
    if ($TulostimenJakonimi -eq "HyriaDesk testitulostin")
        {
        Write-Host "Tulostimen Jakonimi on $TulostimenJakonimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostimen Jakonimi on $TulostimenJakonimi eli väärin" -ForegroundColor Red
    }

    #Tulostimen GPO
    $TulostinGPO = (Get-GPO -Name "HyriaDesk testitulostin").DisplayName
    if ($TulostinGPO -like "HyriaDesk testitulostin")
        {
        Write-Host "Toimialueella on GPO, jonka nimi on HyriaDesk testitulostin" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole GPO:ta, jonka nimi olisi HyriaDesk testitulostin" -ForegroundColor Red
    }

    Write-Host "Joudut kuitenkin itse testaamaan ryhmäkäytännön eli GPO:n toiminnan" -ForegroundColor Yellow

    #Tulostimen lisäys AD:hen
    $TulostinListattu = (Get-AdObject -filter "objectCategory -eq 'printqueue'" -Properties PrinterName).PrinterName
    if ($TulostinListattu -eq "HyriaDesk testitulostin")
        {
        Write-Host "Tulostin on listattu toimialueelle nimellä $TulostinListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostinta ei ole listattu toimialueelle nimellä $TulostinListattu" -ForegroundColor Red
    }

    #Tulostimet OU
    $OU_tulostin = (Get-ADOrganizationalUnit -Identity 'OU=Tulostimet,OU=HyriaDesk,DC=hyriadesk,DC=net').Name
    $OU_tulostinPolku = (Get-ADOrganizationalUnit -Identity 'OU=Tulostimet,OU=HyriaDesk,DC=hyriadesk,DC=net').DistinguishedName

    if ($OU_tulostin -eq "Tulostimet")
        {
        Write-Host "OU nimeltään $OU_tulostin on olemassa polussa: $OU_tulostinPolku" -ForegroundColor Green
        }
    else {
        Write-Host "OU nimeltään $OU_tulostin ei löydetty polusta: $OU_tulostinPolku" -ForegroundColor Red
    }

    #Tulostimen lisäys AD:hen
    $TulostinADssa = (Get-AdObject -filter "objectCategory -eq 'printqueue'" -Properties DistinguishedName).DistinguishedName
    if ($TulostinADssa -eq "CN=WINDOWS-SRV-001-HyriaDesk testitulostin,OU=Tulostimet,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Tulostin on oikeassa OU:ssa polussa: $TulostinADssa" -ForegroundColor Green
        }
    else {
        Write-Host "Tulostin ei ole oikeassa OU:ssa polussa: $TulostinADssa" -ForegroundColor Red
    }

    Write-Host "Olethan testannut tulostimen toiminnan työasemalta käsin?" -ForegroundColor Yellow

    }

    '7' {
    Write-Host "================ Tarkistetaan tehtävä 007 ================"

    #Onko verkkojaon oikeudet kunnossa HyriaDesk
    $netshare_HyriaDeskOikeudet = (Get-SmbShareAccess -Name "HyriaDesk" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_HyriaDeskOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa HyriaDesk ryhmällä Everyone on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa HyriaDesk ryhmällä Everyone ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa RiihimakiJako
    $netshare_RiihimakiJakoOikeudet = (Get-SmbShareAccess -Name "RiihimakiJako" | Where-Object {$_.AccountName -eq "Hyriadesk\RiihimakiUsers"}).AccessRight
    if ($netshare_RiihimakiJakoOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa RiihimakiJako ryhmällä RiihimakiUsers on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa RiihimakiJako ryhmällä RiihimakiUsers ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa RiihimakiJako
    $netshare_RiihimakiJakoOikeudet = (Get-SmbShareAccess -Name "RiihimakiJako" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_RiihimakiJakoOikeudet -eq $null)
        {
        Write-Host "Verkkojaossa RiihimakiJako ryhmällä Everyone ei ole mitään oikeuksia" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa RiihimakiJako ryhmällä Everyone on jotain oikeuksiat" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa TurkuJako
    $netshare_TurkuJakoOikeudet = (Get-SmbShareAccess -Name "TurkuJako" | Where-Object {$_.AccountName -eq "Hyriadesk\TurkuUsers"}).AccessRight
    if ($netshare_TurkuJakoOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa TurkuJako ryhmällä TurkuUsers on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa TurkuJako ryhmällä TurkuUsers ei ole kaikki oikeudet" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa TurkuJako
    $netshare_TurkuJakoOikeudet = (Get-SmbShareAccess -Name "TurkuJako" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_TurkuJakoOikeudet -eq $null)
        {
        Write-Host "Verkkojaossa TurkuJako ryhmällä Everyone ei ole mitään oikeuksia" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa TurkuJako ryhmällä Everyone on jotain oikeuksiat" -ForegroundColor Red
    }

    #Onko verkkojaon Listattu kunnossa HyriaDesk
    $netshare_HyriaDeskListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "HyriaDeskJako"}).DistinguishedName
    if ($netshare_HyriaDeskListattu -eq "CN=HyriaDeskJako,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Verkkojakoa HyriaDesk on listattu toimialueeseen polkuun $netshare_HyriaDeskListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa HyriaDesk ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    #Onko verkkojaon Listattu kunnossa TurkuJako
    $netshare_TurkuJakoListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "TurkuJako"}).DistinguishedName
    if ($netshare_TurkuJakoListattu -eq "CN=TurkuJako,OU=Turku,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Verkkojakoa TurkuJako on listattu toimialueeseen polkuun $netshare_TurkuJakoListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa TurkuJako ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    #Onko verkkojaon Listattu kunnossa RiihimakiJako
    $netshare_RiihimakiJakoListattu = (Get-ADObject -Filter 'ObjectClass -eq "Volume"' -Properties Name | Where-Object {$_.Name -eq "RiihimakiJako"}).DistinguishedName
    if ($netshare_RiihimakiJakoListattu -eq "CN=RiihimakiJako,OU=Riihimäki,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Verkkojakoa RiihimakiJako on listattu toimialueeseen polkuun $netshare_RiihimakiJakoListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa RiihimakiJako ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    Write-Host "GPO/ryhmäkäytäntöjen tarkistuksen aikana C:\ aseman juureen luodaan useita .XML tyyppisiä tiedostoja. Niistä ei tarvitse murehtia!" -ForegroundColor Yellow

    #Verkkojakon HyriaDesk GPO
    $HyriaDeskJakoGPO = (Get-GPO -Name "HyriaDeskJakoH").DisplayName
    if ($HyriaDeskJakoGPO -like "HyriaDeskJakoH")
        {
        Write-Host "Toimialueella on GPO, jonka nimi on $HyriaDeskJakoGPO" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole GPO:ta, jonka nimi olisi HyriaDeskH" -ForegroundColor Red
    }

    #Verkkojakon RiihimakiJako GPO
    $RiihimakiJakoGPO = (Get-GPO -Name "RiihimakiJakoR").DisplayName
    if ($RiihimakiJakoGPO -like "RiihimakiJakoR")
        {
        Write-Host "Toimialueella on GPO, jonka nimi on $RiihimakiJakoGPO" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole GPO:ta, jonka nimi olisi RiihimakiJakoR" -ForegroundColor Red
    }

    #Verkkojakon TurkuJako GPO
    $TurkuJakoGPO = (Get-GPO -Name "TurkuJakoT").DisplayName
    if ($TurkuJakoGPO -like "TurkuJakoT")
        {
        Write-Host "Toimialueella on GPO, jonka nimi on $TurkuJakoGPO" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueella ei ole GPO:ta, jonka nimi olisi TurkuJakoT" -ForegroundColor Red
    }

    #GPO HyriaDesk verkkojaon tarkistaminen
    $HdeskGPONimi = "HyriaDeskJakoH"
    Get-GPOReport -Name $HdeskGPONimi -ReportType XML -Path C:\HyriaDeskJakoH.xml
    $HyriaDeskJakoHGPOAction = Select-String -path C:\HyriaDeskJakoH.xml -Pattern 'Properties action="C' -SimpleMatch
    if ($HyriaDeskJakoHGPOAction -eq $null)
        {
        Write-Host "GPOn $HdeskGPONimi verkkojaon Action ei ole Create" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $HdeskGPONimi verkkojaon Action on Create" -ForegroundColor Green
    }

    $HyriaDeskJakoHGPOShow = Select-String -path C:\HyriaDeskJakoH.xml -Pattern 'thisDrive="SHOW" allDrives="SHOW"' -SimpleMatch
    if ($HyriaDeskJakoHGPOShow -eq $null)
        {
        Write-Host "GPOn $HdeskGPONimi verkkojaon Show drive asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $HdeskGPONimi verkkojaon Show drive asetukset ovat oikein" -ForegroundColor Green
    }

    $HyriaDeskJakoHGPOPolku = Select-String -path C:\HyriaDeskJakoH.xml -Pattern 'path="\\WINDOWS-SRV-001\HyriaDesk"' -SimpleMatch
    if ($HyriaDeskJakoHGPOPolku -eq $null)
        {
        Write-Host "GPOn $HdeskGPONimi verkkojaon polku asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $HdeskGPONimi verkkojaon polku asetukset ovat oikein" -ForegroundColor Green
    }

	$HyriaDeskJakoHGPOKirjain = Select-String -path C:\HyriaDeskJakoH.xml -Pattern 'letter="H"' -SimpleMatch
    if ($HyriaDeskJakoHGPOKirjain -eq $null)
        {
        Write-Host "GPOn $HdeskGPONimi verkkojaon asemakirjain asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $HdeskGPONimi verkkojaon asemakirjain asetukset ovat oikein" -ForegroundColor Green
    }

    #GPO RiihimakiJako verkkojaon tarkistaminen
    $RiihimakiGPONimi = "RiihimakiJakoR"
    Get-GPOReport -Name $RiihimakiGPONimi -ReportType XML -Path C:\RiihimakiJakoR.xml
    $RiihimakiJakoRGPOAction = Select-String -path C:\RiihimakiJakoR.xml -Pattern 'Properties action="C' -SimpleMatch

    if ($RiihimakiJakoRGPOAction -eq $null)
        {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon Action ei ole Create" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon Action on Create" -ForegroundColor Green
    }

    $RiihimakiJakoRGPOShow = Select-String -path C:\RiihimakiJakoR.xml -Pattern 'thisDrive="SHOW" allDrives="SHOW"' -SimpleMatch
    if ($RiihimakiJakoRGPOShow -eq $null)
        {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon Show drive asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon Show drive asetukset ovat oikein" -ForegroundColor Green
    }

    $RiihimakiJakoRGPOPolku = Select-String -path C:\RiihimakiJakoR.xml -Pattern 'path="\\WINDOWS-SRV-001\RiihimakiJako"' -SimpleMatch
    if ($RiihimakiJakoRGPOPolku -eq $null)
        {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon polku asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon polku asetukset ovat oikein" -ForegroundColor Green
    }

	$RiihimakiJakoRGPOPolkuKirjain = Select-String -path C:\RiihimakiJakoR.xml -Pattern 'letter="R"' -SimpleMatch
    if ($RiihimakiJakoRGPOPolkuKirjain -eq $null)
        {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon asemakirjain asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $RiihimakiGPONimi verkkojaon asemakirjain asetukset ovat oikein" -ForegroundColor Green
    }


    #GPO TurkuJako verkkojaon tarkistaminen
    $TurkuGPONimi = "TurkuJakoT"
    Get-GPOReport -Name $TurkuGPONimi -ReportType XML -Path C:\TurkuJakoT.xml
    $TurkuJakoTGPOAction = Select-String -path C:\TurkuJakoT.xml -Pattern 'Properties action="C' -SimpleMatch

    if ($TurkuJakoTGPOAction -eq $null)
        {
        Write-Host "GPOn $TurkuGPONimi verkkojaon Action ei ole Create" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $TurkuGPONimi verkkojaon Action on Create" -ForegroundColor Green
    }

    $TurkuJakoTGPOShow = Select-String -path C:\TurkuJakoT.xml -Pattern 'thisDrive="SHOW" allDrives="SHOW"' -SimpleMatch

    if ($TurkuJakoTGPOShow -eq $null)
        {
        Write-Host "GPOn $TurkuGPONimi verkkojaon Show drive asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $TurkuGPONimi verkkojaon Show drive asetukset ovat oikein" -ForegroundColor Green
    }

    $TurkuJakoTGPOPolku = Select-String -path C:\TurkuJakoT.xml -Pattern 'path="\\WINDOWS-SRV-001\TurkuJako"' -SimpleMatch

    if ($TurkuJakoTGPOPolku -eq $null)
        {
        Write-Host "GPOn $TurkuGPONimi verkkojaon polku asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $TurkuGPONimi verkkojaon polku asetukset ovat oikein" -ForegroundColor Green
    }
	
	$TurkuJakoTGPOPolkuKirjain = Select-String -path C:\TurkuJakoT.xml -Pattern 'letter="T"' -SimpleMatch

    if ($TurkuJakoTGPOPolkuKirjain -eq $null)
        {
        Write-Host "GPOn $TurkuGPONimi verkkojaon asemakirjain asetukset ovat väärin" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $TurkuGPONimi verkkojaon asemakirjain asetukset ovat oikein" -ForegroundColor Green
    }

    Write-Host "Muistathan kuitenkin testata verkkojakojen ryhmäkäytännöt työasemalta käsin!" -ForegroundColor Yellow

    #Onko verkkojaon oikeudet kunnossa RiihimakiJako
    $netshare_RiihimakiJakoOikeudetSami = (Get-SmbShareAccess -Name "RiihimakiJako" | Where-Object {$_.AccountName -eq "Hyriadesk\Sami"}).AccessControlType
    if ($netshare_RiihimakiJakoOikeudetSami -eq "Deny")
        {
        Write-Host "Verkkojaossa RiihimakiJako käyttäjällä Sami on oikeudet estetty" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa RiihimakiJako käyttäjällä Sami on jotain oikeuksia" -ForegroundColor Red
    }
    } 

    '8' {
    Write-Host "================ Tarkistetaan tehtävä 008 ================"
     

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
    if ($netshare_kotikansioListattu -eq "CN=kotikansio,OU=HyriaDesk,DC=hyriadesk,DC=net")
        {
        Write-Host "Verkkojako kotikansio on listattu toimialueeseen polkuun $netshare_kotikansioListattu" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojako kotikansio ei ole listattu toimialueeseen oikeaan polkuun" -ForegroundColor Red
    }

    #Leenan kotikansio     
    $LeenanKotikansio = (Get-ADUser -identity Leena -properties *).HomeDirectory
    if ($LeenanKotikansio -eq "\\WINDOWS-SRV-001\kotikansio\leena")
        {
        Write-Host "Leenalle on määritetty kotikansio hakemistoon: \\WINDOWS-SRV-001\kotikansio\leena" -ForegroundColor Green
        }
    else {
        Write-Host "Leenalle ei ole määritetty oikeaa kotikansiota hakemistoon \\WINDOWS-SRV-001\kotikansio\leena" -ForegroundColor Red
    }  

    #Leenan kotikansio asemakirjain    
    $LeenanKotikansioKirjain = (Get-ADUser -identity Leena -properties *).HomeDrive
    if ($LeenanKotikansioKirjain -eq "Q:")
        {
        Write-Host "Leenalle on määritetty kotikansion asemakirjaimeksi Q:" -ForegroundColor Green
        }
    else {
        Write-Host "Leenalle ei ole määritetty kotikansion asemakirjaimeksi Q:" -ForegroundColor Red
    }  

    Write-Host "Onhan sama toiminnallisuus lisätty myös muille Riihimäen käyttäjille ja toiminta testattu?" -ForegroundColor Yellow

    #tiedoston ja sisällön tarkistaminen
    $kissatekstiTarkistus = Test-Path -Path C:\kotikansio\leena\kissateksti.txt
    if ($kissatekstiTarkistus -eq "True")
        {
        Write-Host "kissateksti.txt tiedosto löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "kissateksti.txt tiedostoa ei löydy" -ForegroundColor Red
    }

    $kissatekstiSisalto = Get-Content "C:\kotikansio\leena\kissateksti.txt"
    if ($kissatekstiSisalto -eq "kissat ovat parhaita!")
        {
        Write-Host "kissateksti.txt tiedoston sisältö on oikein ja siinä lukee: $kissatekstiSisalto" -ForegroundColor Green
        }
    else {
        Write-Host "kissateksti.txt tiedoston sisältö ei ole oikein" -ForegroundColor Red
    }

    #WindowsServerBackup asennettu
    $WindowsServerBackupAsennettu = (Get-WindowsFeature  | Where-Object {$_.Name -eq "Windows-Server-Backup"}).InstallState
    if ($WindowsServerBackupAsennettu -eq "Installed")
        {
        Write-Host "Windows Server Backup-rooli on asennettu palvelimelle" -ForegroundColor Green
        }
    else {
        Write-Host "Windows Server Backup-roolia ei ole asennettu palvelimelle" -ForegroundColor Red
    }

    Write-Host "Olethan testannut Windows Server Backup toimintaa ja palauttanut jonkin vahingossa poistetun tiedoston?" -ForegroundColor Yellow

    }

    '9' {
    Write-Host "================ Tarkistetaan tehtävä 009 ================"

    #Onko verkkojako SovellusJako olemassa?
    $netshare_SovellusJako = Test-Path \\windows-srv-001\SovellusJako
    if ($netshare_SovellusJako -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\windows-srv-001\SovellusJako" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\windows-srv-001\SovellusJako" -ForegroundColor Red
    }

    #Chrome sovelluksen tarkistaminen
    $chromeSovellusTarkistus = Get-ChildItem -Path C:\Sovellusjako\ -Recurse -Filter *chrome*.msi
    if ($chromeSovellusTarkistus -eq $null)
        {
        Write-Host "Vaikuttaa siltä, että Chromen asennus pakettia ei löydy sijainnista C:\Sovellusjako\ ja/tai se ei ole tyypiltään .MSI tiedosto" -ForegroundColor Red
        }
    else {
        Write-Host "Vaikuttaa siltä, että Chromen asennus paketti löytyy sijainnista C:\Sovellusjako\ ja se on tyypiltään .MSI tiedosto" -ForegroundColor Green
    }

    #GPO asenna Chrome
    $ChromeAsennus = "ChromeAsennus"
    Get-GPOReport -Name $ChromeAsennus -ReportType XML -Path C:\ChromeAsennus.xml
    $ChromeAsennusGPO = Select-String -path C:\ChromeAsennus.xml -Pattern '<q1:Name>Google Chrome</q1:Name>' -SimpleMatch -Context 0, 12 | Out-String -Stream | Select-String -Pattern " <q1:AutoInstall>true<"
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

    Write-Host "Sovellusten asennus ryhmäkäytännöt tehdään User configuration alle" -ForegroundColor Yellow

    #Firefox sovelluksen tarkistaminen
    $FirefoxSovellusTarkistus = Get-ChildItem -Path C:\Sovellusjako\ -Recurse -Filter *Firefox*.msi
    if ($FirefoxSovellusTarkistus -eq $null)
        {
        Write-Host "Vaikuttaa siltä, että Firefoxin asennus pakettia ei löydy sijainnista C:\Sovellusjako\ ja/tai se ei ole tyypiltään .MSI tiedosto" -ForegroundColor Red
        }
    else {
        Write-Host "Vaikuttaa siltä, että Firefoxin asennus paketti löytyy sijainnista C:\Sovellusjako\ ja se on tyypiltään .MSI tiedosto" -ForegroundColor Green
    }

    #GPO asenna Firefox
    $FirefoxAsennus = "FirefoxAsennus"
    Get-GPOReport -Name $FirefoxAsennus -ReportType XML -Path C:\FirefoxAsennus.xml
    $FirefoxAsennusGPO = Select-String -path C:\FirefoxAsennus.xml -Pattern '<q1:Name>Mozilla Firefox' -SimpleMatch -Context 0, 12 | Out-String -Stream | Select-String -Pattern " <q1:AutoInstall>true<"
    if ($FirefoxAsennusGPO -eq $null)
        {
        Write-Host "GPOn $FirefoxAsennus sääntö näyttäisi olevan väärin tehty." -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $FirefoxAsennus sääntö on oikein tehty." -ForegroundColor Green
    }

    #GPO Firefox Published
    $FirefoxAsennusTyyppiGPO = Select-String -path C:\FirefoxAsennus.xml -Pattern 'DeploymentType>Publish' 
    if ($FirefoxAsennusTyyppiGPO -eq $null)
        {
        Write-Host "GPOn $FirefoxAsennus sääntö on tehty niin, että se ei tule käyttäjien manuaalisesti asennettavaksi. Onhan se tyypiltään Published?" -ForegroundColor Red
        }
    else {
        Write-Host "GPOn $FirefoxAsennus sääntö on niin, että se on tyypiltään Published" -ForegroundColor Green
    }

    Write-Host "Sovellusten asennus ryhmäkäytännöt tehdään User configuration alle" -ForegroundColor Yellow

    Write-Host "Chromen hallintaa ryhmäkäytännöillä ei tarkisteta skriptillä. Kokeile rohkeasti saisitko ne toimimaan hyödyntäen hakukoneita ja tekoälyä!" -ForegroundColor Yellow

    }

    }

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause
 }
 until ($selection -eq 'q')
