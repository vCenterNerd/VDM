
#########################################################
#PS Script for connecting to VC & Enabling SSH Services  
#By Nigel Hickey					
#							
#########################################################
 
# Select which vCenter you want
Write-host "Select which vCenter to connect to:"
Write-Host ""
Write-Host "1. HOEVDS120.na.xom.com"
Write-Host "2. DALVDS100.na.xom.com"
Write-Host "3. PNHVDS100.ap.xom.com"
 
$Ivcenter = read-host “Select a vCenter Server. Enter Number “
 
if ($Ivcenter –eq 1) {
$vcenter = "HOEVDS120.na.xom.com"
} elseif ($Ivcenter -eq 2) {
$vcenter = "DALVDS100.na.xom.com"
} else {
$vcenter = "PNHVDS100.ap.xom.com"
} 
 
write-host ""
Write-Host "You Picked: "$vcenter
write-host "Please wait while you are connected to the vCenter!"
Write-Host ""
Write-Host "If prompted, please enter your credentials to access the vCenter. (Domain\UserID & Password)"
start-sleep -s 3
 
# connect to selected vCenter
connect-viserver $vcenter
#
#Enable & Start SSH Services on all hosts under this VC
Get-VMHost | foreach { get-vmhostservice -VMHost $_.name | where {$_.Key -eq "TSM-SSH"} | Start-VMHostService}

# Display Popup when finished
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show("SSH has been enabled and STARTED on all ESXi hosts under " + $vcenter + " ...")



