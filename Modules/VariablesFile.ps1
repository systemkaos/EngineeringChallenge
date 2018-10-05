#TESTING
$ResourceGroupName = 'Challenger01'
$ResourceGroupLocation = 'westeurope'
$NetworkName = 'ChallengingNetwork'
$AddressPrefix = '10.0.0.0/24'
$VMName = 'TheChallengedVM01'
$subnetname = '24challenges'
$dnsPrefix = 'chal'
$publicIpName = 'ChalIPPub'
#
$NICName = 'CHvmnic'
#https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general
$VMsize = 'Standard_B2s'
#No More than 15Char
$VMComputerName = 'ChallPN'
$VMLocalAdminUser = 'mpierce'
#needs ConvertTo-SecureString <password> -AsPlainText -Force
$VMLocalAdminSecurePassword = ConvertTo-SecureString Ch@ll3ng3R! -AsPlainText -Force



<#
#DEV RELATED. Sets all variables as global vars.
#TODO: NOT FOR PRODUCTION
function CreateGlobalVars($x) {
    $varset = "$" + $x
    Set-Variable -Name $x -Value $x -Scope Global
}


CreateGlobalVars $NetworkName
CreateGlobalVars $AddressPrefix
CreateGlobalVars $VMName
CreateGlobalVars $subnetname
CreateGlobalVars $dnsPrefix
CreateGlobalVars $publicIpName
CreateGlobalVars $NICName
CreateGlobalVars $VMsize
CreateGlobalVars $VMComputerName
CreateGlobalVars $VMLocalAdminUser
CreateGlobalVars $VMLocalAdminSecurePassword
#>