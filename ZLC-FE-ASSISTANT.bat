@ECHO OFF

TITLE ZLC-FE-ASSISTANT

:version_chk

SET USER_VER=1.3

SET GITHUB_VERSION_CHK_URL=https://github.com/KSanders7070/ZLC-FE-ASSISTANT/blob/main/Version_Check

SET BATCH_FILE_RELEASES_URL=https://github.com/KSanders7070/ZLC-FE-ASSISTANT/releases

ECHO.
ECHO.
ECHO * * * * * * * * * * * * *
ECHO  CHECKING FOR UPDATES...
ECHO * * * * * * * * * * * * *
ECHO.
ECHO.

CD "%temp%"
IF Not Exist TempBatWillDelete.bat goto MK_TEMP_FOLDER
	DEL /Q TempBatWillDelete.bat >NUL

:MK_TEMP_FOLDER

If Not Exist "%temp%\VersionCheckWillDelete\" MD "%temp%\VersionCheckWillDelete"

cd "%temp%\VersionCheckWillDelete"

powershell -Command "Invoke-WebRequest %GITHUB_VERSION_CHK_URL% -OutFile 'version_check.HTML'"

For /F "Tokens=3 Delims=><" %%G In ('%__AppDir__%findstr.exe ">VERSION-" "version_check.html"') Do For /F "Tokens=1* Delims=-" %%H In ("%%G") Do Set "GH_VER=%%I"

If "%USER_VER%" == "%GH_VER%" GOTO RMDIR

:UPDATE_AVAIL

CLS

cd "%temp%"
rd /s /q "%temp%\VersionCheckWillDelete\"

ECHO.
ECHO.
ECHO * * * * * * * * * * * * *
ECHO     UPDATE AVAILABLE
ECHO * * * * * * * * * * * * *
ECHO.
ECHO.
ECHO GITHUB VERSION: %GH_VER%
ECHO YOUR VERSION:   %USER_VER%
ECHO.
ECHO.
ECHO.
ECHO  CHOICES:
ECHO.
ECHO     A   -   AUTOMATICALLY UPDATE THE BATCH FILE YOU ARE USING NOW.
ECHO.
ECHO     M   -   MANUALLY DOWNLOAD THE NEWEST BATCH FILE UPDATE AND USE THAT FILE.
ECHO.
ECHO     C   -   CONTINUE USING THIS FILE.
ECHO.
ECHO.
ECHO.
ECHO NOTE: IF YOU HAVE ATTEMPTED TO AUTOMATICALLY UPDATE ALREADY AND YOU CONTINUE
ECHO       TO GET THIS UPDATE SCREEN, PLEASE UTILIZE THE MANUAL UPDATE OPTION.
ECHO.
ECHO.
ECHO.

:UPDATE_CHOICE

SET UPDATE_CHOICE=UPDATE_METHOD_NOT_SELECTED

	SET /p UPDATE_CHOICE=Please type either A, M, or C and press Enter: 
		if /I %UPDATE_CHOICE%==A GOTO AUTO_UPDATE
		if /I %UPDATE_CHOICE%==M GOTO MANUAL_UPDATE
		if /I %UPDATE_CHOICE%==C GOTO CONTINUE
		if /I %UPDATE_CHOICE%==UPDATE_METHOD_NOT_SELECTED GOTO UPDATE_CHOICE
			echo.
			echo.
			echo.
			echo.
			echo  %UPDATE_CHOICE% IS NOT A RECOGNIZED RESPONSE. Try again.
			echo.
			GOTO UPDATE_CHOICE

:AUTO_UPDATE

CLS

ECHO.
ECHO.
ECHO * * * * * * * * * * * * * * * * * * * * * * * * * * *
ECHO.
ECHO   PRESS ANY KEY TO START THE AUTOMATIC UPDATE.
ECHO.
ECHO.
ECHO   THIS SCREEN WILL CLOSE.
ECHO.
ECHO   WAIT 5 SECONDS
ECHO.
ECHO   THE NEW UPDATED BATCH FILE WILL START BY ITSELF.
ECHO.
ECHO * * * * * * * * * * * * * * * * * * * * * * * * * * *
ECHO.
ECHO.

PAUSE

CD "%temp%"

ECHO @ECHO OFF >> TempBatWillDelete.bat
ECHO TIMEOUT 5 >> TempBatWillDelete.bat
ECHO CD "%~dp0" >> TempBatWillDelete.bat
ECHO START %~nx0 >> TempBatWillDelete.bat
ECHO EXIT >> TempBatWillDelete.bat

START /MIN TempBatWillDelete.bat

CD "%~dp0"

powershell -Command "Invoke-WebRequest %BATCH_FILE_RELEASES_URL%/download/v%GH_VER%/%~nx0 -OutFile '%~nx0'"

EXIT /b

:MANUAL_UPDATE

CLS

START "" "%BATCH_FILE_RELEASES_URL%"

ECHO.
ECHO.
ECHO GO TO THE FOLLOWING WEBSITE, DOWNLOAD AND USE THE LATEST VERSION OF %~nx0
ECHO.
ECHO.
ECHO    %BATCH_FILE_RELEASES_URL%
ECHO.
ECHO.
ECHO.
ECHO.
ECHO NOTE: PRESSING ANY KEY NOW WILL QUIT THIS VERSION OF THE BATCH FILE.
ECHO.
ECHO.

PAUSE

EXIT /b

:RMDIR

CLS

cd "%temp%"
rd /s /q "%temp%\VersionCheckWillDelete\"

:CONTINUE

:HELLO

CLS

ECHO.
ECHO.
ECHO                      **********
ECHO                       ADVISORY
ECHO                      **********
ECHO.
ECHO Many of the functions within this BATCH file assume that 
ECHO the user has access to the ZLC FACILITY DROPBOX
ECHO directories and that Dropbox is installed on the
echo C: drive like so:
ECHO.
ECHO C:\Users\JohnSmith\Dropbox\ZLC 6. Internal Facility Files
ECHO.
ECHO.

