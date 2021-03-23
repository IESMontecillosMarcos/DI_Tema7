@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  AppAgendaJPro startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and APP_AGENDA_J_PRO_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\AppAgendaJPro.jar;%APP_HOME%\lib\derbynet-10.15.2.0.jar;%APP_HOME%\lib\derby-10.15.2.0.jar;%APP_HOME%\lib\derbyclient-10.15.2.0.jar;%APP_HOME%\lib\hibernate-core-5.3.1.Final.jar;%APP_HOME%\lib\jaxb-api-2.3.0.jar;%APP_HOME%\lib\jpro-webapi-2019.2.6.jar;%APP_HOME%\lib\hsqldb-2.5.1.jar;%APP_HOME%\lib\org.eclipse.persistence.jpa-2.5.2.jar;%APP_HOME%\lib\javax.persistence-2.1.0.jar;%APP_HOME%\lib\org.eclipse.persistence.core-2.5.2.jar;%APP_HOME%\lib\org.eclipse.persistence.asm-2.5.2.jar;%APP_HOME%\lib\org.eclipse.persistence.antlr-2.5.2.jar;%APP_HOME%\lib\org.eclipse.persistence.jpa.jpql-2.5.2.jar;%APP_HOME%\lib\javafx-web-11-win.jar;%APP_HOME%\lib\javafx-fxml-11-win.jar;%APP_HOME%\lib\javafx-controls-11-win.jar;%APP_HOME%\lib\javafx-controls-11.jar;%APP_HOME%\lib\javafx-media-11-win.jar;%APP_HOME%\lib\javafx-media-11.jar;%APP_HOME%\lib\javafx-graphics-11-win.jar;%APP_HOME%\lib\javafx-graphics-11.jar;%APP_HOME%\lib\javafx-base-11-win.jar;%APP_HOME%\lib\javafx-base-11.jar;%APP_HOME%\lib\derbytools-10.15.2.0.jar;%APP_HOME%\lib\derbyshared-10.15.2.0.jar;%APP_HOME%\lib\hibernate-commons-annotations-5.0.3.Final.jar;%APP_HOME%\lib\jboss-logging-3.3.2.Final.jar;%APP_HOME%\lib\javax.persistence-api-2.2.jar;%APP_HOME%\lib\javassist-3.22.0-GA.jar;%APP_HOME%\lib\byte-buddy-1.8.12.jar;%APP_HOME%\lib\antlr-2.7.7.jar;%APP_HOME%\lib\jboss-transaction-api_1.2_spec-1.1.1.Final.jar;%APP_HOME%\lib\jandex-2.0.3.Final.jar;%APP_HOME%\lib\classmate-1.3.4.jar;%APP_HOME%\lib\dom4j-1.6.1.jar


@rem Execute AppAgendaJPro
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %APP_AGENDA_J_PRO_OPTS%  -classpath "%CLASSPATH%" AppAgendaJPro.Main %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable APP_AGENDA_J_PRO_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%APP_AGENDA_J_PRO_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega