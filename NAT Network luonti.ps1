# Nat Network luominen Hyper-V:hen

# Windows kenraali 10.100.0.0 /22
New-VMSwitch -SwitchName "Windows kenraali verkko" -SwitchType Internal
New-NetIPAddress -IPAddress 10.100.0.1 -PrefixLength 22 -InterfaceAlias "vEthernet (Windows kenraali verkko)"
New-NetNat -Name "Windows kenraali NAT" -InternalIPInterfaceAddressPrefix 10.100.0.0/22

# Linux kenraali 10.220.132.0 /22
New-VMSwitch -SwitchName "Linux kenraali verkko" -SwitchType Internal
New-NetIPAddress -IPAddress 10.220.133.1 -PrefixLength 22 -InterfaceAlias "vEthernet (Linux kenraali verkko)"
New-NetNat -Name "Linux kenraali NAT" -InternalIPInterfaceAddressPrefix 10.220.132.0/22
