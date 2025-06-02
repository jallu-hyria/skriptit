ï»¿# Versio 1.00. 24.4.2025. Jalmari Valimaan tikkukirjaimilla koodattu
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/                 


function Show-Menu {
    param (
        [string]$Title = '001 Windows oikeilla laitteilla'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "VihreÃ¤ teksti tarkoittaa, ettÃ¤ tehtÃ¤vÃ¤n kohta on oikein tehty" -ForegroundColor Green
    Write-Host "Punainen teksti tarkoittaa, ettÃ¤ tehtÃ¤vÃ¤n kohta on todennÃ¤kÃ¶isesti vÃ¤Ã¤rin tehty" -ForegroundColor Red
    Write-Host "Keltainen teksti tarkoittaa, ettÃ¤ tehtÃ¤vÃ¤n kohta oli sellainen jota skripti ei osaa tarkistaa" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "Paina '1' tarkistaaksesi tehtÃ¤vÃ¤n: 	     001 Windows oikeilla laitteilla" 
    Write-Host "Paina 'Q' lopettakseesi" 
    Write-Host ""
}

do
 {
    Show-Menu
    $selection = Read-Host "Valitse tehtÃ¤vÃ¤, jonka haluat tarkistaa skriptillÃ¤"
    switch ($selection)
    {


    '1' {

    #Tietokoneen tarkistaminen
    $tietokoneenNimi = $env:COMPUTERNAME

    if ($tietokoneenNimi -eq "win-palvelin-1")
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

    #IIS Oletushakemisto
    $IIS_oletusHakemisto = (Get-IISSite "Default Web Site").Applications.VirtualDirectories.PhysicalPath
    if ($IIS_oletusHakemisto -eq "C:\wwwpalvelin")
        {
        Write-Host "Sivuston oletushakemisto on $IIS_oletusHakemisto" -ForegroundColor Green
        }
    else {
        Write-Host "Sivuston oletushakemisto on $IIS_oletusHakemisto joka on väärin" -ForegroundColor Red
    }

    #Sivun sisältö
    $IIS_sisalto = Get-Content "C:\wwwpalvelin\index.html"
 
    if ($IIS_sisalto -like "*Palvelimet on kivoja!*")
        {
        Write-Host "C:\wwwpalvelin\index.html tiedoston sisältö on oikein ja siinä lukee: $IIS_sisalto" -ForegroundColor Green
        }
    else {
        Write-Host "C:\wwwpalvelin\index.html tiedoston sisältö ei ole oikein" -ForegroundColor Red
    }

    #DNS forward zone
    $DNS_fwZone = (Get-DnsServerZone | Where-Object {$_.ZoneName -eq "firmansivut.local"}).ZoneName
    if ($DNS_fwZone -eq "firmansivut.local")
        {
        Write-Host "DNS alue $DNS_fwZone löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "DNS aluetta $DNS_fwZone ei löydetty" -ForegroundColor Red
    }

    #A tietue
    $DNS_aTietue = (Get-DnsServerResourceRecord -ZoneName "firmansivut.local" | Where-Object {$_.RecordType -eq "A"}).RecordData.IPv4Address.IPAddressToString
    if ($DNS_aTietue -eq "192.168.200.10")
        {
        Write-Host "DNS alueelta löytyy oikea A-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa A-tietuetta" -ForegroundColor Red
    }

    #CNAME tietue
    $DNS_CNAMETietue = (Get-DnsServerResourceRecord -ZoneName "firmansivut.local" | Where-Object {$_.RecordType -eq "CNAME"}).HostName
    if ($DNS_CNAMETietue -eq "www")
        {
        Write-Host "DNS alueelta löytyy oikea CNAME-tietue" -ForegroundColor Green
        }
    else {
        Write-Host "DNS alueelta ei löydy oikeaa CNAME-tietuetta" -ForegroundColor Red
    }

    #Onko verkkojako Xfiles olemassa?
    $netshare_JakoKansio = Test-Path \\win-palvelin-1\xfiles
    if ($netshare_JakoKansio -eq "True")
        {
        Write-Host "Verkkojako löytyy polusta \\win-palvelin-1\xfiles" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojakoa ei löydy polusta \\win-palvelin-1\xfiles" -ForegroundColor Red
    }

    #Onko verkkojaon oikeudet kunnossa JakoKansio
    $netshare_JakoKansioOikeudet = (Get-SmbShareAccess -Name "Xfiles" | Where-Object {$_.AccountName -eq "Everyone"}).AccessRight
    if ($netshare_JakoKansioOikeudet -eq "Full")
        {
        Write-Host "Verkkojaossa JakoKansio ryhmällä Everyone on kaikki oikeudet" -ForegroundColor Green
        }
    else {
        Write-Host "Verkkojaossa JakoKansio ryhmällä Everyone ei ole kaikki oikeudet" -ForegroundColor Red
    }

    Write-Host "Seuraavaksi joudut kirjoittamaan itse Windows työaseman nimen sekä langattomaan verkkoon yhdistetyn puhelimen nimen. Löydät tiedot helposti joko laitteilta itseltään tai katsomalla ne DHCP palvelun Address Leases kohdasta" -ForegroundColor Yellow


    $dhcpTestikone = Read-Host "Anna työasemana toimivan tietokoneen nimi, jotta voidaan tarkistaa onko se saanut IP-asetukset DHCP-palvelulta: "
    $dhcpTestiIP = (Get-DhcpServerv4Lease -ScopeId 192.168.200.0 | Where-Object {$_.HostName -like "*$dhcpTestikone*"}).IPAddress.IPAddressToString

    if ($dhcpTestiIP -eq $null)
        {
        Write-Host "Laitetta nimeltään $dhcpTestikone ei löytynyt DHCP-palvelimelta, jolla olisi jaettu IP-osoite?" -ForegroundColor Red
        }
    else {
        Write-Host "Laitteelle nimeltään $dhcpTestikone on jaettu IP-osoite DHCP-palvelimelta" -ForegroundColor Green

    }

    $dhcpTestipuhelin = Read-Host "Anna puhelimen nimi, joka on liitetty langattomaan verkkoon, jotta voidaan tarkistaa onko se saanut IP-asetukset DHCP-palvelulta: "
    $dhcpTestipuhelinIP = (Get-DhcpServerv4Lease -ScopeId 192.168.200.0 | Where-Object {$_.HostName -like "*$dhcpTestipuhelin*"}).IPAddress.IPAddressToString

    if ($dhcpTestipuhelinIP -eq $null)
        {
        Write-Host "Laitetta nimeltään $dhcpTestipuhelin ei löytynyt DHCP-palvelimelta, jolla olisi jaettu IP-osoite?" -ForegroundColor Red
        }
    else {
        Write-Host "Laitteelle nimeltään $dhcpTestipuhelin on jaettu IP-osoite DHCP-palvelimelta" -ForegroundColor Green

    }


		
		
		
		
	}
	
}

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause

 }
 until ($selection -eq 'q')
