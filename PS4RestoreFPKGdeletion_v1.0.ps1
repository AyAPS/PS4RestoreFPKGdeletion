# version 13/09/2021
CLS
Remove-Variable -Name ipPLAY,ftps4,port,goldhen,pathBDD,requestBDD,date,compteur,exclusions,connexionDB,commande,adapter,dataset -ErrorAction SilentlyContinue
Remove-Variable -Name tables,tablePROD,tablesPROD,sqlAPP,adapterAPP,dataAPP,needFIX,jeu,update,ftp,local,distant,uri,webclient,upload -ErrorAction SilentlyContinue
Write-Host "  _____   _____ _  _   _____           _                 ______ _____  _  _______     _      _      _   _"             
Write-Host " |  __ \ / ____| || | |  __ \         | |               |  ____|  __ \| |/ / ____|   | |    | |    | | (_)"            
Write-Host " | |__) | (___ | || |_| |__) |___  ___| |_ ___  _ __ ___| |__  | |__) | ' / |  __  __| | ___| | ___| |_ _  ___  _ __"  
Write-Host " |  ___/ \___ \|__   _|  _  // _ \/ __| __/ _ \| '__/ _ \  __| |  ___/|  <| | |_ |/ _  |/ _ \ |/ _ \ __| |/ _ \| '_ \"
Write-Host " | |     ____) |  | | | | \ \  __/\__ \ || (_) | | |  __/ |    | |    | . \ |__| | (_| |  __/ |  __/ |_| | (_) | | | |"
Write-Host " |_|    |_____/   |_| |_|  \_\___||___/\__\___/|_|  \___|_|    |_|    |_|\_\_____|\__,_|\___|_|\___|\__|_|\___/|_| |_|"
Start-Sleep -Milliseconds 150
Write-Host " b" -NoNewline
Start-Sleep -Milliseconds 150
Write-Host "y " -NoNewline
Start-Sleep -Milliseconds 200
Write-Host "A" -ForegroundColor Cyan -NoNewline
Start-Sleep -Milliseconds 200
Write-Host "y" -ForegroundColor Cyan -NoNewline
Start-Sleep -Milliseconds 200
Write-Host "A" -ForegroundColor Cyan

Try {Add-Type -Path "C:\Program Files\System.Data.SQLite\2015\bin\System.Data.SQLite.dll" -ErrorAction Stop}

Catch {

    Write-Host "`n`t`t`tERREUR: " -ForegroundColor Red
    Write-Host "`t`t`tSystem.Data.SQLite.dll" -NoNewline -ForegroundColor Yellow
    Write-Host " n'existe pas à son emplacement par défaut " -ForegroundColor Red
    Write-Host "`t`t`t(" -NoNewline -ForegroundColor Red
    Write-Host "C:\Program Files\System.Data.SQLite\2015\bin\System.Data.SQLite.dll" -NoNewline -ForegroundColor Yellow
    Write-Host ")" -ForegroundColor Red
    Write-Host "`t`t`tVérifiez que vous avez bien installé les assemblies SQLite" -ForegroundColor Red
    Write-Host "`t`t`tIndiquez le chemin COMPLET de votre DLL:`t" -NoNewline
    $dll = Read-Host

    Try {Add-Type -Path $dll -ErrorAction Stop}

    Catch {
        Write-Host "`n`n`t`t`t`t`tECHEC ACCES " -NoNewline -ForegroundColor Red
        Write-Host "System.Data.SQLite.dll" -ForegroundColor Yellow
        Write-Host "`n`t`t`t`t`t`t`tARRET DU SCRIPT" -ForegroundColor Red
        Write-Host "`n`t`t`t`t`tPressez ENTREE pour quitter`n`n" -NoNewline -ForegroundColor Red
        $input = Read-Host
        break}}

Write-Host "`n`tRENSEIGNEZ L'" -NoNewline
Write-Host "IP" -ForegroundColor Yellow -NoNewline
Write-Host " DE VOTRE PS4:`t" -NoNewline
$ipPLAY = Read-Host

