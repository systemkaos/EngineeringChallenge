#Todo: Document
<#
      .SYNOPSIS
      The "AzureEnvironmentLoginModule" will help you log into Azure.

      .DESCRIPTION


      .EXAMPLE
      CheckAzurePowershellModule
      Describe what this call does

      .NOTES
      Place additional notes here.

      .INPUTS
      List of input types that are accepted by this function.

      .OUTPUTS
      List of output types produced by this function.
  #>

[CmdletBinding(SupportsShouldProcess)]
Param()

function AzurePowershellLogin {
    <#
      .SYNOPSIS
      Will check if you need to login with powershell to Azure

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
        $needLogin = $true

    }

    Process {

        Try {
            $content = Get-AzureRmContext -Verbose
            if ($content) {

                $needLogin = ([string]::IsNullOrEmpty($content.Account))
            }
        }
        Catch {
            if ($_ -like '*Login-AzureRmAccount to login*') {
                $needLogin = $true
            }
            else {
                Write-Error -Message ('You need to login {0}' -f $needlogin) -Verbose
            }
        }
    }
    End {
        Try {
            if ($needLogin) {
                $null = Connect-AzureRmAccount -Force -Verbose
                Write-Output -InputObject 'Connected to your Azure account'
                #Connect-AzureRmAccount -Force
                Write-Output -InputObject 1
            }
        }
        Catch {
            Write-Error -Message 'Unable to login'
            break
        }

    }
}#End function AzurePowershellLogin

Function CheckAzureLogin {
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

    begin {
        $content = Get-AzureRmContext -Verbose
        $needLogin = ([string]::IsNullOrEmpty($content.Account))
    }
    Process {
        if ($needlogin -eq $true) {
            #User NJeeds to login
            $needLogin = $true
            #Write-Output -InputObject 1
            Write-Debug -Message 'You need to login to Azure'
        }
        else {
            #user is logged in
            $needLogin = $false
            #Write-Output -InputObject 0
            Write-Debug -Message 'Already Logged into Azure'
        }
    }
    End {
        $needLogin
    }
}#End Function CheckAzureLogin

function LogoutAzure {
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
    $needLogin = CheckAzureLogin -Verbose
    if ($needLogin -eq $true) {
        Write-Output -InputObject "You're Already Logged out"
        #break
    }
    elseif ($needLogin -eq $false -or !$needLogin) {
        Disconnect-AzureRmAccount -Verbose
        Write-Output -InputObject 'Logged out of Azure'
    }
}#End function LogoutAzure