#TODO: Document Module
<#
      .SYNOPSIS
      The "AzureNetworksModule" interact with Azure's network infrastructure.

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

#Check Network
function CheckAzureNetwork {

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
        #TODO: -warningaction added due to depreciation
        Try {
            $network = Get-AzureRmVirtualNetwork `
                -Name $global:NetworkName `
                -ResourceGroupName $global:ResourceGroupName `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
        }
        catch {
            Write-Error -Message 'Unable to Set network variable in checkazurenetwork function'
            Write-Output -InputObject 0
        }
    }
    Process {
        Try {
            if (!$network) {
                Write-Output -InputObject 0
            }
            else {
                Write-Output -InputObject 1
            }
        }
        Catch {Write-Error -Message 'No Network variable Found'}
    }
    End {

    }

}#End function CheckAzureNetwork

function CreateAzureNetwork {
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
        #TODO: -warningAction SIlentlycontinue due to a change in this module
        Try {
            $subnet = New-AzureRmVirtualNetworkSubnetConfig `
                -Name $global:SubnetName `
                -AddressPrefix $global:AddressPrefix `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
        }
        Catch {Write-Error -Message 'Subnet name or address prefix not defined'}
        try {
            $virtualNetwork = New-AzureRmVirtualNetwork `
                -ResourceGroupName $global:ResourceGroupName `
                -Location $global:ResourceGroupLocation `
                -Name $global:NetworkName `
                -AddressPrefix $global:AddressPrefix `
                -Subnet $global:subnet `
                -Force `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
        }
        catch {Write-Error -Message 'Unable to set virtualnetwork variable'}

    }
    Process {

        try {if ((CheckAzureNetwork -Verbose) -eq 0) {$virtualNetwork | Set-AzureRmVirtualNetwork -Verbose}}
        Catch {Write-Error -Message 'Unable to Create network'}
    }
    End {
        if ((CheckAzureNetwork -Verbose) -eq 1) {
            Write-Output -InputObject 1
        }
        else {
            Write-Output -InputObject 0
        }


    }
}#End function CreateAzureNetwork

function DeleteAzureNetwork {
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

    }
    Process {



        if ((CheckAzureNetwork -Verbose) -eq 1) {
            Try {
                Remove-AzureRmVirtualNetwork `
                    -Name $global:NetworkName `
                    -ResourceGroupName $ResourceGroupName `
                    -force `
                    -ErrorAction SilentlyContinue `
                    -WarningAction SilentlyContinue `
                    -InformationAction SilentlyContinue
                Write-Output -InputObject 1
            }
            catch {
                Write-Error -Message 'Unable to delete virtual network'
                Write-Output -InputObject 0
            }

        }
        else {
            Write-Output -InputObject 0
        }


    }
    End {

    }

}#End function DeleteAzureNetwork