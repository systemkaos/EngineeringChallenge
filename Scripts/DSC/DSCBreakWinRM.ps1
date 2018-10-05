
Configuration DSCBreakWinRm
{
    #Not needed in Azure
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node webserver
    {
        Script ConfigureWinRM {
            SetScript  = {
                Set-NetFirewallProfile -Name Public -DefaultInboundAction Allow
                if ((get-service -Name WinRM).Status -ne 'Running') {
                    Write-host 'Service not running'
                    Start-Service -Name WinRM -ErrorAction SilentlyContinue
                    If ((get-service -Name WinRM).Status -eq 'Running') {
                        $winrmRunning = $true
                        $winrmRunning
                    }
                    else {
                        $winrmRunning = $false
                        $winrmRunning
                    }
                }
                else {
                    $winrmRunning = $true
                    $winrmRunning
                }
                #Run on local machine
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value "1" -PropertyType DWORD -Force
                Enable-PsRemoting -Force
                Set-Item WSMan:\localhost\Client\TrustedHosts -Value (($ConfigurationData.AllNodes).TrustedHosts) -Force
            }
            TestScript = {
                Set-NetFirewallProfile -Name Public -DefaultInboundAction Allow
                if ((get-service -Name WinRM).Status -ne 'Running') {
                    Write-host 'Service not running'
                    Start-Service -Name WinRM -ErrorAction SilentlyContinue
                    If ((get-service -Name WinRM).Status -eq 'Running') {
                        $winrmRunning = $true
                        $winrmRunning
                    }
                    else {
                        $winrmRunning = $false
                        $winrmRunning
                    }
                }
                else {
                    $winrmRunning = $true
                    $winrmRunning
                }
            }
            GetScript  = {
                Set-NetFirewallProfile -Name Public -DefaultInboundAction Allow
                if ((get-service -Name WinRM).Status -ne 'Running') {
                    Write-host 'Service not running'
                    Start-Service -Name WinRM -ErrorAction SilentlyContinue
                    If ((get-service -Name WinRM).Status -eq 'Running') {
                        $winrmRunning = $true
                        $winrmRunning
                    }
                    else {
                        $winrmRunning = $false
                        $winrmRunning
                    }
                }
                else {
                    $winrmRunning = $true
                    $winrmRunning
                }
                New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value "1" -PropertyType DWORD -Force
                Enable-PsRemoting -Force
                Set-Item WSMan:\localhost\Client\TrustedHosts -Value (($ConfigurationData.AllNodes).TrustedHosts) -Force
            }# end GetScript
        }
    }
}