PAUSE

:HELLO2

CLS

ECHO.
ECHO.
ECHO  WHAT DO YOU WANT TO DO?
ECHO.
ECHO.
ECHO      A) Split a current vERAM ZLC GeoMaps.xml or vSTARS Video Maps.xml into multiple individual files.
ECHO.
ECHO.
ECHO      B) Take the export data from the FE-BUDDY parser and transfer to corresponding EDIT files.
ECHO.
ECHO.
ECHO      C) Change the vERAM data Release Date and the .VERSION command.
ECHO.
ECHO.
ECHO      D) Combine split GeoMaps or Video Maps into a single ZLC GeoMaps.xml or ___ Video Maps.xml file.
echo            - Ensure only the files that you want to combine are in the directory you select.
ECHO.
ECHO.
ECHO      E) Combine and Transfer all EDIT SCT files to the Pre-Release ZLC SECTOR.sct2 file.
ECHO.
ECHO.
ECHO      F) Combine and Transfer all EDIT ALIAS files to the Pre-Release ZLC ALIAS.txt file.
ECHO              ---REMINDER: Launch vSTARS/vERAM, load new Alias/POF/GEOMAPs as needed and
ECHO                 export the .gz to Pre-Release folder.
ECHO.
ECHO.
ECHO      G) Transfer Pre-Release Files to ZLC Public Folder.
ECHO.
ECHO.

:GOAL_CHOICE

SET /P GOAL=Type A-F and press Enter: 
	if /i %GOAL%==A GOTO SPLITMAPS
	if /i %GOAL%==B GOTO FE-BUDDYEDIT
	if /i %GOAL%==C GOTO DATADATE
	if /i %GOAL%==D GOTO COMBINEMAPS
	if /i %GOAL%==E GOTO SCTEDIT_2_PRERELEASE
	if /i %GOAL%==F GOTO ALIASE2PR
	if /i %GOAL%==G GOTO AUTO_TRANSFER
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto GOAL_CHOICE

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:SPLITMAPS

CLS

ECHO.
ECHO.
ECHO  *** SPLIT MAPS ***
ECHO.
ECHO.
ECHO What type of map are you splitting?
ECHO.
ECHO  S) vSTARS
echo.
echo  E) vERAM
ECHO.
ECHO.

SET GOAL=-

:SPLIT_CHOICE

SET /P GOAL=Type S or E and press Enter: 
	if /i %GOAL%==S GOTO SPLITVIDEO
	if /i %GOAL%==E GOTO SPLITGEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto SPLIT_CHOICE

:SPLITVIDEO

CLS

ECHO.
ECHO.
ECHO  *** SPLIT VIDEO MAPS ***
ECHO.
ECHO.
ECHO ASSUMES:
ECHO.
ECHO  1) Video Map "LongName" descriptions do not have any symbols that can't be used in the name of a text file.
echo            Ex: \/:*?"<>|
echo.
echo  2) The .xml to be split MUST be named like so: "SLC Video Maps.xml" "BOI Video Maps.xml" "BZN Video Maps.xml" etc...
echo.
ECHO  3) If ran before, those old files will be overwritten if the description name of the map is the same as last time.
ECHO.
ECHO.

SET /P FAC_ID=Type the three character abbreviation of the facility video map you wish to split and press Enter: 
	SET FAC_ID=%FAC_ID: =%
	
CLS

ECHO.
ECHO.
ECHO  Is this the file you wish to split?
ECHO.
ECHO  "%FAC_ID% Video Maps.xml"
ECHO.
ECHO.

SET Y_N=-

SET /P Y_N=Type Y or N and Press Enter: 
	if /i %Y_N%==Y SET VM_FILE_NAME=%FAC_ID% Video Maps.xml
	if /i %Y_N%==Y GOTO VM_SRC_DIR_CHK
	if /i %Y_N%==N GOTO SPLITVIDEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %Y_N% *** is NOT a recognized response. Try again...
	echo.
	echo.
	pause
	goto SPLITVIDEO

:VM_SRC_DIR_CHK

CD /D "%userprofile%\AppData\Roaming\vSTARS\Video Maps"

IF EXIST "%VM_FILE_NAME%" SET SOURCE_DIR=%userprofile%\AppData\Roaming\vSTARS\Video Maps
IF EXIST "%VM_FILE_NAME%" goto VM_TAR_DIR

:VM_SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that the %VM_FILE_NAME% is in.
ECHO.
ECHO.

set SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The ZLC GeoMaps.xml',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:VM_TAR_DIR

CLS

ECHO.
ECHO.
ECHO Is this where you want all of the individual .xml files to be placed.
ECHO.
ECHO  %userprofile%\Dropbox\...
ECHO   ...ZLC 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO.

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
	if /i %USERSELECT%==Y GOTO STRT_VMSPLIT
	if /i %USERSELECT%==N GOTO CSE_VMTAR_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	PAUSE
	goto VM_TAR_DIR

:CSE_VMTAR_DIR

set TARGET_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the you want all of the individual .xml files to be placed.',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "TARGET_DIR=%%I"
	
	IF "%TARGET_DIR%"=="NOTHING" EXIT /B

:STRT_VMSPLIT

CLS

CD "%SOURCE_DIR%"

SET SOURCE_FILE=%VM_FILE_NAME%

TYPE "%SOURCE_FILE%">"%TARGET_DIR%\TEMP_SOURCE_FILE.txt"

CD "%TARGET_DIR%"

ECHO.
ECHO.
ECHO PROCESSED:
ECHO.
ECHO.
ECHO 100000_HEADER.xml

setlocal EnableDelayedExpansion

SET /A COUNT=100000

SET PHASE=HEADER

