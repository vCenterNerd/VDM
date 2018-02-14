#########################################
#Script to show UpTime for VMs
#Author: Nigel Hickey
#
#Connect-VIServer <FQDN of vCenter> 
# -and $_.PowerState -eq "PoweredOn"
#
#########################################

$DT = get-date -format MM.dd.yyyy
$csvFile = "VMUptimeReport_$($DT).csv"

$VMs = Get-VM | Where-Object {$_.Name -like "HOERPA*"}
$Output = ForEach ($VM in $VMs)

    { 
    "" | Select @{N="Name";E={$VM.Name}},
    @{N="Up Time (Seconds)";E={$Timespan = New-Timespan -Seconds (Get-Stat -Entity $VM.Name -Stat sys.uptime.latest -Realtime -MaxSamples 1).Value
   "" + $Timespan.TotalSeconds}}
    }
    
$Output | Export-Csv -Path "C:\temp\$csvFile" -NoTypeInformation
