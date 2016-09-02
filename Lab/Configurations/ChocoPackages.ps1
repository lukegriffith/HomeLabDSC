

Configuration ChocoPackages {


    Import-DSCResource -ModuleName "cChoco" -ModuleVersion 2.2.0.63

    cChocoInstaller Choco {
        InstallDir = "C:\Temp"
    }

    $Packages = @(
        [pscustomobject]@{ Package = '7zip.install' ; Version = 16.02.0.20160811 }
        [pscustomobject]@{ Package = 'ccleaner' ; Version = 5.21.5700 }
        [pscustomobject]@{ Package = 'chocolatey' ; Version = 0.10.0 }
        [pscustomobject]@{ Package = 'ConEmu' ; Version = 16.8.28.0 }
        [pscustomobject]@{ Package = 'DotNet4.5' ; Version = 4.5.20120822 }
        [pscustomobject]@{ Package = 'DotNet4.5.1' ; Version = 4.5.1.20140606 }
        [pscustomobject]@{ Package = 'git.install' ; Version = 2.9.3 }
        [pscustomobject]@{ Package = 'nodejs' ; Version = 6.5.0 }
        [pscustomobject]@{ Package = 'notepadplusplus.install' ; Version = 6.9.2 }
        [pscustomobject]@{ Package = 'NugetPackageExplorer' ; Version = 3.18 }
        [pscustomobject]@{ Package = 'ruby' ; Version = 2.3.0 }
        [pscustomobject]@{ Package = 'skype' ; Version = 7.27.0.101 }
        [pscustomobject]@{ Package = 'sysinternals' ; Version = 2016.08.29 }
        [pscustomobject]@{ Package = 'VisualStudioCode' ; Version = 1.4 }
        [pscustomobject]@{ Package = 'vlc' ; Version = 2.2.4 }
    )

    $Packages | ForEach-Object -Process { 
        
        cChocoPackageInstaller $_.Package {
            
            Name = $_.Package
            Version = $_.Version
            Ensure = "Present"
        }
    }

}