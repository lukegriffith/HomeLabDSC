﻿
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

    
    xVHD 2016VHD {
        
        Name = "2016tp.vhdx"
        Generation = "Vhdx"
        Path = "D:\Hyper-V\vhd"
    }


    xVMHyperV 2016tp { 
        
        Name = "2016tp"
        VhdPath = "D:\Hyper-V\vhd\2016tp.vhdx"
        Ensure = "Present"
        SwitchName = "VM-Network"

    }






}