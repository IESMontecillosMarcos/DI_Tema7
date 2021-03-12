;LanzaAyuda
;Written by Marcos Gonzalez Leon
;DI Tema 7

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "LanzaAyuda"
  OutFile "InstallAyuda.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$PROGRAMFILES\LanzaAyuda"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\Lanza Ayuda REGKEY" ""

  ;Request application privileges for Windows Vista
  ; Must BE admin level to create Desktop Shortcut
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Variables

  Var LanzaAyudaJar

;--------------------------------
;Pages

  !define MUI_HEADERIMAGE 
  !define MUI_HEADERIMAGE_BITMAP "nsisvintage.bmp"

  !insertmacro MUI_PAGE_WELCOME  
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Lanza Ayuda REGKEY" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Lanza Ayuda"

  !insertmacro MUI_PAGE_STARTMENU Application $LanzaAyudaJar
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
       File /r "LanzaAyudaFolder.7z"
       Nsis7z::ExtractWithDetails "LanzaAyudaFolder.7z" "Installing package %s..."
       Delete "$INSTDIR\LanzaAyudaFolder.7z"

    ;  EXTRACCION CON ZIP [TESTING ]
    ;!insertmacro ZIPDLL_EXTRACT "$INSTDIR\LanzaAyuda.zip" "$INSTDIR" "<ALL>"

  ;Store installation folder
  WriteRegStr HKCU "Software\Lanza Ayuda REGKEY" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\UninstallLanzaAyuda.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$LanzaAyudaJar"
    CreateShortcut "$SMPROGRAMS\$LanzaAyudaJar\LanzaAyuda.lnk" "$INSTDIR\DI_T6_HelpGUI.jar"
    CreateShortcut "$SMPROGRAMS\$LanzaAyudaJar\UninstallLanzaAyuda.lnk" "$INSTDIR\UninstallLanzaAyuda.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

; -----------------------

Section /o "Incluir Icono de Escritorio"
  ; Creates Desktop Shortcut
  CreateShortCut "$DESKTOP\LanzaAyuda.lnk" "$INSTDIR\DI_T6_HelpGUI.jar"
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
  
  ; Deletes Shortcut
  Delete "$DESKTOP\LanzaAyuda.lnk"

  Delete "$INSTDIR\lib\javahelp-2.0.05.jar"
  Delete "$INSTDIR\lib\MenuDemo.jar"
  RMDir "$INSTDIR\lib"

  Delete "$INSTDIR\DI_T6_HelpGUI.jar"
  Delete "$INSTDIR\README.TXT"

  Delete "$INSTDIR\UninstallLanzaAyuda.exe"
  RMDir "$INSTDIR"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $LanzaAyudaJar
    
  ;Deletes the StartUpMenu Link connection/url created
  Delete "$SMPROGRAMS\$LanzaAyudaJar\LanzaAyuda.lnk"
  Delete "$SMPROGRAMS\$LanzaAyudaJar\UninstallLanzaAyuda.lnk"
  RMDir "$SMPROGRAMS\$LanzaAyudaJar"

  ;Dete (?) installation folder  
  DeleteRegValue  HKCU "Software\Lanza Ayuda REGKEY" "Lanza Ayuda" 
  ; Deletes Default Key (bicoos, wont delete RegKey Entry entonces)
  DeleteRegValue  HKCU "Software\Lanza Ayuda REGKEY" "" 
  DeleteRegKey /ifempty HKCU "Software\Lanza Ayuda REGKEY"

SectionEnd
