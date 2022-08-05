# PS4RestoreFPKGdeletion
This tool restore XMB's option "Delete" on PS4 FPKGs when missing.<br />
It download <i>"app.db"</i> file on computer then overwrite the one in the PS4 if corrections were made.
## The PS4 must be rebooted to reload the DB with corrections !

<b>Tested on multiple systems:<br /></b>
- <b>FW:</b> 5.05 - 6.72 - 7.55
- <b>FTP:</b> FTPS4 - GoldHen
- <b>STORAGE:</b> Internal storage - App2USB - (no tester found for S0ny's offcial extended storage)

PREREQUISITES:
- Download and install SQLite library (<b>don't change original location</b>): https://system.data.sqlite.org/downloads/1.0.113.0/sqlite-netFx46-setup-bundle-x64-2015-1.0.113.0.exe

FUNCTIONING:
- <b>PS4:</b> Launch your exploit, then the FTPS4 payload (useless for GoldHen but check the exploit is running)
- <b>PC:</b> Launch PS4RestoreFPKGdeletion, inquire your PS4's IP address then push ENTER

PROGRAM SEQUENCE:
- download the "app.db" file from PS4 to computer, in the same folder as PS4RestoreFPKGdeletion.exe
- do a backup of the DB before anything else, in a timestamped subfolder (one per execution)
- scan the DB to identify tables and games to fix, and fix them if necessary
- upload (overwrite) the "app.db" file in the ps4, only if corrections were made
- create a log file of the corrections done, stocked with the backuped DB

DEMO: https://www.youtube.com/watch?v=_LJO15vhjRw

<details><summary>Screenshots before/after</summary>
https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/1_BEFORE.PNG
<br />https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/1_AFTER.PNG
<br />https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/2_BEFORE.PNG
<br />https://raw.githubusercontent.com/AyAPS/PS4RestoreFPKGdeletion/main/2_AFTER.PNG
</details>

