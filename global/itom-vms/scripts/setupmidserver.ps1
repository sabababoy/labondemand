$content = Get-Content 'C:\Servicenow\mid\agent\config.xml'

$content = $content -replace 'YOUR_INSTANCE.service-now.com', 'empakarmazin.service-now.com'
$content = $content -replace 'YOUR_INSTANCE_USER_NAME_HERE', 'testMidServer'
$content = $content -replace 'YOUR_INSTANCE_PASSWORD_HERE', 'testPassword1!'
$content = $content -replace 'YOUR_MIDSERVER_NAME_GOES_HERE', 'testMidServer'

$content | Set-Content 'C:\Servicenow\mid\agent\config.xml'