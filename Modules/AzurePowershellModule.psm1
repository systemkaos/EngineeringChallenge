#TODO: Document Module
<#
      .SYNOPSIS
      The "AzurePowershellModule" will load the AzureRM Module for you.

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

function CheckAzurePowershellModule {
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
        try {
            $AzureModuleLoaded = $false
            $m = 'AzureRM'
            $x = Get-Module -Name $m -Verbose
        }
        Catch {
            Write-Error -Message 'Unable to load variables' -Exception 1
            Write-Output -InputObject 0
            break
        }
    }#end begin

    Process {
        try {
            #Import-Module -Name $m
            if (!$x -and !$AzureModuleLoaded) {
                $AzureModuleLoaded = $false
                Write-Output -InputObject 0
                break
            }

            Elseif ($xname -eq 'PSModuleInfo') {
                $AzureModuleLoaded = $true
                #Write-Output -InputObject 1
            }
            Else {
                #INFO: This might be dangerous to add in the Else
                $AzureModuleLoaded = $true
                #Write-Output -InputObject 1
            }

        }
        Catch {
            write-error -message 'If Statements are broken' -ErrorAction Stop
            Write-Output -InputObject 0
            break
        }
    }#end process
    End {
        Try {
            $AzureModuleLoaded
        }
        catch {
            write-error -message 'Variable isnt populated'
            Write-Output -InputObject 0
        }
    }#end end






}#End Function CheckAzurePowershellModule
function UnLoadAzurePowerShellModule {
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
        try {
            $AzureModuleLoaded = $false
            $m = 'AzureRM'
            $x = Get-Module -Name $m -Verbose
            $rm = Remove-Module -Name AzureRM -Force -Verbose
        }
        Catch {
            Write-Error -Message 'Unable to load variables'
            Write-Output -InputObject 0
            break
        }
    }#end begin

    Process {
        try {
            #Import-Module -Name $m
            if (!$x -and !$AzureModuleLoaded) {
                $AzureModuleLoaded = $false
                Write-Output -InputObject 0
                break
            }
            Elseif ($xname -eq 'PSModuleInfo') {
                $AzureModuleLoaded = $true
                try {
                    $rm
                    Write-out 1
                }
                Catch {
                    Write-Error -Message ('unable to unload {0}' -f $m)
                    Write-Output -InputObject 0
                    break
                }
            }
            Else {
                $AzureModuleLoaded = $true
                try {
                    $rm
                    Write-Output -InputObject 1
                }
                Catch {
                    Write-Error -Message ('unable to unload {0}' -f $m)
                    Write-Output -InputObject 0
                    break
                }
            }

        }
        Catch {
            write-error -message 'If Statements are broken'
            Write-Output -InputObject 0
            break
        }
    }#end process
    End {
        Try {
            $AzureModuleLoaded
        }
        catch {
            write-error -message 'Variable isnt populated'
            Write-Output -InputObject 0
        }
    }

}
function LoadAzurePowerShellModule {
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
        try {
            $AzureModuleLoaded = $false
            $m = 'AzureRM'
            $x = Get-Module -Name $m
            $rm = Import-Module -Name AzureRM `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Force `
                -Verbose
        }
        Catch {
            Write-Error -Message 'Unable to load variables'
            Write-Output -InputObject 0
            break
        }
    }#end begin

    Process {
        try {
            #Import-Module -Name $m
            if (!$x -and !$AzureModuleLoaded) {
                $AzureModuleLoaded = $false
                Write-Output -InputObject 0
                break
            }
            Elseif ($xname -eq 'PSModuleInfo') {
                $AzureModuleLoaded = $true
                try {
                    $rm
                    Write-Output -InputObject 1
                }
                Catch {
                    Write-Error -Message ('unable to unload {0}' -f $m)
                    Write-Output -InputObject 0
                    break
                }
            }
            Else {
                $AzureModuleLoaded = $true
                try {
                    $rm
                    Write-Output -InputObject 1
                }
                Catch {
                    Write-Error -Message ('unable to unload {0}' -f $m)
                    Write-Output -InputObject 0
                    break
                }
            }

        }
        Catch {
            write-error -message 'If Statements are broken'
            Write-Output -InputObject 0
            break
        }
    }#end process
    End {
        Try {
            $AzureModuleLoaded
        }
        catch {
            write-error -message 'Variable isnt populated'
            Write-Output -InputObject 0
        }
    }

}