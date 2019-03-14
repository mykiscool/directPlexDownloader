# Direct Plex Downloader
# Downloads Media from a plex server
# Author: NinthWalker
# https://github.com/ninthwalker/directPlexDownloader
# Updated: 16MAR2016
# 
######## Variables. Set to the correct values ########
######################################################

# Token specific for the server you are accessing.
$TOKEN = "enter server token here"

# Actual ip:port, plex.direct:port, or url of plex server
# ie: https://43.134.28.231:32400
# ie: "https://43-134-28-231.af3e77ad3484fc98113453526hf5433.plex.direct:5280"
# ie: https://watch.myplexmovies.com
$URL = "enter ip/hostname:port here"

# Local path to save filesto
# ie: c:\temp\my_downloads\
$PATH = "enter path here"

######################################################
########## DO NOT MODIFY THE BELOW SETTINGS ##########
######################################################

#setup environment
#ignore cert error
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$start_time = Get-Date
Import-Module BitsTransfer

#metadata id can be found on the end of a url when browsing a movie or tv show in plex web.
#ask for movie/show id and set url
Write-Host "Enter in the Movie or TV Show" -NoNewline
Write-Host " Metadata ID" -ForegroundColor Yellow -NoNewline
Write-Host " (ie: 374348): " -NoNewline
$id = Read-Host
#write-host "the dasdasd asd" -ForegroundColor yellow
#$id = Read-Host "Enter in the Movie or TV Show metadata ID (ie: 81768)" -ForegroundColor yellow
$actualurl = $url + "/library/metadata/" + $id + "?X-Plex-Token=" + $token

# search xml for real download path
[xml]$xml = (New-Object System.Net.WebClient).DownloadString($actualurl)
$dl_url =  $url + "$($xml.MediaContainer.Video.Media.Part.key)" + "?download=1&X-Plex-Token=" + $token
Start-Process "chrome.exe" "$dl_url"
