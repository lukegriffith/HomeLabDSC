
if (!(Get-Module xHyper-V -ea SilentlyContinue)) {
    Install-Module xHyper-V -Force
}

if (!(Get-Module cChoco -ea SilentlyContinue)) {
    Install-Module cChoco -Force
}

Import-Module $PSScriptRoot\Lab





Configuration HomeLab {


    HyperVConfiguration

    ChocoPackages

}

HomeLab