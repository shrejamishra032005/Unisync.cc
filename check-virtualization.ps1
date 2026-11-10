$out = 'C:\Users\omsat\OneDrive\Desktop\unisync-main\virtualization-check.txt'
Remove-Item $out -ErrorAction SilentlyContinue
Add-Content $out "=== CHECK START ==="
Add-Content $out "Date: $(Get-Date)"
Add-Content $out ""
Add-Content $out "=== VIRTUALIZATION FEATURES ==="
try {
    Get-WindowsOptionalFeature -Online | Where-Object FeatureName -match 'Hyper-V|VirtualMachinePlatform|WindowsSubsystemForLinux' | Format-Table FeatureName, State -AutoSize | Out-String | Add-Content $out
} catch {
    Add-Content $out "ERROR: $($_.Exception.Message)"
}
Add-Content $out ""
Add-Content $out "=== WSL STATUS ==="
try {
    wsl --status 2>&1 | Out-String | Add-Content $out
} catch {
    Add-Content $out "ERROR: $($_.Exception.Message)"
}
Add-Content $out ""
Add-Content $out "=== SYSTEMINFO VIRTUALIZATION ==="
try {
    systeminfo | Select-String 'Virtualization|Hyper-V Requirements|Second Level Address Translation|Data Execution Prevention' | Out-String | Add-Content $out
} catch {
    Add-Content $out "ERROR: $($_.Exception.Message)"
}
Add-Content $out "=== CHECK END ==="
Write-Host "Wrote virtualization check to $out"