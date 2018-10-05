#TODO: Document Module
<#
      .SYNOPSIS
      The "AzureVMModule" is used in the interact with Virtual Machines within Azure.

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

function CheckAzureVM {
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
            $vms = Get-azurermvm `
                -ResourceGroupName $Global:ResourceGroupName `
                -Name $Global:VMName `
                -ErrorAction SilentlyContinue `
                -Verbose
        }
        Catch {
            Write-Error -Message 'Unable to set VM var in checkazurevm function'
            Write-Output -InputObject 0
        }
    }
    Process {
        Try {
            if (!$vms) {
                Write-Output -InputObject 0
            }
            else {
                Write-Output -InputObject 1
            }
        }
        Catch {Write-Error -Message 'No Virtual Machine Status variable Found'}
    }
    End {

    }

}#End Function CheckAzureVM

function CreateAzureVM {
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
            $VmCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($Global:VMLocalAdminUser, $Global:VMLocalAdminSecurePassword)
            $vmNicId = (Get-AzureRmNetworkInterface `
                    -ResourceGroupName $Global:ResourceGroupName `
                    -Name $Global:NICName `
                    -ErrorAction SilentlyContinue `
                    -WarningAction SilentlyContinue `
                    -InformationAction SilentlyContinue `
                    -Verbose
            ).Id
            $virtualmachine = New-AzureRmVMConfig `
                -VMName $Global:VMName `
                -VMSize $Global:VMsize `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
            $virtualmachine = Set-AzureRmVMOperatingSystem `
                -VM $Global:virtualmachine `
                -Windows `
                -ComputerName $Global:VMComputerName `
                -Credential $Global:VmCredential `
                -ProvisionVMAgent `
                -EnableAutoUpdate `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
            $virtualmachine = Add-AzureRmVMNetworkInterface `
                -VM $Global:virtualmachine `
                -Id $script:vmNicId `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
            $virtualmachine = Set-AzureRmVMSourceImage `
                -VM $Global:virtualmachine `
                -PublisherName 'MicrosoftWindowsServer' `
                -Offer 'WindowsServer' `
                -Skus '2016-Datacenter-with-Containers' `
                -Version latest `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose

        }
        Catch {
            Write-Error -Message 'Unable to Create Variables and objects'
            Write-Output -InputObject 0
        }
    }
    Process {

        Try {
            New-AzureRMVm `
                -ResourceGroupName $Global:ResourceGroupName `
                -Location $Global:ResourceGroupLocation `
                -VM $script:virtualmachine `
                -ErrorAction SilentlyContinue `
                -WarningAction SilentlyContinue `
                -InformationAction SilentlyContinue `
                -Verbose
            Write-Output -InputObject 1
        }
        Catch {
            Write-Error -Message 'Unable to Create Virtual machine'
            Write-Output -InputObject 0
        }
    }
    End {

    }

}#End function CreateAzureVM
function DeleteAzureVM {
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
        if ((CheckAzureVM) -eq 1) {
            try {
                Remove-AzureRmVM `
                    -Name $Global:VMName `
                    -ResourceGroupName $Global:ResourceGroupName `
                    -ErrorAction SilentlyContinue `
                    -WarningAction SilentlyContinue `
                    -InformationAction SilentlyContinue `
                    -Verbose `
                    -Force
                Write-Output -InputObject 1
            }
            Catch {
                Write-Error -Message 'Unable to delete VM'
                Write-Output -InputObject 0
            }


        }
        else {
            Write-Output -InputObject 0
        }

    }
    End {}

}#End function DeleteAzureVM