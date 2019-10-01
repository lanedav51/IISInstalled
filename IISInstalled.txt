$TxtPath = "InsertPathHere"
$File = Import-Csv $TxtPath
$Computers = $File.Computers

foreach($Computer in $Computers)
{
    Enter-PSSession -ComputerName $Computer
    $Service = Get-Service -ComputerName $Computer w3svc -ErrorAction SilentlyContinue
    $i = 0
    $obj = new-object psobject -Property @{
        ComputerName = $Computer
    }
    if($Service)
    {
        Write-Host "$Computer has IIS"
    }
    elseif($i -eq 0)
    {
        $obj | Export-Csv -Path IISNotInstalled.csv
        $i++
    }
    else
    {
        $obj | Export-Csv -Path IISNotInstalled.csv -Append
        $i++
    }
    Exit-PSSession
}