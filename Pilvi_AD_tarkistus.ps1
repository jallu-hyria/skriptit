# Versio 1.00. 7.8.2026 Jalmari Välimaan tikkukirjaimilla tehty
#      ____.      .__  .__         
#     |    |____  |  | |  |  __ __ 
#     |    \__  \ |  | |  | |  |  \
# /\__|    |/ __ \|  |_|  |_|  |  /
# \________(____  /____/____/____/ 
#              \/                 

#Kirjoita tämän muuttujan arvoksi toimialueesi domain nimi!
#esimerkiksi näin: $domainNimi = "@pilviad.onmicrosoft.com"
$domainNimi = "@pilviad.onmicrosoft.com"

#Kirjoita tämän muuttujan arvoksi toimialueesi admin käyttäjän tunnus!
#esimerkiksi näin: $adminTili = "jallu@pilviad.onmicrosoft.com"
$adminTili = "jallu@pilviad.onmicrosoft.com"

# Katsotaan onko Entra Powershell moduuli asennettu. Jos ei ole niin asennetaan se
$moduuliAsennettu = (Get-InstalledModule -Name Microsoft.Entra).Name
if ($moduuliAsennettu -eq "Microsoft.Entra")
	{
	Write-Host "Entra moduuli on jo asennettu Powershelliin. Katsotaan löytyykö myös Entran Beta moduuli!" -ForegroundColor Green
	}
else {
	Write-Host "Entra Powershell moduulia ei ole asennettu. Asennetaan se. Tässä voi kestää hetki!" -ForegroundColor Red
	Install-Module -Name Microsoft.Entra -Repository PSGallery -Scope AllUsers -Force -AllowClobber
}

$moduuliAsennettuBeta = (Get-InstalledModule -Name Microsoft.Entra.Beta).Name
if ($moduuliAsennettuBeta -eq "Microsoft.Entra.Beta")
	{
	Write-Host "Entra Beta moduuli on jo asennettu Powershelliin. Kirjaudutaan omaan pilvi toimialueeseesi!" -ForegroundColor Green
	}
else {
	Write-Host "Entra Beta Powershell moduulia ei ole asennettu. Asennetaan se. Tässä voi kestää hetki!" -ForegroundColor Red
	Install-Module -Name Microsoft.Entra.Beta -Repository PSGallery -Scope AllUsers -Force -AllowClobber
}

$moduuliAsennettuExchange = (Get-InstalledModule -Name ExchangeOnlineManagement).Name
if ($moduuliAsennettuExchange -eq "ExchangeOnlineManagement")
	{
	Write-Host "ExchangeOnlineManagement moduuli on jo asennettu Powershelliin. Kirjaudutaan omaan pilvi toimialueeseesi!" -ForegroundColor Green
	}
else {
	Write-Host "ExchangeOnlineManagement Powershell moduulia ei ole asennettu. Asennetaan se. Tässä voi kestää hetki!" -ForegroundColor Red
	Install-Module -Name ExchangeOnlineManagement -Repository PSGallery -Scope AllUsers -Force -AllowClobber
}

Write-Host "Pyydettäessä anna pilvi toimialueesi Admin tasoiset tunnukset, jotta skripti voi tarkistaa sieltä asioita" -ForegroundColor Green
Connect-Entra -Scopes 'User.Read.All', 'Group.Read.All', 'GroupMember.Read.All', 'Organization.Read.All', 'LicenseAssignment.Read.All', 'AuditLog.Read.All', 'UserAuthenticationMethod.Read.All', 'Directory.Read.All', 'Policy.Read.All', 'DeviceManagementManagedDevices.Read.All', 'DeviceManagementServiceConfig.Read.All', 'DeviceManagementConfiguration.Read.All', 'DeviceManagementApps.Read.All', 'DeviceManagementScripts.Read.All'

