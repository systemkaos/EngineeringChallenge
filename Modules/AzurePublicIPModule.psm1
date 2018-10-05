#TODO: Document Module
<#
      .SYNOPSIS
      The "AzurePublicIPModule" interact with public IP addresses on virtual machines within Azure.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      CheckAzurePowershellModule
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online CheckAzurePowershellModule

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
#>
[CmdletBinding(SupportsShouldProcess)]
Param()

$pip = $null

function CheckForCreatedPublicIpAddress {
    <#
      .SYNOPSIS
      Describe purpose of "CheckAzurePowershellModule" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      CheckAzurePowershellModule
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online CheckAzurePowershellModule

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>
    [CmdletBinding(SupportsShouldProcess)]
    param()
    Begin {}
    Process {

        try {
            Get-AzureRmPublicIpAddress `
                -Name $Global:publicIpName `
                -ResourceGroupName $Global:ResourceGroupName `
                -ErrorAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -Verbose
            Write-Output -InputObject 1
        }
        catch {
            Write-Output -InputObject 0
        }

    }
    End {}

}#End function CheckForCreatedPublicIpAddress

function CreatePublicIpAddress {
    <#
      .SYNOPSIS
      Describe purpose of "CheckAzurePowershellModule" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      CheckAzurePowershellModule
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online CheckAzurePowershellModule

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>
    [CmdletBinding(SupportsShouldProcess)]
    param()
    Begin {
        try {
            New-AzureRmPublicIpAddress `
                -Name $global:publicIpName `
                -ResourceGroupName $global:ResourceGroupName `
                -AllocationMethod static `
                -DomainNameLabel $global:dnsPrefix `
                -Location $global:ResourceGroupLocation `
                -InformationAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -ErrorAction SilentlyContinue `
                -OutVariable $Script:pip `
                -Force `
                -Verbose
            Write-Output -InputObject 1
        }
        Catch {
            Write-Error -Message 'unable to create New IP address in azure'
            Write-Output -InputObject 0
        }
    }
    Process {}
    End {}

}#End function CreatePublicIpAddress

function RemoveCreatedPublicIpAddress {
    <#
      .SYNOPSIS
      Describe purpose of "CheckAzurePowershellModule" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      CheckAzurePowershellModule
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online CheckAzurePowershellModule

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>
    [CmdletBinding(SupportsShouldProcess)]
    param()
    Begin {}
    Process {
        try {
            Remove-AzureRmPublicIpAddress `
                -Name $global:publicIPName `
                -ResourceGroupName $global:resourceGroupName `
                -WarningAction SilentlyContinue `
                -ErrorAction SilentlyContinue `
                -Force `
                -Verbose
            Write-Output -InputObject 1
        }
        Catch {
            Write-Error -Message 'Unable to delete Ip address'
            Write-Output -InputObject 0
        }
        #-InformationAction SilentlyContinue `
    }
    End {}
}#End function RemoveCreatedPublicIpAddress

function AssignPublicIPaddress {
    <#
      .SYNOPSIS
      Describe purpose of "AssignPublicIPaddress" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      AssignPublicIPaddress
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online AssignPublicIPaddress

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>

    Begin {
        Try {
            $nic = Get-AzureRmNetworkInterface `
                -ResourceGroupName $global:ResourceGroupName `
                -Name $global:NICName `
                -ErrorAction Stop `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
            $script:pip = CreatePublicIpAddress -Verbose
        }
        Catch {
            Write-Error -Message 'Unable to set variables for Public Ip address asignment'
            Write-Output -InputObject 0
        }
    }
    Process {
        try {

            #TODO: The object location is hardcoded
            $nic.IpConfigurations[0].PublicIpAddress = $script:pip[0]
            Set-AzureRmNetworkInterface `
                -NetworkInterface $nic `
                -ErrorAction Stop `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
            Write-Output -InputObject 1
        }
        Catch {
            Write-Error -Message 'Unable to Create nic info and bind it to ip info'
            Write-Output -InputObject 0
        }
    }
    end {}
}#End function AssignPublicIPaddress
#TODO: function UnAssignPublicIpAddress
function UnAssignPublicIpAddress {
    <#
      .SYNOPSIS
      Describe purpose of "UnAssignPublicIpAddress" in 1-2 sentences.

    .DESCRIPTION
    Add a more complete description of what the function does.

    .EXAMPLE
    UnAssignPublicIpAddress
    Describe what this call does

    .NOTES
    Place additional notes here.

    .LINK
    URLs to related sites
    The first link is opened by Get-Help -Online UnAssignPublicIpAddress

    .INPUTS
    List of input types that are accepted by this function.

    .OUTPUTS
    List of output types produced by this function.
  #>



}#End function UnAssignPublicIpAddress
#TODO: function CheckVMsAssignedPublicIP
function CheckVMsAssignedPublicIP {
    <#
      .SYNOPSIS
      Describe purpose of "CheckVMsAssignedPublicIP" in 1-2 sentences.

      .DESCRIPTION
      Add a more complete description of what the function does.

      .EXAMPLE
      CheckVMsAssignedPublicIP
      Describe what this call does

      .NOTES
      Place additional notes here.

      .LINK
      URLs to related sites
      The first link is opened by Get-Help -Online CheckVMsAssignedPublicIP

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>



}#End function CheckVMsAssignedPublicIP