for /f "tokens=* delims=" %%a in (TEMP_SOURCE_FILE.txt) do (
	
	SET LINE=%%a
	
	IF NOT !PHASE!==FOOTER (
	
		SET PHASE_CHK=!LINE:~3,8!
			IF "!PHASE_CHK!"=="VideoMap" SET PHASE=VideoMapSTART
		
		SET PHASE_CHK=!LINE:~2,9!
			IF "!PHASE_CHK!"=="VideoMaps" SET PHASE=FOOTER
			
		IF "!PHASE!"=="VideoMapSTART" (
		
			SET VM_LINE_CHK=!LINE:~3,1!
				IF NOT "!VM_LINE_CHK!"=="V" SET PHASE=VM_LINE
		)
	)
	
	IF !PHASE!==HEADER (
		ECHO !LINE!>>"%TARGET_DIR%\100000_HEADER.xml"
	)
	
	IF !PHASE!==VideoMapSTART (
		
		SET /A COUNT=!COUNT! + 100
		
		SET LINE_CONVERT="!LINE!"
		
		for /f "tokens=3 delims==" %%a in (!LINE_CONVERT!) do set LONGNAME=%%a

			SET LONGNAME=!LONGNAME:~1,-12!
			
		ECHO !LINE!>>"!COUNT!_!LONGNAME!.xml"
		ECHO !COUNT!_!LONGNAME!
	)
	
	IF !PHASE!==VM_LINE (
		
		ECHO !LINE!>>"!COUNT!_!LONGNAME!.xml"
	)
	
	IF !PHASE!==FOOTER (
	
		ECHO !LINE!>>"9999999_FOOTER.xml"
	)
)

endlocal

DEL /Q TEMP_SOURCE_FILE.txt>NUL

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.

pause

GOTO HELLO2

:SPLITGEO

CLS

ECHO.
ECHO.
ECHO  *** SPLIT GEO MAPS ***
ECHO.
ECHO.
ECHO ASSUMES:
ECHO.
ECHO  1) GeoMap descriptions do not have any symbols that can't be used in the name of a text file.
echo            Ex: \/:*?"<>|
echo.
echo  2) There is only one BCG, FILTER, and GEOMAPSet and they are all labeled "ZLC".
echo.
echo  3) The .xml to be split MUST be named like so: "ZLC GeoMaps.xml".
echo.
ECHO  4) If ran before, those old files will be overwritten if the description name of the map is the same as last time.
ECHO.
ECHO.

pause

CLS

ECHO.
ECHO.
ECHO IS THE FOLLOWING DIRECTORY CORRECT FOR THE ZLC GeoMaps.xml THAT YOU WANT TO SPLIT?
ECHO.
ECHO  %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

SET USERSELECT=Nothing

:CHOICE_SPLITGEO

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%userprofile%\AppData\Local\vERAM\GeoMaps
	if /i %USERSELECT%==Y GOTO TAR_DIR
	if /i %USERSELECT%==N GOTO SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto CHOICE_SPLITGEO

:SRC_DIR

ECHO.
ECHO.
ECHO Select the directory that the ZLC GeoMaps.xml is in.
ECHO.
ECHO.

set SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select The Folder That Houses The ZLC GeoMaps.xml',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:TAR_DIR

CLS

ECHO.
ECHO.
ECHO Is this where you want all of the individual .xml files to be placed.
ECHO.
ECHO  %userprofile%\Dropbox\...
ECHO   ...ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
ECHO.
ECHO.

:TAR_DIR_CHOICE

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
	if /i %USERSELECT%==Y GOTO STRT_GEOSPLIT
	if /i %USERSELECT%==N GOTO CSE_TAR_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto TAR_DIR_CHOICE

:CSE_TAR_DIR

set TARGET_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the you want all of the individual .xml files to be placed.',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "TARGET_DIR=%%I"
	
	IF "%TARGET_DIR%"=="NOTHING" EXIT /B

:STRT_GEOSPLIT

CLS

CD "%SOURCE_DIR%"

SET SOURCE_FILE=ZLC GeoMaps.xml

TYPE "%SOURCE_FILE%">"%TARGET_DIR%\TEMP_SOURCE_FILE.txt"

CD "%TARGET_DIR%"

ECHO.
ECHO.
ECHO PROCESSED:
ECHO.
ECHO.
ECHO 100000_HEADER.xml


setlocal EnableDelayedExpansion

SET /A COUNT=100000

SET PHASE=HEADER

for /f "tokens=* delims=" %%a in (TEMP_SOURCE_FILE.txt) do (
	
	SET LINE=%%a
		
		SET LINE_CONVERT="!LINE!"
	
	IF NOT !PHASE!==FOOTER (
	
		SET PHASE_CHK=!LINE:~9,12!
			IF !PHASE_CHK!==GeoMapObject SET PHASE=GeoMapObject
		
		ECHO !LINE_CONVERT! | findstr /L /C:"Defaults Bcg" >nul
				if !errorlevel!==0 set PHASE=Defaults

		SET PHASE_CHK=!LINE:~11,8!
			IF !PHASE_CHK!==Elements SET PHASE=Elements

		SET PHASE_CHK=!LINE:~13,7!
			IF !PHASE_CHK!==Element SET PHASE=Element
		
		SET PHASE_CHK=!LINE:~12,8!
			IF !PHASE_CHK!==Elements SET PHASE=Elements_END
			
		SET PHASE_CHK=!LINE:~10,12!
			IF !PHASE_CHK!==GeoMapObject SET PHASE=GeoMapObject_END
		
		SET PHASE_CHK=!LINE:~8,7!
			IF !PHASE_CHK!==Objects SET PHASE=FOOTER
	)
		
	IF !PHASE!==HEADER (
		ECHO !LINE!>>"%TARGET_DIR%\100000_HEADER.xml"
	)
	
	IF !PHASE!==GeoMapObject (
		
		SET /A COUNT=!COUNT! + 100
		
		for /f "tokens=2 delims==" %%a in (!LINE_CONVERT!) do set DESCRIPTION=%%a

			SET DESCRIPTION=!DESCRIPTION:~1,-9!
			
		ECHO !LINE!>"!COUNT!_!DESCRIPTION!.xml"
	)
	
	IF NOT !PHASE!==HEADER IF NOT !PHASE!==GeoMapObject IF NOT !PHASE!==FOOTER (
		
		ECHO !LINE!>>"!COUNT!_!DESCRIPTION!.xml"
	)
	
	IF !PHASE!==GeoMapObject_END (
	
		ECHO !COUNT!_!DESCRIPTION!.xml
	)
	
	IF !PHASE!==FOOTER (
	
		ECHO !LINE!>>"9999999_FOOTER.xml"
	)
)

