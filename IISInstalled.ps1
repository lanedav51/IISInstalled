$TxtPath = "InsertPathHere"
$File = Import-Csv $TxtPath
$Computers = $File.Computers
$i = 0
foreach($Computer in $Computers)
{
    Enter-PSSession -ComputerName $Computer
    $Service = Get-Service -ComputerName $Computer w3svc -ErrorAction SilentlyContinue
    $obj = new-object psobject -Property @{
        ComputerName = $Computer
    }
    if($Service)
    {
        Write-Host "$Computer has IIS"
    }
    elseif($i -eq 0)
    {
        $obj | Export-Csv -Path '(get-date -f yyyy-MM-dd)IISNotInstalled.csv'
        $i++
    }
    else
    {
        $obj | Export-Csv -Path '(get-date -f yyyy-MM-dd)IISNotInstalled.csv' -Append
        $i++
    }
    Exit-PSSession
}