;NSI Template version 1.2 / 20200608
!define REG_HEXID "9A21"
!define INSTALLER_DESCRIPTION "JBM - Luxembourg"
!define INSTALLER_NAME "JBM - Luxembourg"
!define REG_KEY "JBM - Luxembourg"
!define MAPNAME "osmmap"
!define TYPNAME "jbm.typ"
!define JBMNSI "jbmzip.nsi"
!define PRODUCT_ID "1"
!define INDEX

!define DEFAULT_DIR "$EXEDIR"
SetCompressor /SOLID lzma

; Includes
!include "MUI2.nsh"

; Installer pages
!define MUI_CUSTOMFUNCTION_GUIINIT myGuiInit
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${MAPNAME}_license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!define MUI_UNPAGE_INSTFILES

; Language files
!define MUI_LANGDLL_ALLLANGUAGES
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Dutch"

LangString AlreadyInstalled ${LANG_ENGLISH} "${INSTALLER_NAME} is already installed. $\n$\nClick `OK` to remove the previous version and continue installation or `Cancel` to cancel this upgrade."
LangString AlreadyInstalled ${LANG_FRENCH} "${INSTALLER_NAME} est déjà installé. $\n$\nAppuyez sur `OK` pour retirer la version précédente et continuer avec l'installation ou sur `Annuler` pour annuler cette mise à jour."
LangString AlreadyInstalled ${LANG_SPANISH} "${INSTALLER_NAME} ya está instalado. $\n$\nPulse `Aceptar` para eliminar la versión anterior y continuar la instalación o `Cancelar` para cancelar esta actualización."
LangString AlreadyInstalled ${LANG_GERMAN} "${INSTALLER_NAME} ist bereits installiert. $\n$\nKlick `OK` um die alte Version zu deinstallieren oder `Abbrechen` um die Installation abzubrechen."
LangString AlreadyInstalled ${LANG_DUTCH} "${INSTALLER_NAME} is reeds geinstalleerd. $\n$\nKlik op `OK` om de oude versie te verwijderen of `Annuleren` om deze update te onderbreken."

; Reservefiles
!insertmacro MUI_RESERVEFILE_LANGDLL ;Language selection dialog

Name "${INSTALLER_DESCRIPTION}"
OutFile "${INSTALLER_NAME}.exe"
InstallDir "${DEFAULT_DIR}"

Function .onInit
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Function myGUIInit
  ;Read $INSTDIR from the registry
  ClearErrors
  ReadRegStr $INSTDIR HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "LOC"
  IfErrors +2
  StrCmp $INSTDIR "" 0 +2
  StrCpy $INSTDIR "${DEFAULT_DIR}"
 
;--- Don't run uninstaller because it will remove the current directory :-)
  Goto done
;--- The user can run it manually once. Otherwise it's just only updating

 
  ; Uninstall before installing (code from http://nsis.sourceforge.net/Auto-uninstall_old_before_installing_new )
  ReadRegStr $R0 HKLM \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${REG_KEY}" "UninstallString"
  StrCmp $R0 "" done
 
  IfSilent silent
  MessageBox MB_OKCANCEL|MB_ICONEXCLAMATION "$(AlreadyInstalled)" IDOK uninst
  Abort

  ;Run the uninstaller
  uninst:
  ClearErrors
  ExecWait '"$R0" /S ' ;Do not copy the uninstaller to a temp file
 
  IfErrors no_remove_uninstaller done
    ;You can either use Delete /REBOOTOK in the uninstaller or add some code
    ;here to remove the uninstaller. Use a registry key to check
    ;whether the user has chosen to uninstall. If you are using an uninstaller
    ;components page, make sure all sections are uninstalled.
  no_remove_uninstaller:
  
  Goto done
 
  silent:
  ExecWait '"$R0" /S ' ;Do not copy the uninstaller to a temp file
 
  done:
 
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
FunctionEnd

Section "MainSection" SectionMain
; Files to be installed
  SetOutPath "$INSTDIR"
  File "${MAPNAME}.img"
  File "${TYPNAME}"
  File "${MAPNAME}.tdb"
!ifdef INDEX  
  File "${MAPNAME}_mdr.img"
  File "${MAPNAME}.mdx"
!endif

; Create MapSource registry keys
  WriteRegBin HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "ID" ${REG_HEXID}
!ifdef INDEX  
  WriteRegStr HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "IDX" "$INSTDIR\${MAPNAME}.mdx"
  WriteRegStr HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "MDR" "$INSTDIR\${MAPNAME}_mdr.img"
!endif
!ifdef TYPNAME  
  WriteRegStr HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "TYP" "$INSTDIR\${TYPNAME}"
!endif
  WriteRegStr HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "BMAP" "$INSTDIR\${MAPNAME}.img"
  WriteRegStr HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "LOC" "$INSTDIR"
  WriteRegStr HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "TDB" "$INSTDIR\${MAPNAME}.tdb"
  
; Write uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

; Create uninstaller registry keys
  WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${REG_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${REG_KEY}" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${REG_KEY}" "NoModify" 1
  
SectionEnd

Section "Uninstall"
; Files to be uninstalled (Can be more the files installed)
  Delete "$INSTDIR\*.img"
  Delete "$INSTDIR\${MAPNAME}_mdr.img"
  Delete "$INSTDIR\${MAPNAME}.mdx"
  Delete "$INSTDIR\${MAPNAME}.tdb"
  Delete "$INSTDIR\${MAPNAME}.nsi"
  Delete "$INSTDIR\${JBMNSI}"
  Delete "$INSTDIR\${MAPNAME}_license.txt"
  Delete "$INSTDIR\${TYPNAME}"
  Delete "$INSTDIR\${INSTALLER_NAME}.exe"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$INSTDIR\build.log"
  Delete "$INSTDIR\validation.log"
  Delete "$INSTDIR\mkgmap.style.zip"
  Delete "$INSTDIR\mkgmap.args"
  Delete "$INSTDIR\jbmhb.typ"
  Delete "$INSTDIR\jbm_ws.typ"
  Delete "$INSTDIR\jbmgps.typ"
 
 RmDir "$INSTDIR"

; Registry cleanup
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "ID"
!ifdef INDEX  
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "IDX"
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "MDR"
!endif
!ifdef TYPNAME  
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}" "TYP"
!endif
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "BMAP"
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "LOC"
  DeleteRegValue HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}" "TDB"
  DeleteRegKey /IfEmpty HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}\${PRODUCT_ID}"
  DeleteRegKey /IfEmpty HKLM "SOFTWARE\Garmin\MapSource\Families\${REG_KEY}"
  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${REG_KEY}"

SectionEnd


