endlocal

DEL /Q TEMP_SOURCE_FILE.txt>NUL

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.

pause

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:DATADATE

CLS

ECHO.
ECHO.
ECHO  Type the DATE of the release with a max of 7 characters
ECHO.
ECHO       FORMAT: DDMMMYY or DDMMMv#
ECHO.
ECHO.
ECHO       # = the version of the release
ECHO           if multiple releases in a
ECHO           single day.
ECHO.
ECHO.
ECHO.
ECHO.

set DATADATE=DATADATE_Not_Set

SET /P DATADATE=Type the date here and press ENTER: 
	SET DATADATE=%DATADATE: =%
	
	if /i %DATADATE%==DATADATE_Not_Set goto DATADATE

ECHO.
ECHO.
ECHO STANDBY...

setlocal EnableDelayedExpansion

CD /D "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT ALIAS"

SET FILE_NAME_ENDING=_EVERYTHING ELSE.txt
for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET Alias_EverythingElse_file_name=%%G

for /f "usebackq tokens=* delims=" %%a in ("!Alias_EverythingElse_file_name!") do (

	SET LINE=%%a
	
	SET LINECHK=!LINE:~0,9!
		if "!LINECHK!"==".VERSION " (
		
			for /f "usebackq tokens=9 delims= " %%a in ('!LINE!') do (
				SET OLD_ALIAS_VERSION_DATE=%%a
				powershell -Command "(gc '!Alias_EverythingElse_file_name!') -replace '!OLD_ALIAS_VERSION_DATE!', '%DATADATE%' | Out-File -encoding ASCII '!Alias_EverythingElse_file_name!'"
			)
		)
)

CD /D "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS"

SET FILE_NAME_ENDING=_HEADER.xml
for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET vERAM_HEADER_file_name=%%G

for /f "usebackq tokens=* delims=" %%a in ("!vERAM_HEADER_file_name!") do (

	SET LINE=%%a
	
	SET LINECHK=!LINE:~5,6!
		if "!LINECHK!"=="GeoMap" (
			
			for /f "usebackq tokens=4 delims= " %%a in ('!LINE!') do (
				SET OLD_vERAM_VERSION_DATE=%%a
					SET OLD_vERAM_VERSION_DATE=!OLD_vERAM_VERSION_DATE:~12,-1!
				
				powershell -Command "(gc '!vERAM_HEADER_file_name!') -replace '!OLD_vERAM_VERSION_DATE!', '%DATADATE%' | Out-File -encoding ASCII '!vERAM_HEADER_file_name!'"
				)
		)
)

CLS

ECHO.
ECHO.
ECHO  Changed the following previous data-dates to %DATADATE%
ECHO.
ECHO       !Alias_EverythingElse_file_name! --- "!OLD_vERAM_VERSION_DATE!"
ECHO.
ECHO       !vERAM_HEADER_file_name! --- "!OLD_ALIAS_VERSION_DATE!"
ECHO.
ECHO.

endlocal

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:COMBINEMAPS

CLS

ECHO.
ECHO.
ECHO  *** COMBINE MAPS ***
ECHO.
ECHO.
ECHO What type of map are you combining?
ECHO.
ECHO  S) vSTARS
echo.
echo  E) vERAM
ECHO.
ECHO.

SET GOAL=-

:COMB_CHOICE

SET /P GOAL=Type S or E and press Enter: 
	if /i %GOAL%==S GOTO COMBINEVM
	if /i %GOAL%==E GOTO COMBINEGEO
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %GOAL% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto COMB_CHOICE

:COMBINEVM

CLS

CD /D "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vSTARS Video Maps"

ECHO.
ECHO.
SET /P FAC_ID=Type the three character abbreviation of the facility video maps you wish to combine and press Enter: 
	SET FAC_ID=%FAC_ID: =%

IF NOT EXIST %FAC_ID% (
ECHO.
ECHO.
ECHO **********  ERROR  **********
ECHO.
ECHO  DIRECTORY NOT FOUND:
ECHO.
ECHO  %userprofile%\Dropbox\...
ECHO   ...ZLC 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO  TRY AGAIN...
ECHO.
PAUSE
GOTO COMBINEVM
)

CLS

ECHO.
ECHO.
ECHO  *** COMBINE VIDEO MAPS ***
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Is this where all of the .xml files that you want to combine are located?
ECHO.
ECHO  %userprofile%\Dropbox\...
ECHO   ...ZLC 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
ECHO.
ECHO.

:VM-DIR_CHOICE

set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vSTARS Video Maps\%FAC_ID%
	if /i %USERSELECT%==Y GOTO STRT_COMBVM
	if /i %USERSELECT%==N GOTO VM-SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto VM-DIR_CHOICE

:VM-SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that hosts the individual .xml files.
ECHO.
ECHO.

SET SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the directory that hosts the individual .xml files',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:STRT_COMBVM

CLS

CD "%SOURCE_DIR%"

IF EXIST COMBINED RD /Q /S COMBINED
MD COMBINED

TYPE *.xml>"%SOURCE_DIR%\COMBINED\%FAC_ID% Video Maps.xml"

:COMBVM_DONE

CLS

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.
ECHO You may find %FAC_ID% Video Maps.xml HERE:
ECHO.
ECHO   %SOURCE_DIR%\COMBINED
ECHO.
ECHO.
ECHO.
ECHO.
ECHO ---------------------------------------------------------
ECHO.
ECHO Do you want to have the new combined file replace
ECHO the %FAC_ID% Video Maps.xml that should be located here?:
ECHO.
ECHO %AppData%\vSTARS\Video Maps
ECHO.
ECHO.

