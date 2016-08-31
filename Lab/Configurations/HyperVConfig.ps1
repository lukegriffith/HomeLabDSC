
Configuration HyperVConfiguration {


    Import-DscResource -ModuleName 'xHyper-V'
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'

    file temp {

        DestinationPath = "C:\Temp" 
        Type = 'Directory'
        Force = $true
        Ensure = "Present"
    }


    file FreeBSD-Ios {
        
        DestinationPath = "C:\Temp\FreeBSD-10.3-RELEASE-bootonly.iso"
        SourcePath = "C:\Users\lukem\Downloads\FreeBSD-10.3-RELEASE-amd64-bootonly.iso"
        Ensure = "Present"
        Type = "File"
        DependsOn = "[File]Temp"

    }


    xVMSwitch ExternalSwitch {
        Name = "External-Switch"
        Type = "External"
        AllowManagementOS = $true
        NetAdapterName = "Wi-Fi"
    }

    xVHD FreeBSD-VHD {
        
        Name = "FreeBDSVHD.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
        MaximumSizeBytes = 1e+10
    }

    xVMHyperV FreeBSD-VM {

        Name = "FreeBDS-VM"
        VhdPath = "D:\Hyper-V\vhd\FreeBDSVHD.vhdx"
        Ensure = "Present"
        SwitchName = "External-Switch"
        DependsOn = "[xVHD]FreeBSD-VHD", "[xVMSwitch]ExternalSwitch", "[File]FreeBSD-Ios"
    }


}