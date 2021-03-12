;App Hotel Installer
;Written by Marcos Gonzalez Leon
;DI Tema 7

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "App Hotel"
  OutFile "InstallAppHotel.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$PROGRAMFILES\AppHotel"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\App Hotel REGKEY" ""

  ;Request application privileges for Windows Vista
  ; Must BE admin level to create Desktop Shortcut
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Variables

  Var AppHotelJar

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\App Hotel REGKEY" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "App Hotel"

  !insertmacro MUI_PAGE_STARTMENU Application $AppHotelJar
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Installer Sections

Section "Default Directory Install" SecDummy

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...

    ; SOLUCION CORRECTA
      File /r "AppHotel.7z"
      Nsis7z::ExtractWithDetails "AppHotel.7z" "Installing package %s..."
      Delete "$INSTDIR\AppHotel.7z"

  ;Store installation folder
  WriteRegStr HKCU "Software\App Hotel REGKEY" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallAppHotel.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$AppHotelJar"
    CreateShortcut "$SMPROGRAMS\$AppHotelJar\AppHotel.lnk" "$INSTDIR\sAppHotel.jar"
    CreateShortcut "$SMPROGRAMS\$AppHotelJar\UninstallAppHotel.lnk" "$INSTDIR\UninstallAppHotel.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_SPANISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  ; SOLUCION TEMPORAL
  
  ; FORMA PRO B)
  Delete "$INSTDIR\lib\*.jar"
  RMDir "$INSTDIR\lib"

  ; Content web-files folder FORMA ABURRIDA
  Delete "$INSTDIR\web-files\dtjava.js"
  Delete "$INSTDIR\web-files\error.png"
  Delete "$INSTDIR\web-files\get_java.png"
  Delete "$INSTDIR\web-files\get_javafx.png"
  Delete "$INSTDIR\web-files\javafx-chrome.png"
  Delete "$INSTDIR\web-files\javafx-loading-25x25.gif"
  Delete "$INSTDIR\web-files\javafx-loading-100x100.gif"
  Delete "$INSTDIR\web-files\upgrade_java.png"
  Delete "$INSTDIR\web-files\upgrade_javafx.png"
  RMDir "$INSTDIR\web-files"

  Delete "$INSTDIR\sAppHotel.jar"
  Delete "$INSTDIR\AppHotel.html"
  Delete "$INSTDIR\AppHotel.jnlp"

  Delete "$INSTDIR\UninstallAppHotel.exe"
  RMDir "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $AppHotelJar
    
  ;Deletes the StartUpMenu Link connection/url created
  Delete "$SMPROGRAMS\$AppHotelJar\AppHotel.lnk"
  Delete "$SMPROGRAMS\$AppHotelJar\UninstallAppHotel.lnk"
  RMDir "$SMPROGRAMS\$AppHotelJar"

  ;Delete (?) installation folder  
  DeleteRegValue  HKCU "Software\App Hotel REGKEY" "App Hotel" 
  ; Deletes Default Key (bicoos, wont delete RegKey Entry entonces)
  DeleteRegValue  HKCU "Software\App Hotel REGKEY" "" 
  DeleteRegKey /ifempty HKCU "Software\App Hotel REGKEY"

SectionEnd
