#TODO: Document Module

<#
      .SYNOPSIS
      The "AzureResourceGroupsModule" is used to interact with Resource groups within Azure.

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

function CheckAzureResourceGroup {

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
        $resource = $false

        $rg = Get-AzureRmResourceGroup `
            -Name $global:ResourceGroupName `
            -Location $global:ResourceGroupLocation `
            -ErrorAction SilentlyContinue `
            -WarningAction SilentlyContinue `
            -InformationAction SilentlyContinue `
            -Verbose

        Write-Debug -Message 'setting CheckAzureResourceGroup Variables'
    }
    Process {
        if (!$rg) {
            $resource = $false
            Write-Debug -Message 'Resource group set false'
        }
        else {
            $resource = $true
            Write-Debug -Message 'Resource group set true'
        }
    }
    end {
        $resource
    }
}#End function CheckAzureResourceGroup
function CreateAzureResourceGroup {
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
        $resource = CheckAzureResourceGroup -Verbose
        if ($resource -eq $true) {
            Write-Output -InputObject 0
            break
        }
        else {
            $cg = New-AzureRmResourceGroup `
                -Name $global:ResourceGroupName `
                -Location $global:ResourceGroupLocation `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -ErrorAction Stop `
                -Force `
                -Verbose
        }
    }
    Process {
        Try {
            $cg
            $resource = CheckAzureResourceGroup -Verbose
            if ($resource -eq $true -and ((Get-AzureRmResourceGroup `
                            -Name $global:ResourceGroupName `
                            -Location $global:ResourceGroupLocation `
                            -ErrorAction SilentlyContinue `
                            -WarningAction SilentlyContinue `
                            -InformationAction SilentlyContinue `
                            -Verbose
                    ).ProvisioningState) -eq 'Succeeded') {
                Write-Output -InputObject 1
            }
        }
        Catch {
            Write-Error -Message 'Resource Already Exists or Resource not Found'
        }
    }
    end {
        #TODO: Set Azure Resource group $name and $location

    }
}#End function CreateAzureResourceGroup
function RemoveAzureResourceGroup {
    [CmdletBinding(SupportsShouldProcess)]
    param()
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

    Begin {
        $resource = CheckAzureResourceGroup -Verbose
        if ($resource -eq $false) {
            Write-Output -InputObject 0
            break
        }
        elseif (((Get-AzureRmResourceGroup `
                        -Name $global:ResourceGroupName `
                        -Location $global:ResourceGroupLocation `
                        -ErrorAction SilentlyContinue `
                        -WarningAction SilentlyContinue `
                        -InformationAction SilentlyContinue `
                        -Verbose
                ).ProvisioningState) -eq 'Succeeded') {
            $rg = Remove-AzureRmResourceGroup `
                -Name $global:ResourceGroupName `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Force `
                -Verbose `
                -ErrorAction Stop
        }
    }
    Process {
        Try {
            $rg
            $resource = CheckAzureResourceGroup -Verbose
            if ($resource -eq $false) {
                Write-Output -InputObject 1
            }
        }
        Catch {
            Write-Error -Message 'Resource Already Removed or Resource not Found'
        }
    }
    end {

    }
}#End function RemoveAzureResourceGroup