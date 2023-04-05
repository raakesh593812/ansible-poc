Get-AzSubscription  | ForEach-Object {
"{0},{1},{2},{3}" -f ("Subscription","storageaccountname","containername","size(in MB)") | Out-File -FilePath .\test.csv
$sel = Select-AzSubscription -SubscriptionId $_.Id
$subscriptionName= $_.Name
Get-AzStorageAccount | ForEach-Object {
$ctx = (Get-AzStorageAccount -ResourceGroupName $_.ResourceGroupName -Name $_.StorageAccountName).Context

Get-AzStorageContainer -Context $ctx | ForEach-Object {

[int]$size = (Get-AzStorageBlob -Container $_.Name -Context $ctx | Measure-Object -Property length -Sum).sum
"{0},{1},{2},{3}" -f ($subscriptionName,$ctx.StorageAccountName,$_.name,[math]::Round($size/(1024*1024),3)) | Out-File -FilePath .\test.csv -Append

}
}


}
