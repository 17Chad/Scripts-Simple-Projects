#Main Menu Frontend
function SnortMenu {
    param (
        [string]$Title = 'Welcome to the Snort Rule Creator! (Alpha :p)'
    )
    Clear-Host
    Write-Host "====== $Title ======`n"
    
    Write-Host "1: Press '1' if you have an IP list you want to alert on."
    Write-Host "2: Press '2' if you have a domain list you want to alert on."
    Write-Host "3: Press '3' to do nothing."
    Write-Host "q: Press 'q' to quit."
}

#Main Menu Backend
do
 {
    SnortMenu
    $selection = Read-Host "Please make a selection"
    switch ($selection)
    { '1' { 
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $TestPath = Test-Path -Path $DesktopPath\IPSnortRules.rules
    
    ##Delete or keep existing file##
    if($TestPath -eq "True"){ 
        Write-Host "You already have an 'IPSnortRules.rules' on your desktop."
        $ErrorSelection = Read-Host "Do you want to delete it and make a new one?"
        Write-Host "y: Press 'y' to delete existing file."
        Write-Host "n: Press 'n' to keep the file and exit."
        switch ($ErrorSelection)
        {'y'{
            Remove-Item -Path $DesktopPath\IPSnortRules.rules
            Write-Host "IPSnortRules.rules has been deleted off your desktop"
            pause
            clear
            break
         }'n'{
            exit
         }
         }
    ##Create file on desktop if it does not exist##
    if(Test-Path !$DesktopPath\IPSnortRules.rules){
        New-Item -Path $DesktopPath -Name "IPSnortRules.rules"
        } 
    }
    Clear
    Write-Host "======Let's make an ip snort rule! ======`n"

    ##Snort Options for user##
    $SidCounter = 0
    $YourIPFile = Read-Host "Enter the absolute path of the ip rules file."
    Write-Host '>'$YourIPFile
    $YourAction = Read-Host "Enter the action {alert/drop(block+log)/log}"
    Write-Host '>'$YourAction
    $YourProtocol = Read-Host "Enter what you want in the protocol field {ip/tcp/udp/icmp}"
    Write-Host '>'$YourProtocol
    Write-Host "Source ip is the next field, via your txt file."
    $YourMsg = Read-Host "Enter what you want in the 'msg' field {AP1 - Bad IP Detected!}"
    Write-Host '>'$YourMsg
    $YourDirection = Read-host "Enter direction {normally ->}"
    Write-Host '>'$YourDirection
    $YourDestIP = Read-Host "Enter the destination ip {any/$HOME_NET}"
    Write-Host '>'$YourDestIP
    
    ##Loop takes in ip address list and makes Snort rules##
    Get-Content $YourIPFile | ForEach-Object { 
        $Sidcounter ++
        $Backend = $YourDirection + ' ' + $YourDestIP + " any (msg: `"$YourMsg`"; sid:1000000"
        $IPSnortFormat = $YourAction + ' ' + $YourProtocol + ' ' + $_ + ' any ' + $Backend + $Sidcounter +';)'
        $IPSnortFormat | Out-File -FilePath $DesktopPath\IPSnortRules.rules -Append 
    }
    Write-Host "Your file has been created on your desktop: IPSnortRules.rules"
    pause
    exit
    
    } '2' { 
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
    $TestPath = Test-Path -Path $DesktopPath\DomainSnortRules.rules
    
    ##Delete or keep existing file##
    if($TestPath -eq "True"){ 
        Write-Host "You already have an 'DomainSnortRules.rules' on your desktop."
        $ErrorSelection = Read-Host "Do you want to delete it and make a new one?"
        Write-Host "y: Press 'y' to delete existing file."
        Write-Host "n: Press 'n' to keep the file and exit."
        switch ($ErrorSelection)
        {'y'{
            Remove-Item -Path $DesktopPath\DomainSnortRules.rules
            Write-Host "IPSnortRules.rules has been deleted off your desktop"
            pause
            clear
            break
         }'n'{
            exit
         }
         }
    ##Create file on desktop if it does not exist##
    if(Test-Path !$DesktopPath\DomainSnortRules.rules){
        New-Item -Path $DesktopPath -Name "IPSnortRules.rules"
        } 
    }
    Clear
    Write-Host "======Let's make a domain snort rule! ======`n"

    ##Snort Options for user##
    $SidCounterD = 200
    $YourDomainFile = Read-Host "Enter the absolute path of the domain rules file."
    Write-Host '>'$YourDomainFile
    
    ##Loop takes in ip address list and makes Snort rules##
    Get-Content $YourDomainFile | ForEach-Object { 
        $SidcounterD ++
        $DomainSnortFormat = 'alert ip any any <> any any ' + "(msg: `"$_`"; pcre: `"`/$_`/`"; sid: 1000000100" + $SidcounterD + ';)'
        $DomainSnortFormat | Out-File -FilePath $DesktopPath\DomainSnortRules.rules -Append 
    }
    Write-Host "Your file has been created on your desktop: DomainSnortRules.rules"
    pause
    exit

    } '3' {
      'You chose option #3'
    }
    }
    pause
 }
 until ($selection -eq 'q')