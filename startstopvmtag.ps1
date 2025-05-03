param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("Start", "Stop")]
    [string]$Action,

    [string]$TagName = "AutoShutdown",
    [string]$TagValue = "true"
)

# Autenticar no Azure com Managed Identity
Connect-AzAccount -Identity

# Buscar todas as VMs com a tag correspondente
$vms = Get-AzVM -Status | Where-Object {
    $_.Tags[$TagName] -eq $TagValue
}

Write-Output "Total de VMs encontradas com a tag '$TagName=$TagValue': $($vms.Count)"

foreach ($vm in $vms) {
    $vmName = $vm.Name
    $resourceGroup = $vm.ResourceGroupName
    $status = $vm.PowerState

    if ($Action -eq "Stop" -and $status -eq "VM running") {
        Write-Output "Parando VM: $vmName"
        Stop-AzVM -Name $vmName -ResourceGroupName $resourceGroup -Force
    }
    elseif ($Action -eq "Start" -and $status -eq "VM deallocated") {
        Write-Output "Iniciando VM: $vmName"
        Start-AzVM -Name $vmName -ResourceGroupName $resourceGroup
    }
    else {
        Write-Output "Nenhuma ação necessária para a VM: $vmName (Estado atual: $status)"
    }
}
