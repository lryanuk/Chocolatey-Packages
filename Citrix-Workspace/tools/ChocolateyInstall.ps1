﻿## Template VirtualEngine.Build ChocolateyInstall.ps1 file for EXE/MSI installations

$citrixReleaseWebPage = "https://www.citrix.com/downloads/workspace-app/legacy-workspace-app-for-windows/workspace-app-for-windows-1903.html"
$checksumFromReleasePage = "086DBE728BFBA427D1DF28C3A7ADEB072CD3878758084A547879759EE36064B5"

$response = Invoke-WebRequest $citrixReleaseWebPage
$relLink = $response.Links | Where-Object { $_.href -eq "#ctx-dl-eula" } | Select rel
$downloadLink = "http:" + $relLink.rel

$installChocolateyPackageParams = @{
    PackageName    = 'Citrix-Workspace';
    FileType       = 'EXE';
    SilentArgs     = '/noreboot /silent';
    Url            = '$downloadLink';
    ValidExitCodes = @(0,3010);
    Checksum       = '$checksumFromReleasePage';
    ChecksumType   = 'sha256';
}
Install-ChocolateyPackage @installChocolateyPackageParams;