:VM_DONE_CH
	
set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y GOTO REPLACE_VM
	if /i %USERSELECT%==N GOTO HELLO2
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto VM_DONE_CH

:REPLACE_VM

COPY "%SOURCE_DIR%\COMBINED\%FAC_ID% Video Maps.xml" "%AppData%\vSTARS\Video Maps"

CLS

ECHO.
ECHO.
ECHO MOVED THE COMBINED %FAC_ID% Video Maps.xml to:
ECHO.
ECHO %AppData%\vSTARS\Video Maps
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:COMBINEGEO

CLS

ECHO.
ECHO.
ECHO  *** COMBINE GEO MAPS ***
ECHO.
ECHO.
ECHO.
ECHO.
ECHO Is this where all of the .xml files that you want to combine are located?
ECHO.
ECHO  %userprofile%\Dropbox\...
ECHO   ...ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
ECHO.
ECHO.

:SRC_DIR_CHOICE

set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y set SOURCE_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
	if /i %USERSELECT%==Y GOTO STRT_COMBGEO
	if /i %USERSELECT%==N GOTO CSE_SRC_DIR
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto SRC_DIR_CHOICE

:CSE_SRC_DIR

CLS

ECHO.
ECHO.
ECHO Select the directory that hosts the individual .xml files.
ECHO.
ECHO.

SET SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the directory that hosts the individual .xml files',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B

:STRT_COMBGEO

CLS

CD "%SOURCE_DIR%"

IF EXIST COMBINED RD /Q /S COMBINED
MD COMBINED

TYPE *.xml>"%SOURCE_DIR%\COMBINED\ZLC GeoMaps.xml"

:COMBGEO_DONE

CLS

ECHO.
ECHO.
ECHO DONE
ECHO.
ECHO.
ECHO You may find your ZLC GeoMaps.xml here:
ECHO.
ECHO   %SOURCE_DIR%\COMBINED
ECHO.
ECHO.
ECHO.
ECHO.
ECHO -------------------------------------------------
ECHO.
ECHO Do you want to have the new combined file replace
ECHO the ZLC GeoMaps.xml that should be located here?:
ECHO.
ECHO %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

:CBGEO_DONE_CH
	
set USERSELECT=Not_set

SET /P USERSELECT=Type Y or N and press Enter: 
	if /i %USERSELECT%==Y GOTO REPLACE_GEO
	if /i %USERSELECT%==N GOTO HELLO2
	ECHO.
	ECHO.
	ECHO.
	ECHO  *** %USERSELECT% *** is NOT a recognized response. Try again...
	echo.
	echo.
	goto CBGEO_DONE_CH

:REPLACE_GEO

COPY "%SOURCE_DIR%\COMBINED\ZLC GeoMaps.xml" "%userprofile%\AppData\Local\vERAM\GeoMaps"

CLS

ECHO.
ECHO.
ECHO MOVED THE COMBINED ZLC GeoMaps.xml to:
ECHO.
ECHO %userprofile%\AppData\Local\vERAM\GeoMaps
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:FE-BUDDYEDIT

ECHO.
ECHO.
ECHO  *** FE-BUDDY Output to EDIT FOLDERS ***
ECHO.
ECHO.
ECHO  This BATCH File will take the export data from the FE-BUDDY parser and
ECHO  transfer the following to the corresponding files:
ECHO.
ECHO.
ECHO         ALIAS:                                  EDIT ALIAS:
ECHO.
ECHO         ISR_APT.txt                   ---       *_AIRPORT ISR.txt
ECHO.
ECHO         ISR_NAVAID.txt                ---       *_NAVAID ISR.txt
ECHO.
ECHO         AWY_ALIAS.txt                 ---       *_AIRWAY FIXES ALIAS.txt
ECHO.
ECHO         STAR_DP_Fixes_Alias.txt       ---       *_STAR DP FIXES ALIAS.txt
ECHO.
ECHO         FAA_CHART_RECALL.txt          ---       *_FAA CHART RECALL.txt
ECHO.
ECHO         TELEPHONY.txt                 ---       *_TELEPHONY.txt
ECHO.
ECHO     -------------------------------------------------------------------------------
ECHO.
ECHO         VRC:                                    EDIT SCT:
ECHO.
ECHO         [AIRPORT].sct2                ---       05_AIRPORT\[AIRPORT].txt
ECHO.           
ECHO         [ARTCC HIGH].sct2             ---       09_ARTCC_HIGH\[ARTCC HIGH].txt
ECHO.           
ECHO         [ARTCC LOW].sct2              ---       10_ARTCC_LOW\[ARTCC LOW].txt
ECHO.           
ECHO         [HIGH AIRWAY].sct2            ---       14_HIGH_AIRWAY\[HIGH AIRWAY].txt
ECHO.           
ECHO         [LOW AIRWAY].sct2             ---       13_LOW_AIRWAY\[LOW AIRWAY].txt
ECHO.           
ECHO         [LABELS].sct2                 ---       17_LABELS\[LABELS].txt
ECHO.           
ECHO         [NDB].sct2                    ---       04_NDB\[NDB].txt
ECHO.           
ECHO         [VOR].sct2                    ---       03_VOR\[VOR].txt
ECHO.           
ECHO         [RUNWAY].sct2                 ---       06_RUNWAY\[RUNWAY].txt
ECHO.           
ECHO         [FIXES].sct2                  ---       07_FIXES\[FIXES].txt
ECHO.           
ECHO         000_All_DP_Combined.sct2      ---       11_SID\*_All_DP_Combined.sct2
ECHO.           
ECHO         000_All_STAR_Combined.sct2    ---       11_SID\*_All_STAR_Combined.sct2
ECHO.
ECHO     -------------------------------------------------------------------------------
ECHO.
ECHO         vERAM:                                  EDIT vERAM GeoMaps\SPLIT MAPS:
ECHO.           
ECHO         AIRPORTS_GEOMAP.xml           ---       *_APT.xml
ECHO.           
ECHO         NAVAID_GEOMAP.xml             ---       *_NAVAIDS.xml
ECHO.
ECHO         AWY_GEOMAP.xml                ---       *_AIRWAYS.xml
ECHO.
ECHO         ALL_DP_GEOMAP.xml             ---       *_ALL_DPs.xml
ECHO.
ECHO         ALL_STAR_GEOMAP.xml           ---       *_ALL_STARs.xml
ECHO.
ECHO         AIRPORT_TEXT_GEOMAP.xml       ---       *_AIRPORT_TEXT.xml
ECHO.
ECHO         NAVAID_TEXT_GEOMAP.xml        ---       *_NAVAID_TEXT.xml
ECHO.
ECHO     -------------------------------------------------------------------------------
ECHO.     
ECHO            It will then move the following two files to the
echo            Pre-Release\ZLC Facility Files WIP\
echo            vERAM and vSTARS folders.
ECHO.
ECHO            Airports.xml ^& Waypoints.xml
ECHO.
ECHO.
ECHO.
ECHO.

