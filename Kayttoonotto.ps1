if ((Test-Path -Path "HKCU:\Software\Osio1\") -eq $False) {

	# ---------- Osio 1 ----------
		
	#Muuttujat eri asioille
	$NIC_ifIndex = (Get-NetAdapter -Name "Ethernet").ifindex
	$NIC_gateway = (Get-Netroute -DestinationPrefix 0.0.0.0/0).nexthop
	$NIC_IPaddress = (Get-NetIPAddress -InterfaceIndex $NIC_ifIndex).IPAddress

	#Poistetaan IP-asetukset verkkokortilta, jos sellaiset olisi
	Remove-NetIPAddress -IPAddress $NIC_IPaddress -InterfaceIndex $NIC_ifIndex -DefaultGateway $NIC_gateway -Confirm:$false

	#Asetetaan IP-asetukset verkkokortille
	New-NetIPAddress -InterfaceIndex $NIC_ifIndex -IPAddress 192.168.1.20 -PrefixLength 24 -DefaultGateway 192.168.1.1
	Set-DnsClientServerAddress -InterfaceIndex $NIC_ifIndex -ServerAddresses ("8.8.8.8")

	#Uudelleennimetaan tietokone
	Rename-Computer -NewName "windows-srv-001"

	#Luodaan uusi rekisteripolku, jolla testataan logiikka
	New-Item -Path "HKCU:\Software\Osio1" -Force
	#Luodaan uusi taski, joka ajetaan seuraavan rebootin jalkeen
	$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
	$principal = New-ScheduledTaskPrincipal -UserID "Administrator" -RunLevel Highest
	$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "-ExecutionPolicy Bypass C:\Kayttoonotto.ps1"
	$trigger = New-ScheduledTaskTrigger -AtLogOn
	Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Kayttoonotto_tehtava" -Principal $principal -Settings $settings

	Write-Host "Palvelimen IP-asetukset ja nimi on asetettu" -ForegroundColor green
	Write-Host "Palvelin uudelleenkäynnistetään noin 10 sekunnin kuluttua!!!" -ForegroundColor green

	Start-Sleep 10
	Restart-Computer -Force
}

if (((Test-Path -Path "HKCU:\Software\Osio1\") -eq $True) -and ((Test-Path -Path "HKCU:\Software\Osio2\") -eq $False))  {

	# ---------- Osio 2 ----------

	#Luodaan toimialue niminen kansio C aseman juureen
	#Asennetaan DHCP ja toimialue palvelut palvelimelle
	$AD_name = "hyriadesk.net"

	New-Item -Name "toimialue" -Path "C:\" -ItemType Directory
	Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
	Install-WindowsFeature DHCP -IncludeManagementTools

	#Ylennetaan toimialue ja asetetaan sille haluttu nimi

	Import-Module ADDSDeployment
	Install-ADDSForest -SkipPreChecks:$true -CreateDnsDelegation:$false -DomainName $AD_name -DomainNetbiosName "HYRIADESK"  -LogPath "C:\toimialue\Log" -DatabasePath "C:\toimialue\DB" -SysvolPath "C:\toimialue\SYSVOL" -InstallDns:$true -SafeModeAdministratorPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force) -NoRebootOnCompletion:$true -Confirm:$false
	
	#Rekisteriavain logiikkaa varten
	New-Item -Path "HKCU:\Software\Osio2" -Force
	
	Write-Host "Toimialue ja DHCP palvelu asennettu" -ForegroundColor green
	Write-Host "Toimialue ylennetty ja nimeksi asetettu" $AD_name -ForegroundColor green
	Write-Host "Palvelin uudelleenkäynnistetään noin 10 sekunnin kuluttua!!!" -ForegroundColor green
	
	Start-Sleep 10
	Restart-Computer -Force

}

if ((Test-Path -Path "HKCU:\Software\Osio2\") -eq $True) {
	
	# ---------- Osio 2 ----------
	
	#Toimialueen nimi muuttujaan
	$AD_name = "hyriadesk.net"
	Set-TimeZone -Name "FLE Standard Time" -PassThru
	#Autorisoidaan DHCP palvelu toimialueen asentamisen jalkeen
	Get-DhcpServerInDC | Where-Object DNSName -EQ (([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname)  | Remove-DhcpServerInDC ; Add-DhcpServerInDc -DnsName (([System.Net.Dns]::GetHostByName(($env:computerName))).Hostname)

	#Konfiguroidaan DHCP halutusti
	Add-DhcpServerv4Scope -Name "Hyriadesk jakoalue" -StartRange 192.168.1.50 -EndRange 192.168.1.90 -SubnetMask 255.255.255.0 -LeaseDuration 0.15:00:00 -State Active
	Set-DhcpServerv4OptionValue -ScopeId "192.168.1.0" -DnsServer 192.168.1.20 -DnsDomain $AD_name -Router 192.168.1.1
	Add-DhcpServerv4ExclusionRange -ScopeId "192.168.1.0" -StartRange 192.168.1.70 -EndRange 192.168.1.80

	#Toimialueen OU:t, ryhmat, kayttajat
	New-ADOrganizationalUnit -Name "HyriaDesk" -Path "DC=hyriadesk,DC=net"
	New-ADOrganizationalUnit -Name "IT-tuki" -Path "DC=hyriadesk,DC=net"
	New-ADOrganizationalUnit -Name "Riihimäki" -Path "OU=HyriaDesk, DC=hyriadesk,DC=net"
	New-ADOrganizationalUnit -Name "Turku" -Path "OU=HyriaDesk, DC=hyriadesk,DC=net"

	New-ADOrganizationalUnit -Name "Tietokoneet" -Path "OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net"
	New-ADOrganizationalUnit -Name "Käyttäjät" -Path "OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net"
	New-ADOrganizationalUnit -Name "Valmentajat" -Path "OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net"


	New-ADOrganizationalUnit -Name "Tietokoneet" -Path "OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net"
	New-ADOrganizationalUnit -Name "Käyttäjät" -Path "OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net"

	New-ADGroup -Name "RiihimakiDevices" -SamAccountName RiihimakiDevices -GroupCategory Security -GroupScope Global -DisplayName "RiihimakiDevices" -Path "OU=Tietokoneet, OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net"
	New-ADGroup -Name "RiihimakiUsers" -SamAccountName RiihimakiUsers -GroupCategory Security -GroupScope Global -DisplayName "RiihimakiUsers" -Path "OU=Käyttäjät, OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net"

	New-ADGroup -Name "TurkuDevices" -SamAccountName TurkuDevices -GroupCategory Security -GroupScope Global -DisplayName "TurkuDevices" -Path "OU=Tietokoneet, OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net"
	New-ADGroup -Name "TurkuUsers" -SamAccountName TurkuUsers -GroupCategory Security -GroupScope Global -DisplayName "TurkuUsers" -Path "OU=Käyttäjät, OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net"

	New-ADUser -Name template_user -SamAccountName template_user -ChangePasswordAtLogon $false -Path "OU=HyriaDesk, DC=hyriadesk,DC=net"

	New-ADUser -Name matti -SamAccountName matti -UserPrincipalName matti@$AD_name -ChangePasswordAtLogon $false -Path "OU=Käyttäjät, OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net" -Enabled $true -AccountPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force)
	New-ADUser -Name mikko -SamAccountName mikko -UserPrincipalName mikko@$AD_name -ChangePasswordAtLogon $false -Path "OU=Käyttäjät, OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net" -Enabled $true -AccountPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force)
	New-ADUser -Name jussi -SamAccountName jussi -UserPrincipalName jussi@$AD_name -ChangePasswordAtLogon $false -Path "OU=Käyttäjät, OU=Turku, OU=HyriaDesk, DC=hyriadesk,DC=net" -Enabled $true -AccountPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force)

	New-ADUser -Name juho -SamAccountName juho -UserPrincipalName juho@$AD_name -ChangePasswordAtLogon $false -Path "OU=IT-tuki, DC=hyriadesk,DC=net" -Enabled $true -AccountPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force)
	New-ADUser -Name maria -SamAccountName maria -UserPrincipalName maria@$AD_name -ChangePasswordAtLogon $false -Path "OU=Käyttäjät, OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net" -Enabled $true -AccountPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force)
	New-ADUser -Name leena -SamAccountName leena -UserPrincipalName leena@$AD_name -ChangePasswordAtLogon $false -Path "OU=Käyttäjät, OU=Riihimäki, OU=HyriaDesk, DC=hyriadesk,DC=net" -Enabled $true -AccountPassword (ConvertTo-SecureString "Sala1234" -AsPlainText -Force)

	Add-ADGroupMember -Identity "TurkuUsers" -Members matti, mikko
	Add-ADGroupMember -Identity "RiihimakiUsers" -Members maria
	
	#Toimialueen roskakori
	Enable-ADOptionalFeature -Identity 'CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=hyriadesk,DC=net' -Scope ForestOrConfigurationSet -Target "$AD_name" -Confirm:$false
	
	#Poistetaan tehtava ja rekisteriavaimet
	Unregister-ScheduledTask -TaskName "Kayttoonotto_tehtava" -Confirm:$false
	Remove-Item -Path "HKCU:\Software\Osio1\"
	Remove-Item -Path "HKCU:\Software\Osio2\"
	
	Write-Host "Aikavyöhyke asetettu, DHCP palvelu autorisoitu ja jakoalue luotu" -ForegroundColor green
	Write-Host "Toimialueen objektit, organisaatioyksiköt, ryhmät ja käyttäjät luotu. AD roskakori otettu käyttöön" -ForegroundColor green
	Write-Host "Palvelin ja toimialue on nyt valmiina harjoituksia varten!!!" -ForegroundColor green
	Write-Host "Voit sulkea tämän komentokehotteen nyt" -ForegroundColor green	
	Start-Sleep 30	
	
}



