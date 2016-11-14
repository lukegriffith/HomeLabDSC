
Configuration HyperVConfiguration {


    Import-DscResource -ModuleName 'xHyper-V'
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    
    file temp {

        DestinationPath = "C:\Temp" 
        Type = 'Directory'
        Force = $true
        Ensure = "Present"
    }


    file FreeBSDIos {
        
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

    xVMSwitch VM-Network {
        Name = "VM-Network"
        Type = "Private"
    }

    xVHD FreeBSDVHD {
        
        Name = "FreeBDSVHD.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
        MaximumSizeBytes = 1e+10
    }

    xVMHyperV FreeBSDVM {

        Name = "FreeBDS-VM"
        VhdPath = "D:\Hyper-V\vhd\FreeBDSVHD.vhdx"
        Ensure = "Present"
        SwitchName = "External-Switch", "VM-Network"
        DependsOn = "[xVHD]FreeBSDVHD", "[xVMSwitch]ExternalSwitch", "[File]FreeBSDIos"
    }

    
    xVHD TPVHD {
        
        Name = "2016-DC.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
        MaximumSizeBytes = 1.27e+11

    }


    xVMHyperV 2016-dc { 
        
        Name = "2016-DC"
        VhdPath = "D:\Hyper-V\vhd\2016-DC.vhdx"
        Ensure = "Present"
        SwitchName = "VM-Network"
        DependsOn = "[xVHD]TPVHD"
    }

    xVHD wksVHD {
        
        Name = "wks.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
        MaximumSizeBytes = 2.5e+10

    }


    xVMHyperV wks { 
        
        Name = "wks"
        VhdPath = "D:\Hyper-V\vhd\wks.vhdx"
        Ensure = "Present"
        SwitchName = "VM-Network"
        DependsOn = "[xVHD]wksVHD"
    }



    xVHD rrasVHD {
        
        Name = "rras.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
        MaximumSizeBytes = 2.5e+10

    }


    xVMHyperV 2016core { 
        
        Name = "2016core"
        VhdPath = "D:\Hyper-V\vhd\16c.vhdx"
        Ensure = "Present"
        SwitchName = "External-Switch", "VM-Network"
        DependsOn = "[xVHD]2016coreVHD"
    }


        xVHD 2016coreVHD {
        
        Name = "16c.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
        MaximumSizeBytes = 2.5e+10

    }


    xVMHyperV rras { 
        
        Name = "rras"
        VhdPath = "D:\Hyper-V\vhd\rras.vhdx"
        Ensure = "Present"
        SwitchName = "External-Switch", "VM-Network"
        DependsOn = "[xVHD]rrasVHD"
    }



}