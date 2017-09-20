@Echo off
REM All these folders must exist, if not create them first (no trailing backslash)
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Set mkgmap_BuildFolder=C:\Temp\Garmin
Set mkgmap_GeoFabrik=C:\Garmin\Geofabrik
Set mkgmap_InstallerDestinationFolder=C:\Walvis\Kaarten\JBM
Set mkgmap_DefaultConfig=10

Rem Divide Europe in reasonable parts less then 2 Gigabyte
Rem 1=Benelux, 2=Alpen, 3=Frankrijk - Noord, 4=Frankrijk - Zuid
Rem 5=Duitsland - Noord, 6=Duitsland - Zuid, 7=Italie, 8=Spanje, 9=Engeland
Rem 10=TEST, 11=Griekenland, 12=Oostblok, 13=Scandinavie, 14=Finland
Rem 21=Zuid Limburg, 22=Chiemsee, 23=Knokke, 24=Schiphol, 25=Bilbao

Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Rem Debug parameters
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Set mkgmap_BatchFileVersion=20170915 17h46
Set mkgmap_PauseAtEnd=True
Set mkgmap_SkipSplitter=True
Set mkgmap_SkipMkgmap=False
Set mkgmap_SkipNsis=False
Set mkgmap_SkipPoly=False
Set mkgmap_SkipRunInstaller=False

Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Rem Documentation
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM http://www.dostips.com/DtTipsStringManipulation.php
REM http://wiki.openstreetmap.org/wiki/Mkgmap/help/TYP_files

Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Rem Decide which config will be executed. If no config id is passed by the commandline switches it uses the default config as
Rem specified above. We need the name of this config in order to create a nice output folder for splitter-, img- and logfiles
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Set mkgmap_RunOnMapId=%mkgmap_DefaultConfig%
If Not [%1]==[] (Set mkgmap_RunOnMapId=%1)
If Not [%1]==[] (Set mkgmap_PauseAtEnd=False)
If Not [%2]==[] (Set mkgmap_SkipSplitter=%2)
Goto lbl_Default_Config%mkgmap_RunOnMapId%

Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
REM List of predefined configurations (The confignumber is also used for the family-id and splitter startnumber to avoid overlapping id's
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
:lbl_Default_Config1
REM Approximately 1h45 including splitter based on europe-latest
Set mkgmap_FamilyId=8001
Set mkgmap_Map=JBM - Benelux
Set mkgmap_Country=Benelux
Set mkgmap_Area=Benelux
Set mkgmap_Abbreviation=BNL
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=1.3
Set mkgmap_Poly_LeftUnder_Lat=49
Set mkgmap_Poly_RightUp_Lon=7.3
Set mkgmap_Poly_RightUp_Lat=55
Goto lbl_StartBuildProces

:lbl_Default_Config2
Set mkgmap_FamilyId=8002
Set mkgmap_Map=JBM - Alpen
Set mkgmap_Country=Alpen
Set mkgmap_Area=Alpen
Set mkgmap_Abbreviation=ALP
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\alps-latest.osm.pbf"
Set mkgmap_SkipPoly=True
Set mkgmap_Poly_LeftUnder_Lon=7.1
Set mkgmap_Poly_LeftUnder_Lat=45
Set mkgmap_Poly_RightUp_Lon=15
Set mkgmap_Poly_RightUp_Lat=48.3
Goto lbl_StartBuildProces

:lbl_Default_Config3
Set mkgmap_FamilyId=8003
Set mkgmap_Map=JBM - Frankrijk - Noord
Set mkgmap_Country=Frankrijk
Set mkgmap_Area=Frankrijk - Noord
Set mkgmap_Abbreviation=FR
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=-5.1
Set mkgmap_Poly_LeftUnder_Lat=47
Set mkgmap_Poly_RightUp_Lon=8.2
Set mkgmap_Poly_RightUp_Lat=51.1
Goto lbl_StartBuildProces

:lbl_Default_Config4
Set mkgmap_FamilyId=8004
Set mkgmap_Map=JBM - Frankrijk - Zuid
Set mkgmap_Country=Frankrijk
Set mkgmap_Area=Frankrijk - Zuid
Set mkgmap_Abbreviation=FR
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=-5.1
Set mkgmap_Poly_LeftUnder_Lat=42
Set mkgmap_Poly_RightUp_Lon=8.2
Set mkgmap_Poly_RightUp_Lat=47.5
Goto lbl_StartBuildProces

:lbl_Default_Config5
Set mkgmap_FamilyId=8005
Set mkgmap_Map=JBM - Duitsland - Noord
Set mkgmap_Country=Duitsland
Set mkgmap_Area=Duitsland - Noord
Set mkgmap_Abbreviation=DE
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=6.5
Set mkgmap_Poly_LeftUnder_Lat=50
Set mkgmap_Poly_RightUp_Lon=15.2
Set mkgmap_Poly_RightUp_Lat=55
Goto lbl_StartBuildProces

:lbl_Default_Config6
Set mkgmap_FamilyId=8006
Set mkgmap_Map=JBM - Duitsland - Zuid
Set mkgmap_Country=Duitsland
Set mkgmap_Area=Duitsland - Zuid
Set mkgmap_Abbreviation=DE
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=6.5
Set mkgmap_Poly_LeftUnder_Lat=47
Set mkgmap_Poly_RightUp_Lon=15.2
Set mkgmap_Poly_RightUp_Lat=50.5
Goto lbl_StartBuildProces

:lbl_Default_Config7
Set mkgmap_FamilyId=8007
Set mkgmap_Map=JBM - Italie
Set mkgmap_Country=Italie
Set mkgmap_Area=Italie
Set mkgmap_Abbreviation=IT
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=6.5
Set mkgmap_Poly_LeftUnder_Lat=34.4
Set mkgmap_Poly_RightUp_Lon=20
Set mkgmap_Poly_RightUp_Lat=47
Goto lbl_StartBuildProces

:lbl_Default_Config8
Set mkgmap_FamilyId=8008
Set mkgmap_Map=JBM - Spanje
Set mkgmap_Country=Spanje
Set mkgmap_Area=Spanje
Set mkgmap_Abbreviation=ESP
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=-11.1
Set mkgmap_Poly_LeftUnder_Lat=34.4
Set mkgmap_Poly_RightUp_Lon=6.5
Set mkgmap_Poly_RightUp_Lat=44
Goto lbl_StartBuildProces

:lbl_Default_Config9
Set mkgmap_FamilyId=8009
Set mkgmap_Map=JBM - Engeland
Set mkgmap_Country=Engeland
Set mkgmap_Area=Engeland
Set mkgmap_Abbreviation=UK
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=-11.1
Set mkgmap_Poly_LeftUnder_Lat=49
Set mkgmap_Poly_RightUp_Lon=2
Set mkgmap_Poly_RightUp_Lat=63
Goto lbl_StartBuildProces

:lbl_Default_Config10
Set mkgmap_FamilyId=8010
Set mkgmap_Map=TEST
Set mkgmap_Country=TEST
Set mkgmap_Area=TEST
Set mkgmap_Abbreviation=TST
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=10.3
Set mkgmap_Poly_LeftUnder_Lat=59.4
Set mkgmap_Poly_RightUp_Lon=11
Set mkgmap_Poly_RightUp_Lat=60.1
Goto lbl_StartBuildProces

:lbl_Default_Config11
Set mkgmap_FamilyId=8011
Set mkgmap_Map=JBM - Griekenland
Set mkgmap_Country=Griekenland
Set mkgmap_Area=Griekenland
Set mkgmap_Abbreviation=GR
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=19
Set mkgmap_Poly_LeftUnder_Lat=34.4
Set mkgmap_Poly_RightUp_Lon=31.6
Set mkgmap_Poly_RightUp_Lat=47
Goto lbl_StartBuildProces

:lbl_Default_Config12
Set mkgmap_FamilyId=8012
Set mkgmap_Map=JBM - Oostblok
Set mkgmap_Country=Oostblok
Set mkgmap_Area=Oostblok
Set mkgmap_Abbreviation=GR
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=15
Set mkgmap_Poly_LeftUnder_Lat=46.3
Set mkgmap_Poly_RightUp_Lon=25
Set mkgmap_Poly_RightUp_Lat=55
Goto lbl_StartBuildProces

:lbl_Default_Config13
Set mkgmap_FamilyId=8013
Set mkgmap_Map=JBM - Scandinavie
Set mkgmap_Country=Scandinavie
Set mkgmap_Area=Scandinavie
Set mkgmap_Abbreviation=SCA
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=3.5
Set mkgmap_Poly_LeftUnder_Lat=54.3
Set mkgmap_Poly_RightUp_Lon=32
Set mkgmap_Poly_RightUp_Lat=71.2
Rem 20170914 Default maxnodes = 1600000 was fine for all of europe until compiling Scandinivia
Rem 1600000 complained about 3 tiles
Rem 1400000 complained about 1 tile
Rem Lowering down to 1300000 solved the problem ? to be tested
Set mkgmap_MaxNodes=1300000
Goto lbl_StartBuildProces

:lbl_Default_Config14
Set mkgmap_FamilyId=8014
Set mkgmap_Map=JBM - Finland
Set mkgmap_Country=Finland
Set mkgmap_Area=Finland
Set mkgmap_Abbreviation=SU
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=20
Set mkgmap_Poly_LeftUnder_Lat=54.3
Set mkgmap_Poly_RightUp_Lon=34.4
Set mkgmap_Poly_RightUp_Lat=71.2
Goto lbl_StartBuildProces


:lbl_Default_Config21
Set mkgmap_FamilyId=8021
Set mkgmap_Map=JBM - Zuid Limburg
Set mkgmap_Country=Zuid Limburg
Set mkgmap_Area=Zuid Limburg
Set mkgmap_Abbreviation=ZLM
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=5.5
Set mkgmap_Poly_LeftUnder_Lat=50.6
Set mkgmap_Poly_RightUp_Lon=6.2
Set mkgmap_Poly_RightUp_Lat=50.9
Goto lbl_StartBuildProces

:lbl_Default_Config22
Set mkgmap_FamilyId=8022
Set mkgmap_Map=JBM - Chiemsee
Set mkgmap_Country=Chiemsee
Set mkgmap_Area=Testarea
Set mkgmap_Abbreviation=TR
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=12
Set mkgmap_Poly_LeftUnder_Lat=47
Set mkgmap_Poly_RightUp_Lon=13
Set mkgmap_Poly_RightUp_Lat=48
Goto lbl_StartBuildProces

:lbl_Default_Config23
Set mkgmap_FamilyId=8023
Set mkgmap_Map=JBM - Knokke
Set mkgmap_Country=Knokke
Set mkgmap_Area=Knokke
Set mkgmap_Abbreviation=KNK
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\europe-latest.osm.pbf"
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\belgium-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=3.15
Set mkgmap_Poly_LeftUnder_Lat=51.17
Set mkgmap_Poly_RightUp_Lon=3.77
Set mkgmap_Poly_RightUp_Lat=51.42
Goto lbl_StartBuildProces

:lbl_Default_Config24
Set mkgmap_FamilyId=8024
Set mkgmap_Map=JBM - Schiphol
Set mkgmap_Country=Schiphol
Set mkgmap_Area=Schiphol
Set mkgmap_Abbreviation=SH
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\netherlands-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=4.64
Set mkgmap_Poly_LeftUnder_Lat=52.27
Set mkgmap_Poly_RightUp_Lon=5
Set mkgmap_Poly_RightUp_Lat=52.4
Goto lbl_StartBuildProces

:lbl_Default_Config25
Set mkgmap_FamilyId=8025
Set mkgmap_Map=JBM - Bilbao
Set mkgmap_Country=Bilbao
Set mkgmap_Area=Bilbao
Set mkgmap_Abbreviation=BBA
Set mkgmap_SplitterInputFile="%mkgmap_GeoFabrik%\spain-latest.osm.pbf"
Set mkgmap_SkipPoly=False
Set mkgmap_Poly_LeftUnder_Lon=-3.3
Set mkgmap_Poly_LeftUnder_Lat=43
Set mkgmap_Poly_RightUp_Lon=-2.5
Set mkgmap_Poly_RightUp_Lat=44
Goto lbl_StartBuildProces

Rem Check if all folders exists or create them so we can start logging
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
:lbl_StartBuildProces
Set mkgmap_MyDir=%cd%
Set mkgmap_OutputFolderRoot=%mkgmap_BuildFolder%\%mkgmap_FamilyId% - %mkgmap_Map%
Set mkgmap_OutputFolderMap=%mkgmap_OutputFolderRoot%\Output Map
Set mkgmap_OutputFolderSplitter=%mkgmap_OutputFolderRoot%\Output Splitter
Set mkgmap_NsiInstallerExe=c:\Program Files (x86)\NSIS\makensis.exe

Set mkgmap_Logfile="%mkgmap_OutputFolderRoot%\mkgmap.log"
Set mkgmap_LogfileSplitter="%mkgmap_OutputFolderRoot%\splitter.log"

If %mkgmap_SkipMkgmap%==True (
	Set temp_status=# Skip mkgmap and don't clear destination output folder
	Goto lbl_SkipClearDestFolder
)

If Exist "%mkgmap_OutputFolderMap%" (
	Del /q "%mkgmap_OutputFolderMap%"\*.*
	Set temp_status=# Cleared destination [%mkgmap_OutputFolderMap%]
)

If Not Exist "%mkgmap_OutputFolderMap%" (
	mkdir "%mkgmap_OutputFolderMap%"
	Set temp_status=# Created destination [%mkgmap_OutputFolderMap%]
)
:lbl_SkipClearDestFolder


Rem Start logging
Echo # Start batchfile (version %mkgmap_batchFileVersion%)  on %date% %time% > %mkgmap_Logfile%
If [%1]==[] (Echo # No predefined configuration passed by the command line switches, use standard  [Default_Config%mkgmap_RunOnMapId%]>> %mkgmap_Logfile%)
@Echo on
Echo # Execute configuration [%mkgmap_Map%], [Default_Config%mkgmap_RunOnMapId%], family-id [%mkgmap_FamilyId%],  skip splitter: [%mkgmap_SkipSplitter%]>> %mkgmap_Logfile%
@Echo off
Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Check availability of folders and create them>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo %temp_status%>> %mkgmap_Logfile%

Rem Logfile can be created, from now on everything is written to the log immediately
If Not Exist "%mkgmap_OutputFolderSplitter%" (
	mkdir "%mkgmap_OutputFolderSplitter%"
	Echo # Destination [%mkgmap_OutputFolderSplitter%] created>> %mkgmap_Logfile%
)
If Not Exist "%mkgmap_InstallerDestinationFolder%" (
	mkdir "%mkgmap_InstallerDestinationFolder%"
	Echo # Installer folder [%mkgmap_InstallerDestinationFolder%] created>> %mkgmap_Logfile%
)

Rem Compose all variabels
Rem -------------------------------------------------------------------------------------------------------------------------------------------------------------------
Set mkgmap_Date=%date%
Set mkgmap_Date=%mkgmap_Date:~-10%
Set mkgmap_TypeFile_Typ=jbm_ws.typ
Set mkgmap_TypeFile_Typ=jbm_mpnk.typ
Set mkgmap_TypeFile_Txt="C:\Data\Garmin\Type Files\jbm_ws.txt"
Set mkgmap_TypeFile_Txt="C:\Data\Garmin\Type Files\jbm_mpnk.txt"
Set mkgmap_Cities=Cities15000.zip
Set mkgmap_NsiFile=osmmap.nsi
Set mkgmap_JavaMemory=8000
If [%mkgmap_MaxNodes%]==[] (Set mkgmap_MaxNodes=1600000)
Set mkgmap_ArgsSplitter="%mkgmap_OutputFolderSplitter%\template.args"
Set mkgmap_SplitterStartId=%mkgmap_FamilyId%0001
Set mkgmap_ArgsDefault="%mkgmap_MyDir%\mkgmap.args"
Set mkgmap_ArgsCommand="%mkgmap_OutputFolderSplitter%\osmmap.args"
Set mkgmap_MapName=%mkgmap_Map% (%mkgmap_Date%)
Set mkgmap_Polygonfile="%mkgmap_OutputFolderMap%\osmmap.poly"

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Logging of al environment variabels>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Set mkgmap>> %mkgmap_Logfile%

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Generate typefile with correct family id>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
If %mkgmap_SkipMkgmap%==True (
		Echo # !! Test option : mkgmap will NOT be executed>> %mkgmap_Logfile%
		Goto lbl_NoMkgmap
)
If Not Exist %mkgmap_TypeFile_Txt% (
	Echo # Typ-file  [%mkgmap_TypeFile_Txt%] does not exist ! Execution of the script will stop.>> %mkgmap_Logfile%
	Goto lbl_Error
)

Set mkgmap_ExecuteTypefileCommando=java -jar "%mkgmap_MyDir%\mkgmap.jar" --output-dir="%mkgmap_OutputFolderMap%" --family-id=%mkgmap_FamilyId% %mkgmap_Typefile_Txt%
Echo # Execute statement [%mkgmap_ExecuteTypefileCommando%]>> %mkgmap_Logfile%
%mkgmap_ExecuteTypefileCommando%
Rem cleanup left overs as a result of the typefile generation proces
Del /q "%mkgmap_OutputFolderMap%\osmmap.tdb">> %mkgmap_Logfile%
Del /q "%mkgmap_OutputFolderMap%\osmmap.img">> %mkgmap_Logfile%
Echo # Typ-file created with id [%mkgmap_FamilyId%] in folder [%mkgmap_OutputFolderMap%]>> %mkgmap_Logfile%

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Create poly area file>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
If %mkgmap_SkipPoly%==True (
	Echo # No poly file will be used because of a debug parameter or because there are no specific boundaries>> %mkgmap_Logfile%
	Goto lbl_SkipPoly
)

Echo %mkgmap_Map% > %mkgmap_Polygonfile%
Echo 1 >> %mkgmap_Polygonfile%
Echo    %mkgmap_Poly_LeftUnder_Lon%   %mkgmap_Poly_LeftUnder_Lat%>> %mkgmap_Polygonfile%
Echo    %mkgmap_Poly_LeftUnder_Lon%   %mkgmap_Poly_RightUp_Lat%>> %mkgmap_Polygonfile%
Echo    %mkgmap_Poly_RightUp_Lon%   %mkgmap_Poly_RightUp_Lat%>> %mkgmap_Polygonfile%
Echo    %mkgmap_Poly_RightUp_Lon%   %mkgmap_Poly_LeftUnder_Lat%>> %mkgmap_Polygonfile%
Echo END >> %mkgmap_Polygonfile%
Echo END >> %mkgmap_Polygonfile%
Set mkgmap_PolyParam=--polygon-file=%mkgmap_Polygonfile%
Echo # Polygon area file [%mkgmap_Polygonfile%] created>> %mkgmap_Logfile%
:lbl_SkipPoly

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Split the osm.pbf >> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
If Not Exist "%mkgmap_SplitterInputFile%" (
	Echo # !! ERROR: (Geofabrik pbf file to split [%mkgmap_SplitterInputFile%] could not be found>> %mkgmap_Logfile%
	Goto lbl_Error
)
Rem --geonames-file=%mkgmap_myDir%\%mkgmap_Cities%
Set mkgmap_ExecuteSplitterCommando=java -Xmx%mkgmap_JavaMemory%m -jar "%mkgmap_MyDir%\splitter.jar" --output-dir="%mkgmap_OutputFolderSplitter%" --max-nodes=%mkgmap_MaxNodes% --mapid=%mkgmap_splitterStartid% %mkgmap_polyparam%  %mkgmap_SplitterInputFile%
Echo # Execute statement [%mkgmap_ExecuteSplitterCommando%] >> %mkgmap_Logfile%
If %mkgmap_SkipSplitter%==True (
		Echo # !! Test option : Splitter is NOT executed>> %mkgmap_Logfile%
		Goto lbl_noSplitter
)
Del /q "%mkgmap_OutputFolderSplitter%"\*.*
Echo # All files in splitter destination folder  [%mkgmap_OutputFolderSplitter%] are deleted (%date% %time%)>> %mkgmap_Logfile%

%mkgmap_ExecuteSplitterCommando%>%mkgmap_LogfileSplitter%

Echo # Splitter executed to [%mkgmap_OutputFolderSplitter%] (%date% %time%)>> %mkgmap_Logfile%

:lbl_noSplitter
Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Prepare mkgmap arg options file in destination folder>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
If %mkgmap_SkipMkgmap%==True (
		Echo # !! Test option : mkgmap will NOT be executed>> %mkgmap_Logfile%
		Goto lbl_NoMkgmap
)
Rem Combine predefined arg with the splitter output
Rem Optional use the -c option twice see: http://www.openfietsmap.nl/procedure
Echo # Metadata of the map>%mkgmap_ArgsCommand%
Echo # --------------------------------------------->>%mkgmap_ArgsCommand%
Echo family-id: %mkgmap_FamilyId%>>%mkgmap_ArgsCommand%
Echo product-id: 1 >>%mkgmap_ArgsCommand%
Echo draw-priority: 20 >>%mkgmap_ArgsCommand%
Echo series-name: %mkgmap_MapName%>>%mkgmap_ArgsCommand%
Echo family-name: %mkgmap_Map%>>%mkgmap_ArgsCommand%
Echo description: %mkgmap_MapName%>>%mkgmap_ArgsCommand%
Echo copyright-message: Map data © openstreetmap.org, Map layout © Joris Bovens >>%mkgmap_ArgsCommand%
Echo area-name: %mkgmap_Area%>>%mkgmap_ArgsCommand%
Echo country-name: %mkgmap_Country%>>%mkgmap_ArgsCommand%
Echo country-abbr: %mkgmap_Abbreviation%>>%mkgmap_ArgsCommand%
Echo.>>%mkgmap_ArgsCommand%

Echo # Add default compile options>>%mkgmap_ArgsCommand%
Echo # --------------------------------------------->>%mkgmap_ArgsCommand%
Type %mkgmap_ArgsDefault%>>%mkgmap_ArgsCommand%
If Not Exist %mkgmap_ArgsDefault% (
Echo # !! ERROR : Splitter compile options [%mkgmap_ArgsDefault%] not found>> %mkgmap_Logfile%
Goto lbl_Error
)

Echo.>>%mkgmap_ArgsCommand%
Echo # Add splitter output>>%mkgmap_ArgsCommand%
Echo # --------------------------------------------->>%mkgmap_ArgsCommand%
If Not Exist %mkgmap_ArgsSplitter% (
Echo # !! ERROR : Splitter compile options [%mkgmap_ArgsSplitter%] not found>> %mkgmap_Logfile%
Goto lbl_Error
)
Type %mkgmap_ArgsSplitter%>>%mkgmap_ArgsCommand%

xcopy %mkgmap_ArgsCommand% "%mkgmap_OutputFolderMap%">> %mkgmap_Logfile%
Echo # File with compile options created and for logging purposes copied to [%mkgmap_ArgsCommand%]>> %mkgmap_Logfile%

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Start executing mkgmap>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
REM The order of parameters does matter. The -c option must be after the --output option and de typ-file must be last
Set mkgmap_ExecuteMkgmapCommando=java -Xmx%mkgmap_JavaMemory%m -jar "%mkgmap_MyDir%\mkgmap.jar" --output-dir="%mkgmap_OutputFolderMap%" -c %mkgmap_ArgsCommand% "%mkgmap_OutputFolderMap%"\%mkgmap_Typefile_Typ%
Echo # Execute statement [%mkgmap_ExecuteMkgmapCommando%] >> %mkgmap_Logfile%

%mkgmap_ExecuteMkgmapCommando%>> %mkgmap_Logfile%
Echo # Mkgmap executed>> %mkgmap_Logfile%
:lbl_NoMkgmap

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Generate nsis installer executable>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Start executing nsis installer creation:  %date% %time% >> %mkgmap_Logfile%
:lbl_FaseInstaller
If %mkgmap_SkipNsis%==True (
		Echo # !! Test option : No nsis installer executable will be created >> %mkgmap_Logfile%
		Goto lbl_NoNsisInstaller
)
REM cscript replace.vbs %mkgmap_OutputFolderMap%\%mkgmap_NsiFile% "C:\Garmin\Maps\" "C:\Garmin\Kaarten\"
If Not Exist "%mkgmap_OutputFolderMap%"\%mkgmap_NsiFile% (
	Echo # !! ERROR: Nsis installer configuration ["%mkgmap_OutputFolderMap%"\%mkgmap_NsiFile%] not found>> %mkgmap_Logfile%
	Goto lbl_Error
)
If Not Exist "%mkgmap_NsiInstallerExe%" (
	Echo # !! ERROR: Nsis software ["%mkgmap_NsiInstallerExe%"] not found>> %mkgmap_Logfile%
	Goto lbl_Error
)
"%mkgmap_NsiInstallerExe%" "%mkgmap_OutputFolderMap%"\%mkgmap_NsiFile%
Echo # Installer executable created:  %date% %time% >> %mkgmap_Logfile%
Echo.>> %mkgmap_Logfile%

If Not Exist "%mkgmap_OutputFolderMap%\%mkgmap_Map%.exe" (
	Echo # !! ERROR: Generated installer ["%mkgmap_OutputFolderMap%\%mkgmap_Map%.exe"] not found>> %mkgmap_Logfile%
	Goto lbl_Error
)
xCopy /y "%mkgmap_OutputFolderMap%\%mkgmap_Map%.exe"  "%mkgmap_InstallerDestinationFolder%" >> %mkgmap_Logfile%


Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Execute Basecamp installation>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
:lbl_FaseInstallerInstallation
If %mkgmap_SkipRunInstaller%==True (
		Echo # !! Test option : No basecamp installation of nsis installer >> %mkgmap_Logfile%
		Goto lbl_NoNsisInstaller
)
Echo # Start executing installer:  %date% %time% >> %mkgmap_Logfile%
Call "%mkgmap_OutputFolderMap%\%mkgmap_Map%.exe" /S
Echo # Installer executed:  %date% %time% >> %mkgmap_Logfile%
Echo.>> %mkgmap_Logfile%

:lbl_NoNsisInstaller

Echo.>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Echo # Clear Garmin Basecamp tile cache>> %mkgmap_Logfile%
Echo --------------------------------------------------------------------------->> %mkgmap_Logfile%
Del /Q "C:\Users\%username%\AppData\Local\Garmin\BaseCamp\TileCache\"*.tile
Echo # Tile cache deleted>> %mkgmap_Logfile%

Goto :lbl_EF

:lbl_Error
Echo # !! Please check the log for errors >> %mkgmap_Logfile%
Goto :lbl_EF

:lbl_EF
Echo.>> %mkgmap_Logfile%
Echo # End of mkgmap batchfile %date% %time% >> %mkgmap_Logfile%
If %mkgmap_PauseAtEnd%==True (Pause)
