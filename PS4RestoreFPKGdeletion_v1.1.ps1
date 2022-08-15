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

$patternIP = "^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$"
If (((Get-Culture).LCID) -eq "1036"){$langue = "FR"}
Else {$langue = "US"}

Try {Add-Type -Path ".\Sources\DLL\System.Data.SQLite.dll" -ErrorAction Stop}

Catch {

    Switch ($langue){

        FR {Write-Host "`n`n`t`t`t`t`t`tERREUR: " -ForegroundColor Red -NoNewline
            Write-Host "System.Data.SQLite.dll" -ForegroundColor Yellow -NoNewline
            Write-Host " introuvable" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`t`tPressez ENTREE pour quitter`n" -NoNewline -ForegroundColor Red}

        US {Write-Host "`n`n`t`t`t`t`t`tERROR: " -ForegroundColor Red -NoNewline
            Write-Host "System.Data.SQLite.dll" -ForegroundColor Yellow -NoNewline
            Write-Host " not found" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`t`tPress ENTER to quit`n" -NoNewline -ForegroundColor Red}}

    $input = Read-Host
    break}

Switch ($langue){

    FR {Write-Host "`n`t`tRENSEIGNEZ L'" -NoNewline
        Write-Host "IP" -ForegroundColor Yellow -NoNewline
        Write-Host " DE VOTRE PS4:`t" -NoNewline
        $ipPLAY = Read-Host}

    US {Write-Host "`n`t`tINQUIRE THE " -NoNewline
        Write-Host "IP" -ForegroundColor Yellow -NoNewline
        Write-Host " OF YOUR PS4:`t`t" -NoNewline
        $ipPLAY = Read-Host}}

If (($ipPLAY -match $patternIP) -eq $false){

    Switch ($langue){

        FR {Write-Host "`n`n`t`t`t`t`t`tERREUR: " -ForegroundColor Red -NoNewline
            Write-Host $ipPLAY -ForegroundColor Yellow -NoNewline
            Write-Host " n'est pas une IP valide" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`t`tPressez ENTREE pour quitter`n" -NoNewline -ForegroundColor Red}

        US {Write-Host "`n`n`t`t`t`t`t`tERROR: " -ForegroundColor Red -NoNewline
            Write-Host $ipPLAY -ForegroundColor Yellow -NoNewline
            Write-Host " isn't a valid IP" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`t`tPress ENTER to quit`n" -NoNewline -ForegroundColor Red}}

    $input = Read-Host
    break}

If ((Test-Connection -ComputerName $ipPLAY -Count 1 -quiet) -eq $false){

    Switch ($langue){

        FR {Write-Host "`n`t`t`t`t`t`tERREUR: LA PS4 NE RÉPOND PAS AU PING" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`tPressez ENTREE pour quitter`n`n"-ForegroundColor Red -NoNewline}

        US {Write-Host "`n`t`t`t`t`t`tERROR: THE PS4 DOESN'T ANSWER TO PING" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`t`tPress ENTER to quit`n" -NoNewline -ForegroundColor Red}}

    $input = Read-Host
    BREAK}

Switch ($langue){

    FR {Write-Host "`n`t`t`tIdentification du port FTP ..." -NoNewline}
    US {Write-Host "`n`t`t`tFTP port identification ..." -NoNewline}}

$ftps4 = Test-NetConnection -ComputerName $ipPLAY -Port "1337" -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

If($ftps4 -eq $True){$port = "1337"}

Else{

    $goldhen = Test-NetConnection -ComputerName $ipPLAY -Port "2121" -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

    If($goldhen -eq $True){$port = "2121"}

    Else{

        Switch ($langue){

            FR {Write-Host "`n`t`t`t`t`t`tERREUR: ECHEC IDENTIFICATION PORT FTP" -ForegroundColor Red
                Write-Host "`n`t`t`t`t`t`t`tPressez ENTREE pour quitter`n`n" -ForegroundColor Red -NoNewline}

            US {Write-Host "`n`t`t`t`t`t`tERROR: FTP PORT IDENTIFICATION FAILED" -ForegroundColor Red
                Write-Host "`n`t`t`t`t`t`t`t`tPress ENTER to quit`n`n" -ForegroundColor Red -NoNewline}}

    $input = Read-Host
    BREAK}}

    Switch ($langue){

        FR {Write-Host " TERMINÉE" -ForegroundColor Green}
        US {Write-Host " DONE" -ForegroundColor Green}}


If((Test-Path ".\app.db") -eq $true){Remove-Item ".\app.db"}

Try{

    Switch ($langue){

        FR {Write-Host "`t`t`tTéléchargement 'app.db' ..." -NoNewline}
        US {Write-Host "`t`t`tDownloading 'app.db' ..." -NoNewline}}

    $pathBDD = "ftp://" + $ipPLAY + ":" + $port + "/System_data/priv/mms/app.db"
    $requestBDD = [Net.WebRequest]::Create($pathBDD)
    $requestBDD.Method = [System.Net.WebRequestMethods+Ftp]::GetFileSize
    $requestBDD.GetResponse() | Out-Null
    Invoke-WebRequest $pathBDD -UseBasicParsing -OutFile ".\app.db" -PassThru -ErrorAction Stop | Out-Null

    Switch ($langue){

        FR {Write-Host " TERMINÉ" -ForegroundColor Green}
        US {Write-Host " DONE" -ForegroundColor Green}}}

Catch{

    Switch ($langue){

        FR {Write-Host ""
            Write-Host "`n`t`t`t`t`t`tERREUR: ECHEC TELECHARGEMENT BDD" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`tPressez ENTREE pour quitter`n`n"-ForegroundColor Red -NoNewline}

        US {Write-Host ""
            Write-Host "`n`t`t`t`t`t`tERROR: BDD DOWNLOAD FAILED" -ForegroundColor Red
            Write-Host "`n`t`t`t`t`t`t`tPress ENTER to quit`n`n" -ForegroundColor Red -NoNewline}}

    $input = Read-Host
    BREAK}

Switch ($langue){

    FR {Write-Host "`t`t`tSauvegarde de la base de données ..." -NoNewline}
    US {Write-Host "`t`t`tBackup of database ..." -NoNewline}}

$date = Get-Date -Format dd-MM-yyyy_HH\hmm
New-Item -Type Directory -Path ".\Backups" -Name $date -Force | Out-Null
New-Item -Type File -Path $(".\Backups\$date") -Name $("LOG_" + $date + ".txt") -Force | Out-Null
Copy-Item -Path .\app.db -Destination $(".\Backups\$date\app_$date.db")

Switch ($langue){

    FR {Write-Host " TERMINÉE" -ForegroundColor Green}
    US {Write-Host " DONE" -ForegroundColor Green}}

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
        Add-Content $(".\Backups\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force
        Add-Content $(".\Backups\$date\LOG_$date.txt") "----------------------------------------------------------" -Encoding UTF8 -Force
        Add-Content $(".\Backups\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force}

    Write-Host "`n`t`tTable " -NoNewline
    Write-Host $tablePROD -ForegroundColor Yellow -NoNewline
    Write-Host " :"

    Switch ($langue){

        FR {Write-Host "`n`t`t`tIdentification des jeux à corriger ..." -NoNewline}
        US {Write-Host "`n`t`t`tIdentifying games to fix ..." -NoNewline}}

    Add-Content $(".\Backups\$date\LOG_$date.txt") "TABLE: $tablePROD" -Encoding UTF8 -Force
    Add-Content $(".\Backups\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force
    $sqlAPP = $connexionDB.CreateCommand()
    $sqlAPP.CommandText = "SELECT titleName, titleId, uiCategory, canRemove FROM $tablePROD WHERE uiCategory = 'game' AND canRemove = '0'"

    $adapterAPP = New-Object -TypeName System.Data.SQLite.SQLiteDataAdapter $sqlAPP
    $dataAPP = New-Object System.Data.DataSet
    [void]$adapterAPP.Fill($dataAPP)
    $needFIX += $dataAPP.tables.rows
    $sqlAPP.Dispose()
    $needFIX = $needFIX | where {$exclusions -notcontains $_.titleId}

    Switch ($langue){

        FR {Write-Host " TERMINÉE" -ForegroundColor Green}
        US {Write-Host " DONE" -ForegroundColor Green}}

    If ($needFIX -ne $null){

        ForEach ($jeu in $needFIX){

            Try {

                Switch ($langue){

                    FR {Write-Host "`nCorrection du jeu " -NoNewline}
                    US {Write-Host "`nFixing game " -NoNewline}}

                Write-Host $jeu.titleName -ForegroundColor Yellow -NoNewline
                Write-Host " | " -NoNewline
                Write-Host $jeu.titleId -ForegroundColor Yellow -NoNewline
                Write-Host " ..." -NoNewline
                $update = $connexionDB.CreateCommand()
                $update.CommandText = "UPDATE $tablePROD SET canRemove = '1' WHERE titleId = '$($jeu.titleId)'"
                $update.ExecuteNonQuery() | Out-Null
                $update.Dispose()
                $compteur++

                Switch ($langue){

                    FR {Write-Host " TERMINÉE" -ForegroundColor Green}
                    US {Write-Host " DONE" -ForegroundColor Green}}

                Add-Content $(".\Backups\$date\LOG_$date.txt") "$($jeu.titleName) | $($jeu.titleId) corrigé" -Encoding UTF8 -Force
                $upload = "NECESSAIRE"}

            Catch {

                Switch ($langue){

                FR {Write-Host ""
                    Write-Host " ECHEC" -ForegroundColor Red}

                US {Write-Host ""
                    Write-Host " FAILED" -ForegroundColor Red}}

                Add-Content $(".\Backups\$date\LOG_$date.txt") "Echec correction $($jeu.titleName) | $($jeu.titleId)" -Encoding UTF8 -Force}}

        Write-Host "`n`t`t$compteur" -ForegroundColor Cyan -NoNewline

        Switch ($langue){

            FR {Write-Host " jeux corrigés"}
            US {Write-Host " games fixed"}}

        Add-Content $(".\Backups\$date\LOG_$date.txt") "`n" -Encoding UTF8 -Force
        Add-Content $(".\Backups\$date\LOG_$date.txt") "$compteur jeux corrigés" -Encoding UTF8 -Force}

    Else {

        Switch ($langue){

            FR {Write-Host "`n`t`t`t`tAUCUN JEU A CORRIGER" -ForegroundColor Yellow}
            US {Write-Host "`n`t`t`t`tNO GAME TO FIX" -ForegroundColor Yellow}}

        Add-Content $(".\Backups\$date\LOG_$date.txt") "AUCUN JEU A CORRIGER" -Encoding UTF8 -Force}}

$connexionDB.Close()

If ($upload -eq "NECESSAIRE"){

    Try {
        Write-Host "`n`t`tUpload 'app.db' ..." -NoNewline
        $ftp = "ftp://" + $ipPLAY + ":" + $port + "/System_data/priv/mms/"
        $local = Get-ChildItem .\app.db | Select -ExpandProperty FullName
        $distant = "${ftp}app.db"
        $uri = New-Object System.Uri($distant)
        $webclient = New-Object System.Net.WebClient
        $webclient.UploadFile($uri, $local)

        Switch ($langue){

            FR {Write-Host " TERMINÉ" -ForegroundColor Green
                Write-Host "`n`t`t`t/_\ REBOOTEZ VOTRE PS4 /_\" -ForegroundColor Yellow}

            US {Write-Host " DONE" -ForegroundColor Green
                Write-Host "`n`t`t`t/_\ REBOOT YOUR PS4 /_\" -ForegroundColor Yellow}}}

    Catch {

        Switch ($langue){

            FR {Write-Host ""
                Write-Host "`n`n`t`t`t`t`t`tERREUR: ECHEC UPLOAD FTP" -ForegroundColor Red
                Write-Host "`n`t`t`t`t`t`tPressez ENTREE pour quitter`n" -NoNewline -ForegroundColor Red}

            US {Write-Host ""
                Write-Host "`n`n`t`t`t`t`t`tERROR: FTP UPLOAD FAILED" -ForegroundColor Red
                Write-Host "`n`t`t`t`t`t`t`tPress ENTER to quit`n" -NoNewline -ForegroundColor Red}}

        $input = Read-Host
        BREAK}}

If((Test-Path ".\app.db") -eq $true){Remove-Item ".\app.db"}

    Switch ($langue){

    FR {Write-Host "`n`t`t`tPressez ENTREE pour quitter`n" -NoNewline -ForegroundColor Red}
    US {Write-Host "`n`t`t`tPress ENTER to quit`n" -NoNewline -ForegroundColor Red}}

$input = Read-Host
