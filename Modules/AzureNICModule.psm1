#TODO: Document Module
<#
      .SYNOPSIS
      The "AzureNetworksModule" interact with Azure virtual machine network interfaces.

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

Function CheckAzureNIC {
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
        Try {
            $nic = Get-AzureRmNetworkInterface `
                -ResourceGroupName $global:ResourceGroupName `
                -Name $global:NICName `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
        }
        catch {
            Write-Error -Message 'Unable to Set nic variable in CheckAzureNIC function'
            Write-Output -InputObject 0
        }
    }
    Process {
        Try {
            if (!$nic) {
                Write-Output -InputObject 0
            }
            else {
                Write-Output -InputObject 1
            }
        }
        Catch {Write-Error -Message 'No NIC variable Found'}
    }
    End {}
}#End Function CheckAzureNIC

Function CreateAzureNIC {
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
            $subnetid = (Get-AzureRmVirtualNetwork `
                    -Name $global:NetworkName `
                    -ResourceGroupName $global:ResourceGroupName `
                    -ErrorAction SilentlyContinue `
                    -WarningAction SilentlyContinue `
                    -InformationAction SilentlyContinue `
                    -Verbose ).Subnets[0].id
        }
        catch {
            Write-Error -Message 'Unable to set subnetID variable in CreateAzureNic function'
            Write-Output -InputObject 0
        }

    }
    Process {
        #TODO: DNS HARDCODED
        Try {
            $NewAzureNIC = New-AzureRmNetworkInterface `
                -ResourceGroupName $global:resourcegroupname `
                -Name $global:NICName `
                -Location $global:resourcegrouplocation `
                -SubnetId $global:subnetid `
                -DnsServer '8.8.8.8', '8.8.4.4' `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -force `
                -Verbose
        }
        catch {
            Write-Error -Message 'Unable to set NewAzureNIC variable'
        }

    }
    End {
        if ((CheckAzureNIC -Verbose) -eq 1) {
            Write-Output -InputObject 1
        }
        else {
            Write-out 0
        }
    }
}#End Function CreateAzureNIC

Function RemoveAzureNIC {
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
        if ((CheckAzureNIC -Verbose) -eq 1) {
            try {
                Remove-AzureRmNetworkInterface `
                    -Name $global:NICName `
                    -ResourceGroupName $global:ResourceGroupName `
                    -Force `
                    -ErrorAction SilentlyContinue `
                    -WarningAction SilentlyContinue `
                    -InformationAction SilentlyContinue `
                    -Verbose
                    Write-Output 1
            }

            catch {
                Write-Error -Message 'Unable to delete Nic'
                Write-Output -InputObject 0
            }
        }
        else {
            Write-Output -InputObject 0
        }
    }
    End {
    }
}#End Function RemoveAzureNIC