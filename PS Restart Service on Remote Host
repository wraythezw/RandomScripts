[int]$xMenuChoiceA = 0
[string]$myServiceName;
[string]$myRemoteHost = "remote host fqdn or ip";
while ( $xMenuChoiceA -lt 1 -or $xMenuChoiceA -gt 4 ){
Write-host "1. service name"
Write-host "2. service name"
Write-host "3. service name"
Write-host "4. Quit and exit"
[Int]$xMenuChoiceA = read-host "Please enter an option 1 to 4..." }


$username = "Domain\Administrator"
$password = (cat C:\script\secure.txt | convertto-securestring)
$cred = (new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $username, $password)


function RestartMyService(){
    
    StopMyService
    Start-Sleep -s 2
    PrintServiceStatus
    StartMyService
    Start-Sleep -s 2    
    PrintServiceStatus
}


function StopMyService(){
    echo ("Stopping service " + $myServiceName + "(" + $myRemoteHost + ")")
        $scriptBlock = {
            param ( $myRemoteHost, $myServiceName )
            $myService = get-service -ComputerName $myRemoteHost -Name $myServiceName
            if($myService.Status -eq "Stopped"){
                echo "Service already stopped..."
            }else{
                $myService.Stop();
                echo ("Stopped service " + $myServiceName + "(" + $myRemoteHost + ")")
            }
        }
    Invoke-Command -ComputerName $myRemoteHost -Credential $cred -ScriptBlock $scriptBlock -ArgumentList $myRemoteHost, $myServiceName
}

function StartMyService(){
    echo ("Starting service " + $myServiceName + "(" + $myRemoteHost + ")")
        $scriptBlock = {
            param ( $myRemoteHost, $myServiceName )
            $myService = get-service -ComputerName $myRemoteHost -Name $myServiceName
            if($myService.Status -eq "Running"){
                echo "Service already running..."
            }else{
                $myService.Start();
                echo ("Started service " + $myServiceName + "(" + $myRemoteHost + ")")
            }
        }
    Invoke-Command -ComputerName $myRemoteHost -Credential $cred -ScriptBlock $scriptBlock -ArgumentList $myRemoteHost, $myServiceName  
}

function PrintServiceStatus(){
    $scriptBlock = {
        param ( $myRemoteHost, $myServiceName )
        $colitems = Get-Service -ComputerName $myRemoteHost -Name $myServiceName | Write-Output
        foreach ($objitem in $colitems){
        if ($objitem.status -eq "Stopped"){
            write-host Name: $objitem.DisplayName, ---- Status: $objitem.status -ForegroundColor "Red" }
        if ($objitem.status -eq "Running"){
            write-host Name: $objitem.DisplayName, ---- Status: $objitem.status -ForegroundColor "green" }
        }
    }
    Invoke-Command -ComputerName $myRemoteHost -Credential $cred -ScriptBlock $scriptBlock -ArgumentList $myRemoteHost, $myServiceName
}

Switch( $xMenuChoiceA ){
  1{
    $myServiceName = "service name"
    RestartMyService
  }
  2{
    $myServiceName = "service name"
    RestartMyService
  }
  3{
    $myServiceName = "service name"
    RestartMyService
  }
default{<#run a default action or call a function here #>}
}
