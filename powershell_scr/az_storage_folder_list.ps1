[System.Collections.ArrayList]$foldername = @() 
$ResourceGroupName = "cloud-shell-storage-centralindia"
$StorageAccountName = ""
$containername = "vis2"
$sas=""
$ctx = (Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName).Context

Get-AzStorageBlob -Container $containername -Context $ctx  | ForEach-Object {
$name = $_.name -split ("/")
 $foldername += $name[0]

}

$foldername | Get-Unique | ForEach-Object {
write-host "`n`nworking on folder:" $_
$url="https://csg100300009f52f5f3.blob.core.windows.net/$($containername)/$($_)/$($sas)"
.\azcopy.exe ls $url --running-tally  | select -Last 1

}