If((Test-Connection -ComputerName $ipPLAY -Count 1 -quiet) -match $false){
    Write-Host "`n`t`t`tERREUR: LA PS4 NE RÉPOND PAS AU PING" -ForegroundColor Red
    Write-Host "`n`t`t`t`t`tARRET DU SCRIPT" -ForegroundColor Red
    Write-Host "`n`t`t`tPressez ENTREE pour quitter`n`n"-ForegroundColor Red -NoNewline
    $input = Read-Host;BREAK}

Write-Host "`n`t`tIdentification du port FTP ..." -NoNewline
$ftps4 = Test-NetConnection -ComputerName $ipPLAY -Port "1337" -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

If($ftps4 -eq $True){$port = "1337"}

Else{

    $goldhen = Test-NetConnection -ComputerName $ipPLAY -Port "2121" -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

    If($goldhen -eq $True){$port = "2121"}

    Else{
        Write-Host "`n`n`n`t`t`tECHEC IDENTIFICATION PORT FTP" -ForegroundColor Red
        Write-Host "`n`t`t`t`tARRET DU SCRIPT" -ForegroundColor Red
        Write-Host "`n`t`t`tPressez ENTREE pour quitter`n`n"-ForegroundColor Red -NoNewline
        $input = Read-Host;BREAK}}

Write-Host " TERMINÉE" -ForegroundColor Green

If((Test-Path ".\app.db") -eq $true){Remove-Item ".\app.db"}

Try{
    Write-Host "`t`tTéléchargement 'app.db' ..." -NoNewline
    $pathBDD = "ftp://" + $ipPLAY + ":" + $port + "/System_data/priv/mms/app.db"
    $requestBDD = [Net.WebRequest]::Create($pathBDD)
    $requestBDD.Method = [System.Net.WebRequestMethods+Ftp]::GetFileSize
    $requestBDD.GetResponse() | Out-Null
    Invoke-WebRequest $pathBDD -OutFile ".\app.db" -PassThru | Out-Null
    Write-Host " TERMINÉ" -ForegroundColor Green}

Catch{
    Write-Host "`n`n`n`t`t`tECHEC TELECHARGEMENT BDD" -ForegroundColor Red
    Write-Host "`n`t`t`t`tARRET DU SCRIPT" -ForegroundColor Red
    Write-Host "`n`t`t`tPressez ENTREE pour quitter`n`n"-ForegroundColor Red -NoNewline
    $input = Read-Host;BREAK}

If((Test-Path ".\PS4RestoreFPKGdeletion") -eq $false){New-Item -Type Directory -Path ".\PS4RestoreFPKGdeletion" -Force | Out-Null}
$date = Get-Date -Format dd-MM-yyyy_HH\hmm
New-Item -Type Directory -Path ".\PS4RestoreFPKGdeletion" -Name $date -Force | Out-Null
New-Item -Type File -Path $(".\PS4RestoreFPKGdeletion\$date") -Name $("LOG_" + $date + ".txt") -Force | Out-Null
Write-Host "`t`tSauvegarde de la base de données ..." -NoNewline
Copy-Item -Path .\app.db -Destination ".\PS4RestoreFPKGdeletion\$date\app_$date.db"
Write-Host " TERMINÉE`n" -ForegroundColor Green

# NETFLIX "CUSA00127" | YOUTUBE "CUSA01116"
$exclusions = @(
"CUSA00001" # PLAYROOM
"CUSA00219" # Destiny
"CUSA00568" # Destiny
"CUSA01000" # Destiny
"NPXS20112" # GAME_DISC
)

$connexionDB = New-Object -TypeName System.Data.SQLite.SQLiteConnection
$connexionDB.ConnectionString = "Data Source=$($(Get-Location | Select -ExpandProperty Path) + "\app.db")"
$connexionDB.Open()

$commande = $connexionDB.CreateCommand()
$commande.CommandText = "SELECT name FROM sqlite_master WHERE type = 'table'"
$adapter = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $commande
$dataset = New-Object System.Data.DataSet
[void]$adapter.Fill($dataset)
$tables += $dataset.tables.rows
$commande.Dispose()

$tablesPROD = $tables.name | where {$_ -match "tbl_appbrowse_"}