pause

:DIR_CHOICE

CLS

ECHO.
ECHO.
ECHO Select the FE-BUDDY_Output Folder
ECHO.
ECHO.

set SOURCE_DIR=NOTHING

set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'Select the FE-BUDDY_Output Folder',0,0).self.path""

	for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "SOURCE_DIR=%%I"
	
	IF "%SOURCE_DIR%"=="NOTHING" EXIT /B
		
		SET SOURCE_DIR_CHK=%SOURCE_DIR:~-15%
		
		IF NOT "%SOURCE_DIR_CHK%"=="FE-BUDDY_Output" (
			ECHO.
			ECHO.
			ECHO.
			ECHO The expected "Source" folder is "FE-BUDDY_Output"
			ECHO.
			ECHO You selected:
			echo    %SOURCE_DIR%
			echo.
			echo.
			echo  Try again...
			echo.
			echo.
			PAUSE
			goto DIR_CHOICE
		)

CLS

ECHO.
ECHO.
ECHO TRANSFERRED:
ECHO.
ECHO.

:ALIAS

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT ALIAS
SET FILE_NAME_ENDING=_AIRPORT ISR.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "ISR_APT.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - ISR_APT

SET FILE_NAME_ENDING=_NAVAID ISR.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "ISR_NAVAID.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - ISR_NAVAID

SET FILE_NAME_ENDING=_AIRWAY FIXES ALIAS.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "AWY_ALIAS.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - AWY Fixes

SET FILE_NAME_ENDING=_STAR DP FIXES ALIAS.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "STAR_DP_Fixes_Alias.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - STAR and DP Fixes
	
SET FILE_NAME_ENDING=_FAA CHART RECALL.txt

	CD "%TARGET_DIR%"
		for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G
		
	CD "%SOURCE_DIR%\ALIAS"
	IF EXIST "%SOURCE_DIR%\ALIAS\FAA_CHART_RECALL.txt" TYPE "FAA_CHART_RECALL.txt">"%TARGET_DIR%\%file_name%"
	IF EXIST "%SOURCE_DIR%\ALIAS\FAA_CHART_RECALL.txt" ECHO ALIAS - FAA CHART RECALL Commands

SET FILE_NAME_ENDING=_TELEPHONY.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\ALIAS"
	TYPE "TELEPHONY.txt">"%TARGET_DIR%\%file_name%"
	ECHO ALIAS - Telephony

:VRC_APT

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\05_AIRPORT

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[AIRPORT].sct2">"%TARGET_DIR%\[AIRPORT].txt"
	ECHO VRC - AIRPORTS

:VRC_ARTCC_HI

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\09_ARTCC_HIGH

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[ARTCC HIGH].sct2">"%TARGET_DIR%\[ARTCC HIGH].txt"
	ECHO VRC - ARTCC HIGH

:VRC_ARTCC_LO

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\10_ARTCC_LOW

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[ARTCC LOW].sct2">"%TARGET_DIR%\[ARTCC LOW].txt"
	ECHO VRC - ARTCC LOW

:VRC_AWY_HI

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\14_HIGH_AIRWAY

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[HIGH AIRWAY].sct2">"%TARGET_DIR%\[HIGH AIRWAY].txt"
	ECHO VRC - HIGH AIRWAYS

:VRC_AWY_LO

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\13_LOW_AIRWAY

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[LOW AIRWAY].sct2">"%TARGET_DIR%\[LOW AIRWAY].txt"
	ECHO VRC - LOW AIRWAYS

:VRC_LABELS

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\17_LABELS

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[LABELS].sct2">"%TARGET_DIR%\[LABELS].txt"
	ECHO VRC - LABELS

:VRC_NDB

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\04_NDB

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[NDB].sct2">"%TARGET_DIR%\[NDB].txt"
	ECHO VRC - NDB

:VRC_VOR

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\03_VOR

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[VOR].sct2">"%TARGET_DIR%\[VOR].txt"
	ECHO VRC - VOR

:VRC_RWY

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\06_RUNWAY

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[RUNWAY].sct2">"%TARGET_DIR%\[RUNWAY].txt"
	ECHO VRC - RUNWAY

:VRC_FIX

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\07_FIXES

CD "%TARGET_DIR%"
	DEL /Q *.txt>nul

CD "%SOURCE_DIR%\VRC"
	TYPE "[FIXES].sct2">"%TARGET_DIR%\[FIXES].txt"
	ECHO VRC - FIXES

:VRC_SID

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\11_SID
SET FILE_NAME_ENDING=_All_DP_Combined.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VRC\[SID]"
	findstr /L /V "[SID]" 000_All_DP_Combined.sct2>>000_All_DP_Combined_temp.sct2
	TYPE "000_All_DP_Combined_temp.sct2">"%TARGET_DIR%\%file_name%"
	DEL /Q 000_All_DP_Combined_temp.sct2>NUL
	ECHO VRC - ALL DPs COMBINED

