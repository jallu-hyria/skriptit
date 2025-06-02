# Versio 1.00. 24.4.2025. Jalmari Valimaan tikkukirjaimilla koodattu
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/                 


function Show-Menu {
    param (
        [string]$Title = '002 Windows oikealla palvelimella'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "Vihreä teksti tarkoittaa, että tehtävän kohta on oikein tehty" -ForegroundColor Green
    Write-Host "Punainen teksti tarkoittaa, että tehtävän kohta on todennäköisesti väärin tehty" -ForegroundColor Red
    Write-Host "Keltainen teksti tarkoittaa, että tehtävän kohta oli sellainen jota skripti ei osaa tarkistaa" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "Paina '1' tarkistaaksesi tehtävän: 	     002 Windows oikealla palvelimella" 
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

    if ($tietokoneenNimi -eq "win-hw-001")
        {
        Write-Host "Tietokoneen nimi on $tietokoneenNimi eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Tietokoneen nimi on $tietokoneenNimi eli v��rin" -ForegroundColor Red
    }

    #Mistä verkkokortista IP-osoite haetaan
    $IP_NIC = (Get-NetIpAddress -AddressFamily IPv4 | Select-Object -Property InterfaceAlias, IpAddress | Where-Object -Property Ipaddress -like *10.3.*).InterfaceAlias
    #IP-asetusten tarkistaminen
    $IP_osoite = (Get-Netipaddress -InterfaceAlias $IP_NIC -AddressFamily IPv4).IPAddress

    #IP-osoite
    if ($IP_osoite -like "*10.3.185.*")
        {
        Write-Host "IP-osoite on $IP_osoite eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "IP-osoite on $IP_osoite eli v��rin" -ForegroundColor Red
    }

    #Aliverkonmaski
    $aliverkonMaski = (Get-Netipaddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).PrefixLength

    if ($aliverkonMaski -eq "21")
        {
        Write-Host "Aliverkonmaski on /$aliverkonMaski eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Aliverkonmaski on /$aliverkonMaski eli v��rin" -ForegroundColor Red
    }

    #Oletusyhdysk�yt�v�
    $oletusYhdyskaytava = (Get-NetIPConfiguration -InterfaceAlias "Ethernet").IPv4DefaultGateway.NextHop
    if ($oletusYhdyskaytava -eq "10.3.184.1")
        {
        Write-Host "Oletusyhdysk�yt�v� on $oletusYhdyskaytava eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Oletusyhdysk�yt�v� on $oletusYhdyskaytava eli v��rin" -ForegroundColor Red
    }

    #DNS-osoite
    $dnsOsoite = (Get-DnsClientServerAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4).ServerAddresses

    if ($dnsOsoite -eq "10.3.184.2")
        {
        Write-Host "DNS on $dnsOsoite eli oikein" -ForegroundColor Green
        }
    else {
        Write-Host "DNS on $dnsOsoite eli v��rin" -ForegroundColor Red
    }

    #Internet yhteyden testaaminen
    $yhteysTesti = (Test-Connection 8.8.8.8 -Quiet)

    if ($yhteysTesti -eq "True")
        {
        Write-Host "Yhteytt� testattu osoitteeseen 8.8.8.8, yhteys onnistui" -ForegroundColor Green
        }
    else {
        Write-Host "Yhteytt� testattu osoitteeseen 8.8.8.8, yhteys ei onnistunut" -ForegroundColor Red
    }


    Write-Host "Onhan Firefox tai Chrome asennettu?" -ForegroundColor Yellow
    Write-Host "Onhan ajureita asennettu?" -ForegroundColor Yellow

    #Teamviewer asennettu?
    $teamviewerPolku = "C:\Program Files\TeamViewer\TeamViewer.exe"
    $teamviewerTarkistus = Test-Path -Path $teamviewerPolku
    
    if ($teamviewerTarkistus -eq "True")
        {
        Write-Host "TeamViewer l�ytyy sijainnista $teamviewerPolku" -ForegroundColor Green
        }
    else {
        Write-Host "TeamViewera ei l�ydy sijainnista $teamviewerPolku" -ForegroundColor Red
    }

    #Ryhmien j�senyydet
    $petjaRyhma1 = (Get-LocalGroupMember -Group "Remote Desktop Users" | Where-Object {$_.Name -like "*petja*"}).Name
    if ($petjaRyhma1 -like "*petja*")
        {
        Write-Host "K�ytt�j� nimelt��n $petjaRyhma1 on oikeassa ryhm�ss� Remote Desktop Users" -ForegroundColor Green
        }
    else {
        Write-Host "K�ytt�j� nimelt��n $petjaRyhma1 ei ole oikeassa ryhm�ss� Remote Desktop Users" -ForegroundColor Red
    }

    #Ryhmien j�senyydet
    $petjaRyhma2 = (Get-LocalGroupMember -Group "Remote Management Users" | Where-Object {$_.Name -like "*petja*"}).Name
    if ($petjaRyhma2 -like "*petja*")
        {
        Write-Host "K�ytt�j� nimelt��n $petjaRyhma1 on oikeassa ryhm�ss� Remote Management Users" -ForegroundColor Green
        }
    else {
        Write-Host "K�ytt�j� nimelt��n $petjaRyhma1 ei ole oikeassa ryhm�ss� Remote Management Users" -ForegroundColor Red
    }

    #Ryhmien j�senyydet
    $jalluRyhma1 = (Get-LocalGroupMember -Group "Backup Operators" | Where-Object {$_.Name -like "*jallu*"}).Name
    if ($jalluRyhma1 -like "*jallu*")
        {
        Write-Host "K�ytt�j� nimelt��n $jalluRyhma1 on oikeassa ryhm�ss� Backup Operators" -ForegroundColor Green
        }
    else {
        Write-Host "K�ytt�j� nimelt��n $jalluRyhma1 ei ole oikeassa ryhm�ss� Backup Operators" -ForegroundColor Red
    }

    #Ryhmien j�senyydet
    $jalluRyhma2 = (Get-LocalGroupMember -Group "Print Operators" | Where-Object {$_.Name -like "*jallu*"}).Name
    if ($jalluRyhma2 -like "*jallu*")
        {
        Write-Host "K�ytt�j� nimelt��n $jalluRyhma1 on oikeassa ryhm�ss� Print Operators" -ForegroundColor Green
        }
    else {
        Write-Host "K�ytt�j� nimelt��n $jalluRyhma1 ei ole oikeassa ryhm�ss� Print Operators" -ForegroundColor Red
    }

    #IIS directory browsing
    $IIS_directoryBrowsing = (Get-WebConfigurationProperty -filter /system.webServer/directoryBrowse -name enabled -PSPath 'IIS:\Sites\Default Web Site').Value
    if ($IIS_directoryBrowsing -eq "True")
        {
        Write-Host "Sivuston directory browsing on p��ll�" -ForegroundColor Green
        }
    else {
        Write-Host "Sivuston directory browsing ei ole p��ll�" -ForegroundColor Red
    }

    #IIS Oletushakemisto
    $IIS_oletusHakemisto = (Get-IISSite "Default Web Site").Applications.VirtualDirectories.PhysicalPath
    if ($IIS_oletusHakemisto -eq "C:\inetpub\tiedostojako")
        {
        Write-Host "Sivuston oletushakemisto on $IIS_oletusHakemisto" -ForegroundColor Green
        }
    else {
        Write-Host "Sivuston oletushakemisto on $IIS_oletusHakemisto joka on v��rin" -ForegroundColor Red
    }

    #Sivun sis�lt�
    $IIS_sisalto = Get-Content "C:\inetpub\tiedostojako\README.txt"
 
    if ($IIS_sisalto -eq "Very important content to FTP-server for Ubuntu Server exercise.")
        {
        Write-Host "C:\inetpub\tiedostojako\README.txt tiedoston sis�lt� on oikein eli directory browsing jakaa ftp_content.zip sis�lt�j�" -ForegroundColor Green
        }
    else {
        Write-Host "C:\inetpub\tiedostojako\README.txt tiedoston sis�lt� ei ole oikein. Oletko varmasti purkanut ftp_content.zip sis�ll�n oikeaan paikkaan?" -ForegroundColor Red
    }

    Write-Host "Onhan Directory Browsing toiminta testattu ty�asemalta k�sin?" -ForegroundColor Yellow

    #WindowsServerBackup asennettu
    $WindowsServerBackupAsennettu = (Get-WindowsFeature  | Where-Object {$_.Name -eq "Windows-Server-Backup"}).InstallState
    if ($WindowsServerBackupAsennettu -eq "Installed")
        {
        Write-Host "Windows Server Backup-rooli on asennettu palvelimelle" -ForegroundColor Green
        }
    else {
        Write-Host "Windows Server Backup-roolia ei ole asennettu palvelimelle" -ForegroundColor Red
    }

    Write-Host "Onhan varmuuskopion ottaminen ja tietojen palauttaminen testattu?" -ForegroundColor Yellow

    Write-Host "Petja ei voi k�ytt�� varmuuskopointia, koska h�nell� ei ole siihen oikeuksia. H�nell� olisi oikeudet et�yhteyksiin?" -ForegroundColor Yellow
    Write-Host "Jallu voi k�ytt�� varmuuskopointia, koska h�nell� on siihen oikeudet" -ForegroundColor Yellow
		
	}
	
}

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause

 }
 until ($selection -eq 'q')