function Show-Menu {
    param (
        [string]$Title = 'Toimialue pilvipalveluna'
    )

    Write-Host "================ $Title ================"
    Write-Host ""
    Write-Host "Vihreä teksti tarkoittaa, että tehtävän kohta on oikein tehty" -ForegroundColor Green
    Write-Host "Punainen teksti tarkoittaa, että tehtävän kohta on todennäköisesti väärin tehty" -ForegroundColor Red
    Write-Host "Keltainen teksti tarkoittaa, että tehtävän kohta oli sellainen jota skripti ei osaa tarkistaa" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "Paina '1' tarkistaaksesi tehtävän: 	     001 Käyttäjät ja ryhmät" 
    Write-Host "Paina '2' tarkistaaksesi tehtävän: 	     002 Salasanat" 
    Write-Host "Paina '3' tarkistaaksesi tehtävän: 	     003 Powershell" 
    Write-Host "Paina '4' tarkistaaksesi tehtävän: 	     004 Monitorointi" 
    Write-Host "Paina '5' tarkistaaksesi tehtävän: 	     005 Windows enrollment" 
    Write-Host "Paina '6' tarkistaaksesi tehtävän: 	     006 Windows laitteiden hallinta"
    Write-Host "Paina '7' tarkistaaksesi tehtävän: 	     007 Windows sovellukset ja skriptit" 
    Write-Host "Paina '8' tarkistaaksesi tehtävän: 	     008 Android" 
    Write-Host "Paina '9' tarkistaaksesi tehtävän: 	     009 Microsoft 365" 
    Write-Host "Paina '10' tarkistaaksesi tehtävän: 	     010 Conditional access" 
    Write-Host "Paina '11' tarkistaaksesi tehtävän: 	     011 Entra Connect" 
    Write-Host "Paina '12' tarkistaaksesi tehtävän: 	     012 Autopilot" 
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
	
	# Tarkistetaan ryhmät ja että ne ovat Security tyyppisiä ryhmiä
    $MarkkinointiRyhma = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Markkinointi"}).DisplayName
    if ($MarkkinointiRyhma -eq "Markkinointi")
        {
        Write-Host "Ryhmä nimeltään Markkinointi löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään Markkinointi ei löydy" -ForegroundColor Red
    }

    $MarkkinointiRyhmaTyyppi = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Markkinointi"}).securityenabled
    if ($MarkkinointiRyhmaTyyppi -eq "True")
        {
        Write-Host "Ryhmä nimeltään Markkinointi on tyypiltään Security ryhmä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään Markkinointi ei ole tyypiltään Security" -ForegroundColor Red
    }
	
    $TalousRyhma = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Talous"}).DisplayName
    if ($TalousRyhma -eq "Talous")
        {
        Write-Host "Ryhmä nimeltään Talous löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään Talous ei löydy" -ForegroundColor Red
    }
	
    $TalousRyhmaTyyppi = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Talous"}).securityenabled
    if ($TalousRyhmaTyyppi -eq "True")
        {
        Write-Host "Ryhmä nimeltään Talous on tyypiltään Security ryhmä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään Talous ei ole tyypiltään Security" -ForegroundColor Red
    }
	
    $TietohallintoRyhma = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Tietohallinto"}).DisplayName
    if ($TietohallintoRyhma -eq "Tietohallinto")
        {
        Write-Host "Ryhmä nimeltään Tietohallinto löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään Tietohallinto ei löydy" -ForegroundColor Red
    }
	
    $TietohallintoRyhmaTyyppi = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Tietohallinto"}).securityenabled
    if ($TietohallintoRyhmaTyyppi -eq "True")
        {
        Write-Host "Ryhmä nimeltään Tietohallinto on tyypiltään Security ryhmä" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään Tietohallinto ei ole tyypiltään Security" -ForegroundColor Red
    }

	# Tarkistetaan käyttäjät

    $userMartti = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "martti.a$domainNimi"}).UserPrincipalName
    if ($userMartti -eq "martti.a$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userMartti löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Martti ei löydy" -ForegroundColor Red
    }
	
    $userTarja = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Tarja.h$domainNimi"}).UserPrincipalName
    if ($userTarja -eq "Tarja.h$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userTarja löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Tarja ei löydy" -ForegroundColor Red
    }
	
    $userUrho = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Urho.k$domainNimi"}).UserPrincipalName
    if ($userUrho -eq "Urho.k$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userUrho löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Urho ei löydy" -ForegroundColor Red
    }	
	
    $userAnneli = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Anneli.k$domainNimi"}).UserPrincipalName
    if ($userAnneli -eq "Anneli.k$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userAnneli löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Anneli ei löydy" -ForegroundColor Red
    }	

    $userSanna = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Sanna.v$domainNimi"}).UserPrincipalName
    if ($userSanna -eq "Sanna.v$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userSanna löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Sanna ei löydy" -ForegroundColor Red
    }

    $userKyosti = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Kyosti.k$domainNimi"}).UserPrincipalName
    if ($userKyosti -eq "Kyosti.k$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userKyosti löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Kyosti ei löydy" -ForegroundColor Red
    }

	#Käyttäjien ryhmäjäsenyydet
	
    $userMarttiG = (Get-EntraUserGroup -UserId "martti.a$domainNimi" | Where-Object {$_.DisplayName -eq "Markkinointi"}).displayName
    if ($userMarttiG -eq "Markkinointi")
        {
        Write-Host "Käyttäjä nimeltään $userMartti on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Martti ei ole ryhmässä Markkinointi" -ForegroundColor Red
    }

    $userTarjaG = (Get-EntraUserGroup -UserId "Tarja.h$domainNimi" | Where-Object {$_.DisplayName -eq "Markkinointi"}).displayName
    if ($userTarjaG -eq "Markkinointi")
        {
        Write-Host "Käyttäjä nimeltään $userTarja on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Tarja ei ole ryhmässä Markkinointi" -ForegroundColor Red
    }
	
    $userUrhoG = (Get-EntraUserGroup -UserId "Urho.k$domainNimi" | Where-Object {$_.DisplayName -eq "Talous"}).displayName
    if ($userUrhoG -eq "Talous")
        {
        Write-Host "Käyttäjä nimeltään $userUrho on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Urho ei ole ryhmässä Talous" -ForegroundColor Red
    }

    $userAnneliG = (Get-EntraUserGroup -UserId "Anneli.k$domainNimi" | Where-Object {$_.DisplayName -eq "Talous"}).displayName
    if ($userAnneliG -eq "Talous")
        {
        Write-Host "Käyttäjä nimeltään $userAnneli on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Anneli ei ole ryhmässä Talous" -ForegroundColor Red
    }

    $userSannaG = (Get-EntraUserGroup -UserId "Sanna.v$domainNimi" | Where-Object {$_.DisplayName -eq "Tietohallinto"}).displayName
    if ($userSannaG -eq "Tietohallinto")
        {
        Write-Host "Käyttäjä nimeltään $userSanna on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Sanna ei ole ryhmässä Tietohallinto" -ForegroundColor Red
    }
	
    $userKyostiG = (Get-EntraUserGroup -UserId "Kyosti.k$domainNimi" | Where-Object {$_.DisplayName -eq "Tietohallinto"}).displayName
    if ($userKyostiG -eq "Tietohallinto")
        {
        Write-Host "Käyttäjä nimeltään $userKyosti on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Kyosti ei ole ryhmässä Tietohallinto" -ForegroundColor Red
    }
	
    $userJallu = (Get-EntraUser | Where-Object {$_.displayName -eq "Jallu"}).displayName
    if ($userJallu -eq "Jallu")
        {
        Write-Host "Käyttäjä nimeltään Jallu löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Jallu ei löydy" -ForegroundColor Red
    }
	
    $userJalluGuest = (Get-EntraUser | Where-Object {$_.displayName -eq "Jallu"}).userType
    if ($userJalluGuest -eq "Guest")
        {
        Write-Host "Käyttäjä nimeltään Jallu on vieras tyyppinen tili" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Jallu ei ole vieras tyyppinen tili" -ForegroundColor Red
    }

    $userrikottu = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "rikottulasi$domainNimi"}).UserPrincipalName
    if ($userrikottu -eq "rikottulasi$domainNimi")
        {
        Write-Host "Käyttäjä nimeltään $userrikottu löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään rikottulasi ei löydy" -ForegroundColor Red
    }
	
	# Global admin ja muut roolit tulevat RoleTemplateId arvon mukaisesti, joka on vakio kaikissa Entra tenanteissa
	$rikottuGlobalAdmin = (Get-EntraUserRole -UserId "rikottulasi$domainNimi" | Where-Object {$_.RoleTemplateId -eq "62e90394-69f5-4237-9190-012177145e10"}).RoleTemplateId
    if ($rikottuGlobalAdmin -eq "62e90394-69f5-4237-9190-012177145e10")
        {
        Write-Host "Käyttäjä nimeltään $userrikottu on Global Administrator" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään rikottulasi ei ole Global Administrator" -ForegroundColor Red
    }

	# Katsotaan lisenssit
	
	$SannaLisenssi = (Get-EntraUserLicenseDetail -UserId "Sanna.v$domainNimi").SkuPartNumber
    if ($SannaLisenssi -eq "DEVELOPERPACK_E5")
        {
        Write-Host "Käyttäjällä nimeltään $userSanna on lisenssi" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään Sanna ei ole lisenssiä" -ForegroundColor Red
    }
	
	$SannaLisenssiPerinto = (Get-EntraUser -UserId "sanna.v$domainNimi").licenseAssignmentStates.assignedbygroup
	if ($SannaLisenssiPerinto -ne $null)
        {
        Write-Host "Käyttäjällä nimeltään $userSanna on lisenssi ryhmän kautta (inherited)" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään Sanna ei ole lisenssiä ryhmän kautta (inherited)" -ForegroundColor Red
    }	
	
	# Katsotaan käyttäjien roolit
	$SannaGlobalAdmin = (Get-EntraUserRole -UserId "Sanna.v$domainNimi" | Where-Object {$_.RoleTemplateId -eq "62e90394-69f5-4237-9190-012177145e10"}).RoleTemplateId
    if ($SannaGlobalAdmin -eq "62e90394-69f5-4237-9190-012177145e10")
        {
        Write-Host "Käyttäjä nimeltään $userSanna on Global Administrator" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Sanna ei ole Global Administrator" -ForegroundColor Red
    }
	
	$KyostiIntuneAdmin = (Get-EntraUserRole -UserId "Kyosti.k$domainNimi" | Where-Object {$_.RoleTemplateId -eq "3a2c62db-5318-420d-8d74-23affee5d9d5"}).RoleTemplateId
    if ($KyostiIntuneAdmin -eq "3a2c62db-5318-420d-8d74-23affee5d9d5")
        {
        Write-Host "Käyttäjä nimeltään $userKyosti on Intune Administrator" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Kyosti ei ole Intune Administrator" -ForegroundColor Red
    }
	
    $userUrhoEN = (Get-EntraUser -UserId "urho.k$domainNimi").accountEnabled
    if ($userUrhoEN -eq $False)
        {
  		Write-Host "Käyttäjän Urho tili on disabloitu" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän Urho tiliä ei ole disabloitu" -ForegroundColor Red
    }	
    } 

    '2' {
    Write-Host "================ Tarkistetaan tehtävä 002 ================"

	Write-Host "Olethan harjoitellut käyttäjän salasanan resetoimista?" -ForegroundColor Yellow
    $userAnneliID = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "anneli.k$domainNimi"}).Id
	$userAnneliSSPR = (Invoke-MgGraphRequest -Method Get -Uri https://graph.microsoft.com/v1.0/reports/authenticationMethods/userRegistrationDetails/$userAnneliID).isSsprRegistered
    if ($userAnneliSSPR -eq $True)
        {
        Write-Host "Käyttäjällä nimeltään Anneli on käytössä SSPR" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään Anneli ei ole käytössä SSPR" -ForegroundColor Red
    }

    $userMarttiID = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Martti.a$domainNimi"}).Id
	$userMarttiSSPR = (Invoke-MgGraphRequest -Method Get -Uri https://graph.microsoft.com/v1.0/reports/authenticationMethods/userRegistrationDetails/$userMarttiID).isSsprRegistered
    if ($userMarttiSSPR -eq $False)
        {
        Write-Host "Käyttäjällä nimeltään Martti ei ole käytössä SSPR koska hän ei ole Talous ryhmän jäsen" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään Martti on käytössä SSPR" -ForegroundColor Red
    }

	Write-Host "Olethan testannut SSPR toiminnan Anneli käyttäjällä?" -ForegroundColor Yellow

	$Bantime = (Get-MgBetaDirectorySetting | Where-Object {$_.TemplateId -eq "5cf42378-d67d-4f36-ba46-e8b86229381d"} | Select -ExpandProperty Values | Where-Object {$_.Name -eq "LockoutDurationInSeconds"}).Value
	if ($Bantime -eq "300") {
        Write-Host "Toimialueen kirjautumisrajoitukset ovat niin, että käyttäjä ei voi kirjautua uudestaan 5 minuuttiin (300 sekuntia) jos tili lukitaan" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueen kirjautumisrajoitukset ovat niin, että käyttäjän tili ei suljeudu 5 minuutin (300 sekuntia) ajaksi jos tili lukitaan" -ForegroundColor Red
	}
	
	$Bantries = (Get-MgBetaDirectorySetting | Where-Object {$_.TemplateId -eq "5cf42378-d67d-4f36-ba46-e8b86229381d"} | Select -ExpandProperty Values | Where-Object {$_.Name -eq "LockoutThreshold"}).Value
	if ($Bantries -eq "4") {
        Write-Host "Toimialueen kirjautumisrajoitukset ovat niin, että käyttäjän tili lukitaan jos epäonnistuneita kirjautumisyrityksiä on enemmän kuin 4" -ForegroundColor Green
        }
    else {
        Write-Host "Toimialueen kirjautumisrajoitukset ovat niin, että käyttäjän tiliä ei lukita jos epäonnistuneita kirjautumisyrityksiä on enemmän kuin 4" -ForegroundColor Red
	}

    $userAnneliID = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "anneli.k$domainNimi"}).Id
	$userAnneliMFA = (Invoke-MgGraphRequest -Method Get -Uri https://graph.microsoft.com/v1.0/reports/authenticationMethods/userRegistrationDetails/$userAnneliID).isMfaRegistered
    if ($userAnneliMFA -eq $True)
        {
        Write-Host "Käyttäjällä nimeltään Anneli on käytössä MFA" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään Anneli ei ole käytössä MFA" -ForegroundColor Red
    }
	
	Write-Host "Olethan harjoitellut MFA resetoimista?" -ForegroundColor Yellow

    } 

    '3' {
    Write-Host "================ Tarkistetaan tehtävä 003 ================"

	Write-Host "Tässä tehtävässä ei ole skriptillä tarkistettavaa" -ForegroundColor Yellow

    }

    '4' {
    Write-Host "================ Tarkistetaan tehtävä 004 ================"

	Write-Host "Tässä tehtävässä ei ole skriptillä tarkistettavaa" -ForegroundColor Yellow
	
    } 

    '5' {
    Write-Host "================ Tarkistetaan tehtävä 005 ================"

	$mdmScope = (Invoke-MgGraphRequest -method get -uri 'https://graph.microsoft.com/beta/policies/mobileDeviceManagementPolicies/0000000a-0000-0000-c000-000000000000').appliesTo
	if ($mdmScope -eq "all") {
        Write-Host "MDM user scope on all eli laitteita voi ilmoittaa Intuneen" -ForegroundColor Green
        }
    else {
        Write-Host "MDM user scope ei ole asetettu all tilaan eli laitteita ei voi ilmoittaa Intuneen" -ForegroundColor Red
	}

    $HfBdisabled = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceEnrollmentConfigurations/3b5cc3c2-ae7a-4173-b9ed-e0d7c0a86a6a_DefaultWindowsHelloForBusiness").state
    if ($HfBdisabled -eq "disabled")
        {
        Write-Host "Hello for Business (HfB) on pois päältä" -ForegroundColor Green
        }
    else {
        Write-Host "Hello for Business (HfB) ei ole pois päältä" -ForegroundColor Red
    }

	$device001 = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices?`$filter=(deviceName eq 'entra-win-001')" -OutputType PSOBject | Select-Object -ExpandProperty value).devicename
	if ($device001 -eq "ENTRA-WIN-001") {
        Write-Host "Laite ENTRA-WIN-001 löytyy Intunesta" -ForegroundColor Green
        }
    else {
        Write-Host "Laitette ENTRA-WIN-001 ei löydy Intunesta" -ForegroundColor Red
	}

	$device002 = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices?`$filter=(deviceName eq 'entra-win-002')" -OutputType PSOBject | Select-Object -ExpandProperty value).devicename
	if ($device002 -eq "ENTRA-WIN-002") {
        Write-Host "Laite ENTRA-WIN-002 löytyy Intunesta" -ForegroundColor Green
        }
    else {
        Write-Host "Laitette ENTRA-WIN-002 ei löydy Intunesta" -ForegroundColor Red
	}
	
    $winlaitteetRyhma = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "win_laitteet"}).DisplayName
    if ($winlaitteetRyhma -eq "win_laitteet")
        {
        Write-Host "Ryhmä nimeltään win_laitteet löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään win_laitteet ei löydy" -ForegroundColor Red
    }

    $win_laitteetRyhmaType =  (Get-EntraGroup | Where-Object {$_.DisplayName -eq "win_laitteet"}).grouptypes
    if ($win_laitteetRyhmaType -eq "DynamicMembership")
        {
        Write-Host "Ryhmä nimeltään win_laitteet on tyypiltään dynaaminen" -ForegroundColor Green
        }
    else {
        Write-Host "Ryhmää nimeltään win_laitteet ei ole tyypiltään dynaaminen" -ForegroundColor Red
    }

    $winlaitteetRyhma001 = (Get-EntraGroup -Filter "DisplayName eq 'win_laitteet'" | Get-EntraGroupMember | Select-Object Id, DisplayName | Where-Object {$_.displayname -eq "entra-win-001"}).displayname
    if ($winlaitteetRyhma001 -eq "entra-win-001")
        {
        Write-Host "Laite nimeltään entra-win-001 löytyy ryhmästä win_laitteet" -ForegroundColor Green
        }
    else {
        Write-Host "Laitetta nimeltään entra-win-001 ei löydy ryhmästä win_laitteet" -ForegroundColor Red
    }

    $winlaitteetRyhma002 = (Get-EntraGroup -Filter "DisplayName eq 'win_laitteet'" | Get-EntraGroupMember | Select-Object Id, DisplayName | Where-Object {$_.displayname -eq "entra-win-002"}).displayname
    if ($winlaitteetRyhma002 -eq "entra-win-002")
        {
        Write-Host "Laite nimeltään entra-win-002 löytyy ryhmästä win_laitteet" -ForegroundColor Green
        }
    else {
        Write-Host "Laitetta nimeltään entra-win-002 ei löydy ryhmästä win_laitteet" -ForegroundColor Red
    }

    $appleRajoitusnimi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceEnrollmentConfigurations/956535e3-eb36-482f-a22d-d5377a472c4d_SinglePlatformRestriction").displayname
    if ($appleRajoitusnimi -eq "macOS kielletty")
        {
        Write-Host "Rajoitus nimeltään 'macOS kielletty' löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Rajoitusta nimeltään 'macOS kielletty' ei löydy" -ForegroundColor Red
    }

    $appleRajoitusTyyppi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceEnrollmentConfigurations/956535e3-eb36-482f-a22d-d5377a472c4d_SinglePlatformRestriction").platformType
    if ($appleRajoitusTyyppi -eq "mac")
        {
        Write-Host "Rajoitus koskee macOS laitteita" -ForegroundColor Green
        }
    else {
        Write-Host "Rajoitusta ei näyttäisi koskevan macOS laitteita" -ForegroundColor Red
    }

    } 

    '6' {
    Write-Host "================ Tarkistetaan tehtävä 006 ================"

	
	$BlockCameraNimi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations?`$select=id,displayName" -OutputType PSOBject | Select-Object -ExpandProperty value | Where-Object {$_.DisplayName -eq "BlockCamera"}).displayName	
	if ($BlockCameraNimi -eq "BlockCamera")
        {
        Write-Host "Oikean niminen Configuration Profile nimeltään BlockCamera löytyy" -ForegroundColor Green
        }
    else {
        Write-Host "Oikean nimistä Configuration Profilea nimeltään BlockCamera ei löydy" -ForegroundColor Red
	}

	$BlockCameraID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations?`$select=id,displayName" -OutputType PSOBject | Select-Object -ExpandProperty value | Where-Object {$_.DisplayName -eq "BlockCamera"}).id
	$BlockCameraConf = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$BlockCameraID/).cameraBlocked
	if ($BlockCameraConf -eq $true)
        {
        Write-Host "Kameran käyttö on estetty Configuration Profile kautta" -ForegroundColor Green
        }
    else {
        Write-Host "Kameran käyttöä ei ole estetty Configuration Profile kautta" -ForegroundColor Red
	}
	
	$BlockCameraGroupID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/groups?`$filter=(displayName eq 'Markkinointi')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$BlockCameraAssigned = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$BlockCameraID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).id
	if ($BlockCameraAssigned.Contains($BlockCameraGroupID))
        {
        Write-Host "Kameran käyttö on estetty oikealta ryhmältä eli Markkinointi ryhmältä" -ForegroundColor Green
        }
    else {
        Write-Host "Kameran käyttöä ei ole estetty oikealta ryhmältä eli Markkinointi ryhmältä" -ForegroundColor Red
	}

	$labraverkkoID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations?`$select=id,displayName" -OutputType PSOBject | Select-Object -ExpandProperty value | Where-Object {$_.DisplayName -eq "labraverkko"}).id
	$labraverkkoConf = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations/$labraverkkoID/).networkName
	if ($labraverkkoConf -eq "HYRIALAB")
        {
        Write-Host "Profiili määrittää langattoman verkon nimeksi HYRIALAB" -ForegroundColor Green
        }
    else {
        Write-Host "Profiili ei määritä langattoman verkon nimeksi HYRIALAB" -ForegroundColor Red
	}
	
	$labraverkkoApplicability = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceManagement/deviceConfigurations/$labraverkkoID/).deviceManagementApplicabilityRuleOsEdition.osEditionTypes
	if ($labraverkkoApplicability -eq "windows10Professional")
        {
        Write-Host "Profiili on määritetty kohdistettavaksi vain laitteisiin joissa on Windows 10/11 Professional versio" -ForegroundColor Green
        }
    else {
        Write-Host "Profiilia ei ole määritetty kohdistettavaksi vain laitteisiin joissa on Windows 10/11 Professional versio" -ForegroundColor Red
	}

	$WindowsUpdatesID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations?`$select=id,displayName" -OutputType PSOBject | Select-Object -ExpandProperty value | Where-Object {$_.DisplayName -eq "WindowsUpdates"}).id
	$WindowsUpdatesConf = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$WindowsUpdatesID/).microsoftUpdateServiceAllowed
	if ($WindowsUpdatesConf -eq $true)
        {
        Write-Host "Windows päivitykset on pakotettu päälle" -ForegroundColor Green
        }
    else {
        Write-Host "Windows päivitykset ei ole pakotettu päälle" -ForegroundColor Red
	}

	$WindowsUpdatesConfPause = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$WindowsUpdatesID/).userPauseAccess
	if ($WindowsUpdatesConfPause -eq "disabled")
        {
        Write-Host "Windows päivityksiä ei voi laittaa tauolle (Pause)" -ForegroundColor Green
        }
    else {
        Write-Host "Windows päivitykset voi laittaa tauolle (Pause)" -ForegroundColor Red
	}
	
	$WindowsUpdatesGroupID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/groups?`$filter=(displayName eq 'win_laitteet')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$WindowsUpdatesAssigned = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$WindowsUpdatesID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).id
	if ($WindowsUpdatesAssigned.Contains($WindowsUpdatesGroupID))
        {
        Write-Host "Windows Updates asetukset on asetettu oikealla ryhmälle eli win_laitteet" -ForegroundColor Green
        }
    else {
        Write-Host "Windows Updates asetukset ei ole asetettu oikealla ryhmälle eli win_laitteet" -ForegroundColor Red
	}

	Write-Host "Olethan testannut Configuration Profiilien toimivuuden?" -ForegroundColor Yellow
	
	}

    '7' {
    Write-Host "================ Tarkistetaan tehtävä 007 ================"


	$VLCIvaiU = Read-Host "Tarkistatko tehtävää ennen VLC poistamista? Vastaa k (kyllä) tai e (en)"

    $M365nimi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).displayName
    if ($M365nimi -eq "Microsoft 365 sovellukset")
        {
        Write-Host "Sovelluksen nimi on oikein: 'Microsoft 365 sovellukset'" -ForegroundColor Green
        }
    else {
        Write-Host "Sovelluksen nimi ei ole oikein. Sen pitäisi olla 'Microsoft 365 sovellukset'" -ForegroundColor Red
	}

    $M365word = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).excludedApps.word
    if ($M365word -eq $false)
        {
        Write-Host "Word asennetaan" -ForegroundColor Green
        }
    else {
        Write-Host "Wordia ei asenneta" -ForegroundColor Red
	}
	
    $M365Excel = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).excludedApps.Excel
    if ($M365Excel -eq $false)
        {
        Write-Host "Excel asennetaan" -ForegroundColor Green
        }
    else {
        Write-Host "Excelia ei asenneta" -ForegroundColor Red
	}
	
    $M365outlook = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).excludedApps.outlook
    if ($M365outlook -eq $false)
        {
        Write-Host "Outlook asennetaan" -ForegroundColor Green
        }
    else {
        Write-Host "Outlookia ei asenneta" -ForegroundColor Red
	}
	
    $M365Powerpoint = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).excludedApps.Powerpoint
    if ($M365Powerpoint -eq $false)
        {
        Write-Host "Powerpoint asennetaan" -ForegroundColor Green
        }
    else {
        Write-Host "Powerpointia ei asenneta" -ForegroundColor Red
	}
	
    $M365Access = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).excludedApps.Access
    if ($M365Access -eq $True)
        {
        Write-Host "Accessia ei asenneta" -ForegroundColor Green
        }
    else {
        Write-Host "Access asennetaan" -ForegroundColor Red
	}
	
    $M365poistavanha = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).shouldUninstallOlderVersionsOfOffice
    if ($M365poistavanha -eq $true)
        {
        Write-Host "M365 vanha versio poistetaan" -ForegroundColor Green
        }
    else {
        Write-Host "M365 vanhaa versiota ei poisteta" -ForegroundColor Red
    }
	
    $M365channel = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).updateChannel
    if ($M365channel -eq "monthlyEnterprise")
        {
        Write-Host "M365 päivityskanava on Monthly Enterprise" -ForegroundColor Green
        }
    else {
        Write-Host "M365 M365 päivityskanava ei ole Monthly Enterprise" -ForegroundColor Red
    }
	
    $M365jaettu = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).useSharedComputerActivation
    if ($M365jaettu -eq $false)
        {
        Write-Host "M365 ei käytä jaettua tietokoneen aktivointia" -ForegroundColor Green
        }
    else {
        Write-Host "M365 käyttää jaettua tietokoneen aktivointia" -ForegroundColor Red
    }
	
    $M365kieli = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).localesToInstall
    if ($M365kieli -eq "fi-fi")
        {
        Write-Host "M365 asennetaan suomen kielellä" -ForegroundColor Green
        }
    else {
        Write-Host "M365 ei asennetta suomen kielellä" -ForegroundColor Red
    }

	$M365ID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft 365 sovellukset')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$M365Published = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$M365ID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
    if ($M365Published -eq "required")
        {
        Write-Host "Microsoft 365 sovellus on määritetty käyttäjille niin, että se asentuu pakotetusti" -ForegroundColor Green
        }
    else {
        Write-Host "Microsoft 365 sovellusta ei ole määritetty käyttäjille niin, että se asentuisi pakotetusti" -ForegroundColor Red
	}
	
    $CPnimi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Company Portal')" -OutputType PSOBject | Select-Object -ExpandProperty value).displayName
    if ($CPnimi -eq "Company Portal")
        {
        Write-Host "Sovelluksen nimi on oikein: 'Company Portal'" -ForegroundColor Green
        }
    else {
        Write-Host "Sovelluksen nimi ei ole oikein. Sen pitäisi olla 'Company Portal'" -ForegroundColor Red
	}

	$CPID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Company Portal')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$CPPublished = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$CPID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
    if ($CPPublished -eq "required")
        {
        Write-Host "Company Portal niminen sovellus on määritetty käyttäjille niin, että se asentuu pakotetusti" -ForegroundColor Green
        }
    else {
        Write-Host "Company Portal nimistä sovellusta ei ole määritetty käyttäjille niin, että se asentuisi pakotetusti" -ForegroundColor Red
	}
	
	if ($VLCIvaiU -eq "k") {
	
		$VLCnimi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'VLC')" -OutputType PSOBject | Select-Object -ExpandProperty value).displayName
		if ($VLCnimi -eq "VLC")
			{
			Write-Host "Sovelluksen nimi on oikein: 'VLC'" -ForegroundColor Green
			}
		else {
			Write-Host "Sovelluksen nimi ei ole oikein. Sen pitäisi olla 'VLC'" -ForegroundColor Red
		}

		$VLCID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'VLC')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
		$VLCPublished = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$VLCID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
		if ($VLCPublished -eq "required")
			{
			Write-Host "VLC niminen sovellus on määritetty käyttäjille niin, että se asentuu pakotetusti" -ForegroundColor Green
			}
		else {
			Write-Host "VLC nimistä sovellusta ei ole määritetty käyttäjille niin, että se asentuisi pakotetusti" -ForegroundColor Red
		}
	}

    $FirefoxNimi = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Firefox')" -OutputType PSOBject | Select-Object -ExpandProperty value).displayName
    if ($FirefoxNimi -eq "Firefox")
        {
        Write-Host "Firefox niminen sovellus löytyy Intunesta" -ForegroundColor Green
        }
    else {
        Write-Host "Firefox nimistä sovellusta ei löydy Intunesta" -ForegroundColor Red
	}

    $FirefoxKuvaus = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Firefox')" -OutputType PSOBject | Select-Object -ExpandProperty value).description
    if ($FirefoxKuvaus -eq "Firefox asennettu osana tehtävää 007 Windows sovellukset ja skriptit")
        {
        Write-Host "Firefox kuvaus on oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Firefox kuvaus on väärin" -ForegroundColor Red
	}
 
	$FirefoxID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Firefox')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$FirefoxPublished = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$FirefoxID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
    if ($FirefoxPublished -eq "available")
        {
        Write-Host "Firefox niminen sovellus on määritetty käyttäjille niin, että he voivat halutessaan asentaa sen" -ForegroundColor Green
        }
    else {
        Write-Host "Firefox nimistä sovellusta ei ole määritetty käyttäjille niin, että he voivat halutessaan asentaa sen" -ForegroundColor Red
	}
	
	if ($VLCIvaiU -eq "e") {
		$VLCID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'VLC')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
		$VLCUninstalled = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$VLCID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
		if ($VLCUninstalled -eq "uninstall")
			{
			Write-Host "VLC niminen sovellus on määritetty käyttäjille niin, että se poistetaan pakotetusti" -ForegroundColor Green
			}
		else {
			Write-Host "VLC nimistä sovellusta ei ole määritetty käyttäjille niin, että se poistettaisiin pakotetusti" -ForegroundColor Red
		}
	}
	
	$ScriptName = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceManagementScripts?`$filter=(displayName eq 'TestScript')" -OutputType PSOBject | Select-Object -ExpandProperty value).filename
    if ($ScriptName -eq "007testiskripti.ps1")
        {
        Write-Host "TestScript niminen skripti löytyy ja se hyödyntää tiedostoa nimeltään 007testiskripti.ps1" -ForegroundColor Green
        }
    else {
        Write-Host "TestScript nimistä skriptiä ei löydy eikä se hyödynnä tiedostoa nimeltään 007testiskripti.ps1" -ForegroundColor Red
	}
	
	$ScriptSignature = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceManagementScripts?`$filter=(displayName eq 'TestScript')" -OutputType PSOBject | Select-Object -ExpandProperty value).enforceSignatureCheck
    if ($ScriptSignature -eq $false)
        {
        Write-Host "TestScript niminen skripti ei edellytä allekirjoitusta" -ForegroundColor Green
        }
    else {
        Write-Host "TestScript nimistä skripti edellyttää allekirjoitusta" -ForegroundColor Red
	}

	Write-Host "Olethan varmistanut, että sovellukset oikeasti asentuivat laitteille?" -ForegroundColor Yellow
	Write-Host "Olethan varmistanut, että myös skripti toimi?" -ForegroundColor Yellow
	

    } 

    '8' {
    Write-Host "================ Tarkistetaan tehtävä 008 ================"
 
    $androidRajoitus = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceManagement/deviceEnrollmentConfigurations/970f3135-c295-4fb7-b9c0-76ae0edf7009_SinglePlatformRestriction").platformRestriction.platformblocked
    if ($androidRajoitus -eq $false)
        {
        Write-Host "Rajoitus nimeltään 'AllowAndroid' löytyy eli Android laitteet on sallittu työkäyttöön" -ForegroundColor Green
        }
    else {
        Write-Host "Rajoitusta nimeltään 'AllowAndroid' ei löydy eli Android laitteita ei ole sallittu työkäyttöön" -ForegroundColor Red
    }

	$androidConfID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations?`$select=id,displayName" -OutputType PSOBject | Select-Object -ExpandProperty value | Where-Object {$_.DisplayName -eq "AndroidRestrictions"}).id
	$androidConf = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$androidConfID/).passwordRequiredType
	if ($androidConf -eq "atLeastNumeric")
        {
        Write-Host "Android salasanojen tulee olla vähintään alfanumeerisia eli sisältää kirjaimia ja numeroita" -ForegroundColor Green
        }
    else {
        Write-Host "Android salasanojen ei tule olla vähintään alfanumeerisia eli sisältää kirjaimia ja numeroita" -ForegroundColor Red
	}

	$androidConfCamera = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$androidConfID/).workProfileBlockCamera
	if ($androidConfCamera -eq $True)
        {
        Write-Host "Android laitteella ei voi käyttää kameraa" -ForegroundColor Green
        }
    else {
        Write-Host "Android laitteella voi käyttää kameraa" -ForegroundColor Red
	}	
 
 	$androidConfCopyPaste = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations/$androidConfID/).workProfileBlockCrossProfileCopyPaste
	if ($androidConfCopyPaste -eq $True)
        {
        Write-Host "Android laitteella ei voi kopioida tietoja henkilökohtaisen ja työprofiilin välillä" -ForegroundColor Green
        }
    else {
        Write-Host "Android laitteella voi kopioida tietoja henkilökohtaisen ja työprofiilin välillä" -ForegroundColor Red
	}

	$AndOutlookID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft Outlook')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$AndOutlookAssigned = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceAppManagement/mobileApps/$AndOutlookID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
    if ($AndOutlookAssigned -eq "required")
        {
        Write-Host "Android sovellus Microsoft Outlook asennetaan pakotetusti" -ForegroundColor Green
        }
    else {
        Write-Host "Android sovellus Microsoft Outlook ei asennu pakotetusti" -ForegroundColor Red
	}
	
	$AndAuthID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps?`$filter=(displayName eq 'Microsoft Authenticator')" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$AndAuthenticatorAssigned = (Invoke-MgGraphRequest -method get -uri https://graph.microsoft.com/v1.0/deviceAppManagement/mobileApps/$AndAuthID/assignments -OutputType PSOBject | Select-Object -ExpandProperty value).intent
    if ($AndAuthenticatorAssigned -eq "available")
        {
        Write-Host "Android sovellus Microsoft Authenticator on mahdollista asentaa" -ForegroundColor Green
        }
    else {
        Write-Host "Android sovellus Microsoft Authenticator ei ole mahdollista asentaa" -ForegroundColor Red
	}
	
	Write-Host "Olethan varmistanut, että Android sovellukset asentuivat?" -ForegroundColor Yellow
	Write-Host "Olethan varmistanut, että Android rajoitukset toimivat?" -ForegroundColor Yellow
	
    } 

    '9' {
    Write-Host "================ Tarkistetaan tehtävä 009 ================"
	# Muodostetaan yhteys Exchange palveluun vain tätä tehtävää varten
	Connect-ExchangeOnline
 
    $userAnneliGMark = (Get-EntraUserGroup -UserId "Anneli.k$domainNimi" | Where-Object {$_.DisplayName -eq "Markkinointi"}).displayName
    if ($userAnneliGMark -eq "Markkinointi")
        {
        Write-Host "Käyttäjä nimeltään Anneli on oikeassa ryhmässä" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Anneli ei ole ryhmässä Markkinointi" -ForegroundColor Red
    }	

    $resourceSaunaCapacity = (Get-Place -Identity Saunaosasto).capacity
    if ($resourceSaunaCapacity -eq "25")
        {
        Write-Host "Saunaosaston kapasiteetti on 25" -ForegroundColor Green
        }
    else {
        Write-Host "Saunaosaston kapasiteetti ei ole 25" -ForegroundColor Red
    }

    $resourceSaunaDur = (Get-CalendarProcessing -Identity Saunaosasto).MaximumDurationInMinutes
    if ($resourceSaunaDur -eq "360")
        {
        Write-Host "Saunaosasto on varattavissa 6 tunniksi eli 360 minuutiksi kerrallaan" -ForegroundColor Green
        }
    else {
        Write-Host "Saunaosasto ei ole varattavissa 6 tunniksi eli 360 minuutiksi kerrallaan" -ForegroundColor Red
    }

    $resourceSaunaAutoAcc = (Get-CalendarProcessing -Identity Saunaosasto).AllBookInPolicy
    if ($resourceSaunaAutoAcc -eq $true)
        {
        Write-Host "Saunaosasto on kenen tahansa varattavissa" -ForegroundColor Green
        }
    else {
        Write-Host "Saunaosasto ei ole kenen tahansa varattavissa" -ForegroundColor Red
    }

    $resourceJohtoCapacity = (Get-Place -Identity Johto).capacity
    if ($resourceJohtoCapacity -eq "10")
        {
        Write-Host "Johto neuvotteluhuoneen kapasiteetti on 10" -ForegroundColor Green
        }
    else {
        Write-Host "Johto neuvotteluhuoneen kapasiteetti ei ole 10" -ForegroundColor Red
    }

    $resourceJohtoAutoAcc = (Get-CalendarProcessing -Identity Johto).AllRequestInPolicy
    if ($resourceJohtoAutoAcc -eq $true)
        {
        Write-Host "Johto neuvotteluhuonetta ei voi kuka tahansa varata" -ForegroundColor Green
        }
    else {
        Write-Host "Johto neuvotteluhuoneen voi varata kuka tahansa" -ForegroundColor Red
    }

    $resourceAudiCapacity = (Get-Mailbox -Identity audia6).ResourceCapacity
    if ($resourceAudiCapacity -eq "5")
        {
        Write-Host "Audi A6 kapasiteetti on 5" -ForegroundColor Green
        }
    else {
        Write-Host "Audi A6 kapasiteetti ei ole 5" -ForegroundColor Red
    }

    $distListEmail = (Get-DistributionGroup | Where-Object {$_.DisplayName -eq "ICT-palvelut"}).WindowsEmailAddress
    if ($distListEmail -eq "ICT-palvelut$domainNimi")
        {
        Write-Host "Distribution List sähköpostiosoite on oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Distribution List sähköpostiosoite ei ole oikein" -ForegroundColor Red
    }

	# Haetaan admin tilin ID
	$adminTiliID = (Get-EntraUser -userid $adminTili).Id 
	$distListManaged = (Get-DistributionGroup | Where-Object {$_.DisplayName -eq "ICT-palvelut"}).ManagedBy
	if ($distListManaged -eq $adminTiliID)
		{
		Write-Host "Distribution List hallitsija on oma admin tilisi" -ForegroundColor Green
		}
	else {
		Write-Host "Distribution List hallitsija ei ole oma admin tilisi" -ForegroundColor Red
	}

    $distListInsideonly = (Get-DistributionGroup | Where-Object {$_.DisplayName -eq "ICT-palvelut"}).RequireSenderAuthenticationEnabled
    if ($distListInsideonly -eq $True)
        {
        Write-Host "Distribution List voi lähettää sähköpostia vain organisaation sisältä" -ForegroundColor Green
        }
    else {
        Write-Host "Distribution List voi lähettää sähköpostia organisaation ulkopuolelta" -ForegroundColor Red
    }

    $distListClosed = (Get-DistributionGroup | Where-Object {$_.DisplayName -eq "ICT-palvelut"}).MemberJoinRestriction
    if ($distListClosed -eq "Closed")
        {
        Write-Host "Distribution List liittyminen on tyypiltään suljettu eli siihen ei voi liittyä kuka tahansa" -ForegroundColor Green
        }
    else {
        Write-Host "Distribution List liittyminen ei ole tyypiltään suljettu eli siihen ei voi liittyä kuka tahansa" -ForegroundColor Red
    }

    $sharedMailboxEmail = (Get-Mailbox -RecipientTypeDetails SharedMailbox | Where-Object {$_.Name -eq "MAVI"}).WindowsEmailAddress
    if ($sharedMailboxEmail -eq "MAVI$domainNimi")
        {
        Write-Host "Jaetun sähköpostilaatikon sähköpostiosoite on oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Jaetun sähköpostilaatikon sähköpostiosoite ei ole oikein" -ForegroundColor Red
    }

    $sharedMailboxSendasMartti = (Get-RecipientPermission "MAVI" | Where-Object {$_.Trustee -eq "martti.a$domainNimi"}).AccessRights
    if ($sharedMailboxSendasMartti -eq "SendAs")
        {
        Write-Host "Martti voi lähettää sähköpostia sähköpostiosoitteesta MAVI@domainisi" -ForegroundColor Green
        }
    else {
        Write-Host "Martti voi lähettää sähköpostia sähköpostiosoitteesta MAVI@domainisi" -ForegroundColor Red
    }

    $sharedMailboxSendasTarja = (Get-RecipientPermission "MAVI" | Where-Object {$_.Trustee -eq "Tarja.h$domainNimi"}).AccessRights
    if ($sharedMailboxSendasTarja -eq "SendAs")
        {
        Write-Host "Tarja voi lähettää sähköpostia sähköpostiosoitteesta MAVI@domainisi" -ForegroundColor Green
        }
    else {
        Write-Host "Tarja voi lähettää sähköpostia sähköpostiosoitteesta MAVI@domainisi" -ForegroundColor Red
    }

    $sharedMailboxMailtip = (Get-Mailbox -RecipientTypeDetails SharedMailbox | Where-Object {$_.Name -eq "MAVI"}).mailtip
    if ($sharedMailboxMailtip.Contains("MAVI lomailee tämän viikon"))
        {
        Write-Host "Jaetun sähköpostilaatikon Mailtip on oikein" -ForegroundColor Green
        }
    else {
        Write-Host "Jaetun sähköpostilaatikon Mailtip ei ole oikein" -ForegroundColor Red
    }

    $userSannaUusiUPN = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Sanna.m$domainNimi"}).UserPrincipalName
    if ($userSannaUusiUPN -eq "Sanna.m$domainNimi")
        {
        Write-Host "Käyttäjän Sanna uusi kirjautumistunnus on Sanna@domainisi" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän Sanna uusi kirjautumistunnus ei ole Sanna@domainisi" -ForegroundColor Red
    }

    $userSannaUusiDN = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "Sanna.m$domainNimi"}).displayName
    if ($userSannaUusiDN -eq "Sanna Mäkelä")
        {
        Write-Host "Käyttäjän Sanna koko nimi on Sanna Mäkelä eli se on muutettu" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjän Sanna koko nimi ei ole Sanna Mäkelä eli sitä ei ole muutettu" -ForegroundColor Red
    }
	
	Write-Host "SharePoint toiminnallisuutta ei tarkisteta skriptillä" -ForegroundColor Yellow
	Write-Host "Olethan testannut eri toimintojen toiminnallisuuden ja dokumentoinut ne?" -ForegroundColor Yellow
	Write-Host "Mobiilisovelluksen toimivuutta ei testata skriptillä" -ForegroundColor Yellow
	} 

    '10' {
    Write-Host "================ Tarkistetaan tehtävä 010 ================"

	$NamedLocation = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/namedLocations/" -OutputType PSOBject | Select-Object -ExpandProperty value).countriesAndRegions
    if ($NamedLocation -eq "FI")
        {
        Write-Host "Conditional Access Named Location on määritetty niin, että vain Suomesta käsin voi kirjautua" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access Named Location ei ole määritetty niin, että vain Suomesta käsin voi kirjautua" -ForegroundColor Red
	}

	$CAID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/" -OutputType PSOBject | Select-Object -ExpandProperty value | Where-Object {$_.displayName -eq "AllowedCountries"}).id
	$TalousID = (Get-EntraGroup | Where-Object {$_.DisplayName -eq "Talous"}).id
	$CAgroup = (Get-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $CAID).conditions.Users.includegroups
    if ($CAgroup -eq $TalousID)
        {
        Write-Host "Conditional Access nimeltään AllowedCountries on määritelty Talous ryhmälle" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access nimeltään AllowedCountries ei ole määritelty Talous ryhmälle" -ForegroundColor Red
	}
	
	$CAApps = (Get-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $CAID).conditions.applications.includeapplications
    if ($CAApps -eq "All")
        {
        Write-Host "Conditional Access nimeltään AllowedCountries on määritelty koskemaan kaikkia pilvi sovelluksia" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access nimeltään AllowedCountries ei ole määritelty koskemaan kaikkia pilvi sovelluksia" -ForegroundColor Red
	}

	$CAIncludes = (Get-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $CAID).conditions.locations.includelocations
    if ($CAIncludes -eq "All")
        {
        Write-Host "Conditional Access nimeltään AllowedCountries on määritelty koskemaan kaikkia sijainteja" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access nimeltään AllowedCountries ei ole määritelty koskemaan kaikkia sijainteja" -ForegroundColor Red
	}

	$CANamedLocationID = (Invoke-MgGraphRequest -method get -uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/namedLocations/" -OutputType PSOBject | Select-Object -ExpandProperty value).id
	$CAExcludes = (Get-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $CAID).conditions.locations.excludelocations
    if ($CAExcludes -eq $CANamedLocationID)
        {
        Write-Host "Conditional Access nimeltään AllowedCountries on määritelty jättämään huomiotta Suomen sijaintia NamedLocations muuttujan avulla" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access nimeltään AllowedCountries ei ole määritelty jättämään huomiotta Suomen sijaintia NamedLocations muuttujan avulla" -ForegroundColor Red
	}	

	$CAControl = (Get-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $CAID).grantcontrols.BuiltInControls
    if ($CAControl -eq "block")
        {
        Write-Host "Conditional Access nimeltään AllowedCountries on määritelty estämään yhteydet eli se on Grant tilassa" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access nimeltään AllowedCountries ei ole määritelty estämään yhteydet eli se ei ole Grant tilassa" -ForegroundColor Red
	}
	
	$CAenabled = (Get-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId 73039c0c-d181-4a29-bd46-34c7b365b12f).state
    if ($CAenabled -eq "enabled")
        {
        Write-Host "Conditional Access nimeltään AllowedCountries on otettu käyttöön" -ForegroundColor Green
        }
    else {
        Write-Host "Conditional Access nimeltään AllowedCountries ei ole otettu käyttöön" -ForegroundColor Red
	}
	
    Write-Host "Olethan testannut Conditional Access toiminnan esim. hyödyntämällä VPN:ää?" -ForegroundColor Yellow

    }
    
    '11' {
    Write-Host "================ Tarkistetaan tehtävä 011 ================"

    $userJuhoADSync = (Get-EntraUser | Where-Object {$_.UserPrincipalName -eq "juho$domainNimi"}).onPremisesSyncEnabled
    if ($userJuhoADSync -eq $true)
        {
        Write-Host "Käyttäjä nimeltään Juho löytyy ja hänet on synkronoitu paikallisesta AD:sta" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjää nimeltään Juho ei ole synkronoitu paikallisesta AD:sta" -ForegroundColor Red
    }

	$juhoLisenssi = (Get-EntraUserLicenseDetail -UserId "juho$domainNimi").SkuPartNumber
    if ($juhoLisenssi -eq "DEVELOPERPACK_E5")
        {
        Write-Host "Käyttäjällä nimeltään Juho on lisenssi" -ForegroundColor Green
        }
    else {
        Write-Host "Käyttäjällä nimeltään Juho ei ole lisenssiä" -ForegroundColor Red
    }
	
    Write-Host "Olethan testannut, että salasanan muuttaminen onnistui sekä paikallisen toimialueen että pilvi toimialueen kautta?" -ForegroundColor Yellow

    }

    '12' {
    Write-Host "================ Tarkistetaan tehtävä 012 ================"

	Write-Host "Tässä tehtävässä ei ole skriptillä tarkistettavaa" -ForegroundColor Yellow
  
 }
 }   

    function pause { $null = Read-Host 'Paina Enter palataksesi valikkoon' }
    pause

 }
 until ($selection -eq 'q')