:VRC_STAR

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT\11_SID
SET FILE_NAME_ENDING=_All_STAR_Combined.txt

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VRC\[STAR]"
	findstr /L /V "[STAR]" 000_All_STAR_Combined.sct2>>000_All_STAR_Combined_temp.sct2
	TYPE "000_All_STAR_Combined_temp.sct2">"%TARGET_DIR%\%file_name%"
	DEL /Q 000_All_STAR_Combined_temp.sct2>NUL
	ECHO VRC - ALL STARs COMBINED

:vERAM_APT_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_APT.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "AIRPORTS_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - APT GEOMAP

:vERAM_NAV_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_NAVAIDS.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "NAVAID_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - NAV GEOMAP

:vERAM_WX_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_WX STATIONS

CD "%TARGET_DIR%"

	IF EXIST changed.txt del /q changed.txt>NUL
	IF EXIST Temp_file.txt del /q Temp_file.txt>NUL

	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"

	TYPE "WX_STATIONS_GEOMAP.xml">"%TARGET_DIR%\Temp_file.txt"

CD "%TARGET_DIR%"

powershell -Command "(gc "Temp_file.txt") -replace '"false"', '"true"' | Out-File -encoding ASCII changed.txt"

TYPE "changed.txt">"%file_name%"

del /q changed.txt Temp_file.txt>NUL

ECHO vERAM - WX STATIONS GEOMAP    ***Changed TDM from False to True***

:vERAM_AWY_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_AIRWAYS.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "AWY_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - AWY GEOMAP

:vERAM_DP_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_ALL_DPs.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "ALL_DP_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - ALL DPs GEOMAP

:vERAM_STAR_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_ALL_STARs.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "ALL_STAR_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - ALL STARs GEOMAP

:vERAM_APT_TXT_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_AIRPORT_TEXT.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "AIRPORT_TEXT_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - APT TXT GEOMAP

:vERAM_NAV_TXT_GEOMAP

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT vERAM GeoMaps\SPLIT MAPS
SET FILE_NAME_ENDING=_NAVAID_TEXT.xml

CD "%TARGET_DIR%"
	for /f "delims=" %%G in ('dir /b ^| findstr /L /C:"%FILE_NAME_ENDING%"') do SET file_name=%%G

CD "%SOURCE_DIR%\VERAM"
	TYPE "NAVAID_TEXT_GEOMAP.xml">"%TARGET_DIR%\%file_name%"
	ECHO vERAM - NAV TXT GEOMAP

:ERAM_NAVDATA

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\vERAM

CD "%SOURCE_DIR%\VERAM"
	TYPE "Airports.xml">"%TARGET_DIR%\Airports.xml"
	TYPE "Waypoints.xml">"%TARGET_DIR%\Waypoints.xml"
	ECHO vERAM - NAVDATA

:STARS_NAVDATA

SET TARGET_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\vSTARS

CD "%SOURCE_DIR%\VSTARS"
	TYPE "Airports.xml">"%TARGET_DIR%\Airports.xml"
	TYPE "Waypoints.xml">"%TARGET_DIR%\Waypoints.xml"
	ECHO vSTARS - NAVDATA

:DONE_FE-BUDDYEDIT

ECHO.
ECHO.
ECHO *** DONE ***
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:SCTEDIT_2_PRERELEASE

ECHO.
ECHO.
ECHO  *** EDIT SCT Files to ZLC Pre-Release Folder ***
ECHO.
ECHO.
ECHO -----------------------------------------------
ECHO  PRESS ANY KEY TO REPLACE THE CONTENTS OF THE
ECHO  ZLC PRE-RELEASE SECTOR FILE WITH THE CONTENTS
ECHO  OF EVERYTHING IN THE "EDIT SCT" FOLDER.
ECHO -----------------------------------------------
ECHO.
ECHO.
ECHO.
ECHO.
ECHO * * * PREREQUISITES: * * * 
ECHO.
ECHO.
ECHO   1) All files must be .txt
ECHO.
ECHO   2) All files must have at least two empty lines
ECHO      at the bottom of the contents.
ECHO.
ECHO   3) All files must be named alphanumerically to
ECHO      determine the order in which it writes to
ECHO      the SCT file.
ECHO.
ECHO.

PAUSE

SET PR_SCT_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\SECTOR FILES

SET EDIT_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT SCT


:CLEAR_PRE-RELEASE_SCT2

CD "%PR_SCT_DIR%"

break>"ZLC SECTOR.SCT2"

CLS

PING 127.0.0.1 -n 2 >nul

ECHO.
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO  EXPORTING ALL FILES TO: ZLC SECTOR.SCT2
ECHO.
ECHO  ZLC 6. Internal Facility Files
ECHO     -Pre-Release
ECHO         -ZLC Facility Files WIP
ECHO             -SECTOR FILES
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO.

ECHO --- COMPLETED: ---
ECHO.

CD "%EDIT_DIR%\01_COLORS"
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\02_INFO
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\03_VOR
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\04_NDB
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\05_AIRPORT
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\06_RUNWAY
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\07_FIXES
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\08_ARTCC
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\09_ARTCC_HIGH
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\10_ARTCC_LOW
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\11_SID
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\12_STAR
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\13_LOW_AIRWAY
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\14_HIGH_AIRWAY
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\15_GEO
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\16_REGIONS
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

CD "%EDIT_DIR%\17_LABELS
type "*.txt" >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"
echo.  >> "%PR_SCT_DIR%\ZLC SECTOR.SCT2"

ECHO.
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO  ALL FILES COMBINED INTO THE PRE-RELEASE: ZLC SECTOR.SCT2
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:ALIASE2PR

CLS

