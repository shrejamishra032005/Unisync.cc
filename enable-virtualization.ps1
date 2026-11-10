# Enable Windows virtualization features required by Docker Desktop

Write-Host "Running virtualization enablement for Docker Desktop..."

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -All -NoRestart

Write-Host "Virtualization features enabled. A reboot is required."
Write-Host "Please restart Windows and then launch Docker Desktop again."
