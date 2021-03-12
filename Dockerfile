FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
RUN Invoke-WebRequest https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi -OutFile c:\webdeploy.msi; \
 Start-Process -FilePath 'c:\webdeploy.msi' -ArgumentList '/quiet', '/NoRestart', '/passive', 'ADDLOCAL=ALL', 'LicenseAccepted="0"' -Wait; \
 Remove-Item c:\webdeploy.msi -Force; \
 Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem\' -name LongPathsEnabled -value 1;
COPY ["./MandatoryArtifacts.zip", "C:/AppModnzData/MandatoryArtifacts.zip"]
COPY ./Entryscript.ps1 c:/Entryscript.ps1
ENTRYPOINT powershell c:/Entryscript.ps1
EXPOSE 3552