ECHO -----------------------------------------------
ECHO  PRESS ANY KEY TO REPLACE THE CONTENTS OF THE
ECHO  ZLC PRE-RELEASE ALIAS FILE WITH THE CONTENTS
ECHO  OF EVERYTHING IN THE "EDIT ALIAS" FOLDER.
ECHO -----------------------------------------------
ECHO.
ECHO.
ECHO.
ECHO.
ECHO * * * PREREQUISITES: * * * 
ECHO.
ECHO.
ECHO   1) All files must be .txt
ECHO.
ECHO   2) All files must have at least one empty line
ECHO      at the bottom of the contents.
ECHO.
ECHO   3) All files must be named alphanumerically to
ECHO      determine the order in which it writes to
ECHO      the Alias file.
ECHO.
ECHO.

PAUSE

SET PR_ALIAS_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\ALIAS FILES

SET EDIT_DIR=%userprofile%\Dropbox\ZLC 6. Internal Facility Files\EDIT ALIAS

CD "%PR_ALIAS_DIR%"

break>"ZLC ALIAS.txt"

CLS

ECHO.
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO  EXPORTING ALL FILES TO: ZLC ALIAS.txt
ECHO.
ECHO  ZLC 6. Internal Facility Files
ECHO     -Pre-Release
ECHO         -ZLC Facility Files WIP
ECHO             -ALIAS FILES
ECHO.
ECHO ----------------------------------------------
ECHO.
ECHO.

ECHO --- COMPLETED: ---
ECHO.

CD "%EDIT_DIR%"

type "*.txt">>"%PR_ALIAS_DIR%\ZLC ALIAS.txt"
echo.>>"%PR_ALIAS_DIR%\ZLC ALIAS.txt"
echo.>>"%PR_ALIAS_DIR%\ZLC ALIAS.txt"

ECHO.
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO  ALL FILES COMBINED INTO THE PRE-RELEASE: ZLC ALIAS.txt
ECHO.
ECHO --------------------------------------------------------------
ECHO.
ECHO.

PAUSE

GOTO HELLO2

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:AUTO_TRANSFER

ECHO.
ECHO.
ECHO  *** AUTO-TRANSFER Pre-Release Files to ZLC Public Folder ***
echo.
echo.
echo    You Are About To Move The Following Contents From The Pre-Release Folder
echo    To The Appropriate ZLC Public Folder.
echo.
echo.
echo    If You Do Not Wish To Do This, Please Close This Window Now.
echo.
echo.
echo    Select The Appropriate Contents To Move:
echo.
echo        ALL)   All Files
echo.
echo        APS)   Alias / POF / Sector Files
echo.
echo         AS)   Alias / Sector Files
echo.
echo         SE)   vSTARS / vERAM NAVDATA
echo.
echo          O)   ZLC "Other Downloads" Folder
echo          A)   Alias File(s)
echo          P)   POF Files(s)
echo          S)   Sector Files(s)
echo          T)   vATIS Files
echo.
echo.

:CHOICE_AUTO_TRANSFER

	set /p MOVE=Type Your Choice and press Enter: 
	IF /I %MOVE%==ALL GOTO OTHER
	IF /I %MOVE%==APS GOTO ALIAS
	IF /I %MOVE%==AS GOTO ALIAS
	IF /I %MOVE%==SE GOTO vSTARS_vERAM
	IF /I %MOVE%==O GOTO OTHER
	IF /I %MOVE%==A GOTO ALIAS
	IF /I %MOVE%==P GOTO POF
	IF /I %MOVE%==S GOTO SECTOR
	IF /I %MOVE%==T GOTO vATIS
	echo.
	echo.
	echo  I Cannot Do Anything With An Entry Of "%MOVE%". Try Another Option Or Seek Guidance.
	echo.
	echo.
	
	PAUSE
	CLS
	GOTO CHOICE_AUTO_TRANSFER

:OTHER

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "OTHER DOWNLOADS" TO ZLC PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\Other Downloads WIP"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\Other Downloads WIP\*.*" "%userprofile%\Dropbox\zlc public\Other Downloads"

	IF /I %MOVE%==O GOTO DONE_AUTO_TRANSFER

:ALIAS

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "ALIAS FILES" TO ZLC PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\ALIAS FILES"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\ALIAS FILES\*.*" "%userprofile%\Dropbox\zlc public\ZLC Facility Files (Live Update)\ALIAS FILES"

	IF /I %MOVE%==A GOTO DONE_AUTO_TRANSFER
	IF /I %MOVE%==AS GOTO SECTOR

:vSTARS_vERAM

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "ALIAS FILES" TO ZLC PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\vSTARS"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\vSTARS\*.*" "%userprofile%\Dropbox\zlc public\ZLC Facility Files (Live Update)\vSTARS"

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\vERAM"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\vERAM\*.*" "%userprofile%\Dropbox\zlc public\ZLC Facility Files (Live Update)\vERAM"

	IF /I %MOVE%==SE GOTO DONE_AUTO_TRANSFER

:POF

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "POF FILE" TO ZLC PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\POF FILE"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\POF FILE\*.*" "%userprofile%\Dropbox\zlc public\ZLC Facility Files (Live Update)\POF FILE"

	IF /I %MOVE%==P GOTO DONE_AUTO_TRANSFER

:SECTOR

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "SECTOR FILES" TO ZLC PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\SECTOR FILES"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC Facility Files WIP\SECTOR FILES\*.*" "%userprofile%\Dropbox\zlc public\ZLC Facility Files (Live Update)\SECTOR FILES"

	IF /I %MOVE%==S GOTO DONE_AUTO_TRANSFER
	IF /I %MOVE%==APS GOTO DONE_AUTO_TRANSFER
	IF /I %MOVE%==AS GOTO DONE_AUTO_TRANSFER

:vATIS

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo MOVING CONTENTS OF "ZLC vATIS" TO ZLC PUBLIC FOLDER
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

CD "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC vATIS WIP"
copy "%userprofile%\Dropbox\ZLC 6. Internal Facility Files\Pre-Release\ZLC vATIS WIP\*.*" "%userprofile%\Dropbox\zlc public\ZLC vATIS"

:DONE_AUTO_TRANSFER

CLS

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ALL FILES MOVED AND ARE NOW PUBLISHED TO THE LIVE UPDATE SYSTEM
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.

PAUSE

GOTO HELLO2