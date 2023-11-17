# Docs: https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/09-functions?view=powershell-7.3

# See list of appropriate verbs: Get-Verb | Sort-Object -Property Verb
# See functions with regex name: Get-ChildItem -Path Function:\Get-*Version
# Remove function: Get-ChildItem -Path Function:\Get-*Version | Remove-Item
# Remove-Module -Name <ModuleName>
function Get-MrPSVersion {
    $PSVersionTable.PSVersion
}

# See Common parameters: Get-Command -Name Test-MrParameter -Syntax
# Or (Get-Command -Name Test-MrParameter).Parameters.Keys
function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}

# Example Usage: Get-MrParameterCount -ParameterName ComputerName, Computer, ServerName, Host, Machine
function Get-MrParameterCount {
    param (
        [string[]]$ParameterName
    )

    foreach ($Parameter in $ParameterName) {
        $Results = Get-Command -ParameterName $Parameter -ErrorAction SilentlyContinue

        [pscustomobject]@{
            ParameterName = $Parameter
            NumberOfCmdlets = $Results.Count
        }
    }
}

# --- Advanced Functions ---

function Test-MrParameter {

    param (
        $ComputerName
    )

    Write-Output $ComputerName

}

function Test-MrCmdletBinding {

    [CmdletBinding()] #<<-- This turns a regular function into an advanced function
    param (
        $ComputerName
    )

    Write-Output $ComputerName

}

# Docs: https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-shouldprocess?view=powershell-7.3
# Example usage: Test-MrSupportsShouldProcess -ComputerName "test" -WhatIf
# Example usage: Test-MrSupportsShouldProcess -ComputerName "test" -Confirm
function TestMrSupportsShouldProcess {

    [CmdletBinding(SupportsShouldProcess)]
    param ()

    $file = Get-ChildItem './myfile1.txt'
    if($PSCmdlet.ShouldProcess($file.Name)){
        Remove-Item -Path $file.FullName -Confirm:$false
    }

}

function Test-MrParameterValidation {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    Write-Output $ComputerName

}

# Use Write-Verbose instead of inline comments
# To run command with verbose: Test-MrVerboseOutput -ComputerName Server01, Server02 -Verbose
function Test-MrVerboseOutput {

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME
    )

    foreach ($Computer in $ComputerName) {
        Write-Verbose -Message "Attempting to perform some action on $Computer"
        Write-Output $Computer
    }

}

function Test-MrPipelineInput {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
            Write-Output $ComputerName
    }

}

function Test-MrErrorHandling {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline,
                   ValueFromPipelineByPropertyName)]
        [string[]]$ComputerName
    )

    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                Test-WSMan -ComputerName $Computer -ErrorAction Stop
            }
            catch {
                Write-Warning -Message "Unable to connect to Computer: $Computer"
            }
        }
    }

}

# Comment-Based Help
function Get-MrAutoStoppedService {

    <#
    .SYNOPSIS
        Returns a list of services that are set to start automatically, are not
        currently running, excluding the services that are set to delayed start.
    
    .DESCRIPTION
        Get-MrAutoStoppedService is a function that returns a list of services from
        the specified remote computer(s) that are set to start automatically, are not
        currently running, and it excludes the services that are set to start automatically
        with a delayed startup.
    
    .PARAMETER ComputerName
        The remote computer(s) to check the status of the services on.
    
    .PARAMETER Credential
        Specifies a user account that has permission to perform this action. The default
        is the current user.
    
    .EXAMPLE
         Get-MrAutoStoppedService -ComputerName 'Server1', 'Server2'
    
    .EXAMPLE
         'Server1', 'Server2' | Get-MrAutoStoppedService
    
    .EXAMPLE
         Get-MrAutoStoppedService -ComputerName 'Server1' -Credential (Get-Credential)
    
    .INPUTS
        String
    
    .OUTPUTS
        PSCustomObject
    
    .NOTES
        Author:  Mike F Robbins
        Website: http://mikefrobbins.com
        Twitter: @mikefrobbins
    #>
    
    [CmdletBinding()]
    param (
    
    )
    
    #Function Body
    
}