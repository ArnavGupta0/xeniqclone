@echo off
echo Downgrading protoc_plugin to 20.0.1 for compatibility...
call dart pub global activate protoc_plugin 20.0.1

echo Adding Dart Pub Cache to PATH...
set PATH=%PATH%;%LOCALAPPDATA%\Pub\Cache\bin

echo Creating target directory...
if not exist "lib\src\generated" mkdir "lib\src\generated"

echo Generating Dart code...
protoc --proto_path=backend/proto --dart_out=grpc:lib/src/generated backend/proto/xeniq.proto

if %ERRORLEVEL% NEQ 0 (
    echo Error: Generation failed.
) else (
    echo Success! Files generated in lib/src/generated
)
