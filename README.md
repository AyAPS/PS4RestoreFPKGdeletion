# PS4RestoreFPKGdeletion
This tool restore XMB's option "Delete" on PS4 FPKGs when missing.<br />
It download <i>"app.db"</i> file on computer then overwrite the one in the PS4 if corrections were made.
## The PS4 must be rebooted to reload the DB with corrections !

<b>Tested on multiple systems:<br /></b>
- <b>FW:</b> 5.05 - 6.72 - 7.55 - 9.0
- <b>FTP:</b> FTPS4 - GoldHen
- <b>STORAGE:</b> Internal storage - App2USB - (no tester found for S0ny's offcial extended storage)

<b>FUNCTIONING:</b>
- :video_game: <b>PS4:</b> Launch your exploit, then the FTPS4 payload (useless for GoldHen but check the exploit is running)
- :computer: <b>PC:</b> Launch PS4RestoreFPKGdeletion, inquire your PS4's IP address then push ENTER

PROGRAM SEQUENCE:
- download the "app.db" file from PS4 to computer, in the same folder as PS4RestoreFPKGdeletion.exe
- do a backup of the DB before anything else, in a timestamped subfolder (one per execution)
- scan the DB to identify tables and games to fix, and fix them if necessary
- upload (overwrite) the "app.db" file in the ps4, only if corrections were made
- create a log file of the corrections done, stocked with the backuped DB

<details><summary>:wrench::interrobang: <b>POSSIBLE ERRORS:</b></summary>
 <br /><li>https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/1_DLL.PNG
 <br /><b>You must not modify program arborescence, nor move PS4RestoreFPKGdeletion.exe</b></li>
 <br /><li>https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/2_pattern_IP.PNG
 <br />What you entered isn't an IP address, type a <b>real</b> IP address</li>
 <br /><li>https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/3_PING.PNG
 <br />The IP address entered must'nt be the PS4's IP address, check your network and PS4 connectivity</li>
 <br /><li>https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/4_PORT_FTP.PNG
 <br />Check that your PS4's exploit is running (GoldHen) or your PS4FTP payload is loaded</li>
 <br /><li>https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/5_DOWNLOAD.PNG
 <br />This shouldn't happen, create an issue</li>
 <br /><li>https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/6_UPLOAD.PNG
 <br />This shouldn't happen, create an issue</li>
</details>

:film_projector: <b>DEMO (<i>v1.0</i>) : </b> https://www.youtube.com/watch?v=_LJO15vhjRw

<details><summary>Screenshots before/after</summary>
https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/1_BEFORE.PNG
<br />https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/1_AFTER.PNG
<br />https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/2_BEFORE.PNG
<br />https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/2_AFTER.PNG
</details>

<details><summary>:new: <b>CHANGELOG:</b></summary>
<br /><i>v1.1 :</i>
<br /><br />SQLite dependency integrated, no more need to install System.Data.SQLite as a prerequisite. <b>Those who installed it can uninstall it</b>.
<br /><br />Removal of the use of the Internet Explorer engine (deprecated) in favor of <code>-UseBasicParsing</code> (<i><code>Invoke-WebRequest</code></i>).
<br /><br />Added check that entered IP is <b>really</b> an IP address.
<br /><br />:uk: translation added, if your Windows OS language isn't :fr:, program's text will be in :uk:
<br /><br />Tested on FW 9.0
<br />------------------------------------------------------------------------------------------------------------------------------------------------
<br /><br /><i>v1.0 :</i> https://github.com/AyAPS/PS4RestoreFPKGdeletion/blob/main/README_PS4RestoreFPKGdeletion_v1.0.md
</details>

<sub>Source code (<b>Please refer to this Github if you use this code</b>):
<br />https://github.com/AyAPS/PS4RestoreFPKGdeletion/blob/main/PS4RestoreFPKGdeletion_v1.1.ps1</sub>

<b>Thanks to testers :thumbsup:</b>