ForEach ($tablePROD in $tablesPROD){

    Remove-Variable -Name needFIX -ErrorAction SilentlyContinue
    $compteur = 0

    If (($tablesPROD.Count -gt "1") -AND ($tablePROD -ne $tablesPROD[0])){

        Write-Host "`n___________________________________________________________________"
        Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force
        Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "----------------------------------------------------------" -Encoding UTF8 -Force
        Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force}

    Write-Host "`n`tTable " -NoNewline
    Write-Host $tablePROD -ForegroundColor Yellow -NoNewline
    Write-Host " :"
    Write-Host "`n`t`tIdentification des jeux à corriger ..." -NoNewline
    Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "TABLE: $tablePROD" -Encoding UTF8 -Force
    Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force
    $sqlAPP = $connexionDB.CreateCommand()
    $sqlAPP.CommandText = "SELECT titleName, titleId, uiCategory, canRemove FROM $tablePROD WHERE uiCategory = 'game' AND canRemove = '0'"

    $adapterAPP = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sqlAPP
    $dataAPP = New-Object System.Data.DataSet
    [void]$adapterAPP.Fill($dataAPP)
    $needFIX += $dataAPP.tables.rows
    $sqlAPP.Dispose()
    $needFIX = $needFIX | where {$exclusions -notcontains $_.titleId}
    Write-Host " TERMINÉE`n" -ForegroundColor Green

    If ($needFIX -ne $null){

        ForEach ($jeu in $needFIX){

            Try {
                Write-Host "Correction du jeu " -NoNewline
                Write-Host $jeu.titleName -ForegroundColor Yellow -NoNewline
                Write-Host " | " -NoNewline
                Write-Host $jeu.titleId -ForegroundColor Yellow -NoNewline
                Write-Host " ..." -NoNewline
                $update = $connexionDB.CreateCommand()
                $update.CommandText = "UPDATE $tablePROD SET canRemove = '1' WHERE titleId = '$($jeu.titleId)'"
                $update.ExecuteNonQuery() | Out-Null
                $update.Dispose()
                $compteur++
                Write-Host " TERMINÉE" -ForegroundColor Green
                Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "$($jeu.titleName) | $($jeu.titleId) corrigé" -Encoding UTF8 -Force
                $upload = "NECESSAIRE"}

            Catch {
                Write-Host " ECHEC" -ForegroundColor Red
                Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "Echec correction $($jeu.titleName) | $($jeu.titleId)" -Encoding UTF8 -Force}}

        Write-Host "`t$compteur" -ForegroundColor Cyan -NoNewline
        Write-Host " jeux corrigés"
        Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force
        Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "$compteur jeux corrigés" -Encoding UTF8 -Force}

    Else {
        Write-Host "`tAUCUN JEU A CORRIGER" -ForegroundColor Yellow
        Add-Content $(".\PS4RestoreFPKGdeletion\$date\LOG_$date.txt") "AUCUN JEU A CORRIGER" -Encoding UTF8 -Force}

}

$connexionDB.Close()

# UPLOAD
If ($upload -eq "NECESSAIRE"){

    Try {
        Write-Host "`n`t`tUpload 'app.db' ..." -NoNewline
        $ftp = "ftp://" + $ipPLAY + ":" + $port + "/System_data/priv/mms/"
        $local = Get-ChildItem .\app.db | Select -ExpandProperty FullName
        $distant = "${ftp}app.db"
        $uri = New-Object System.Uri($distant)
        $webclient = New-Object System.Net.WebClient
        $webclient.UploadFile($uri, $local)
        Write-Host " TERMINÉ" -ForegroundColor Green
        Write-Host "`n`t`t`t/_\ REBOOTEZ VOTRE PS4 /_\" -ForegroundColor Yellow}

    Catch {
        Write-Host "`n`n`t`t`t`tECHEC UPLOAD FTP" -ForegroundColor Red
        Write-Host "`n`t`t`t`tARRET DU SCRIPT" -ForegroundColor Red
        Write-Host "`n`t`t`tPressez ENTREE pour quitter`n`n"-ForegroundColor Red -NoNewline
        $input = Read-Host;BREAK}}

If((Test-Path ".\app.db") -eq $true){Remove-Item ".\app.db"}
Write-Host "`n`t`t`tPressez ENTREE pour quitter`n" -NoNewline -ForegroundColor Red
$input = Read-Host
