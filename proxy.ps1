function Get-ProxySettings {
    $proxySettings = @{}
    $regPath = "Software\Microsoft\Windows\CurrentVersion\Internet Settings"

    try {
        # Get a list of all user profiles on the computer
        $profileList = Get-WmiObject -Query "SELECT * FROM Win32_UserProfile" |
            ForEach-Object { $_.LocalPath }

        # Iterate through all user profiles
        foreach ($profilePath in $profileList) {
            try {
                $proxyKey = Get-ItemProperty -Path "Registry::HKEY_USERS\$($profilePath.Replace('\', ''))\$regPath"
                $proxyEnabled = $proxyKey.ProxyEnable
                $proxyServer = $proxyKey.ProxyServer

                # Store the proxy settings in the dictionary
                $proxySettings[$profilePath] = @{
                    ProxyEnabled = $proxyEnabled
                    ProxyServer = $proxyServer
                }
            }
            catch {
                # Ignore errors and continue to the next profile
            }
        }
    }
    catch {
        Write-Error "Error: $_"
    }

    return $proxySettings
}

# Call the function and retrieve the proxy settings
$proxySettings = Get-ProxySettings

# Display the proxy settings for all user profiles
Write-Host "Proxy settings for all user profiles:"
foreach ($profilePath in $proxySettings.Keys) {
    Write-Host "Profile: $profilePath"
    Write-Host "Proxy Enabled: $($proxySettings[$profilePath].ProxyEnabled)"
    Write-Host "Proxy Server: $($proxySettings[$profilePath].ProxyServer)"
    Write-Host "-----"
}
