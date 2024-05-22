#!/bin/bash

# Clone ou atualize o repositório do Flutter
if cd flutter; then
  git pull && cd .. ;
else
  git clone https://github.com/flutter/flutter.git;
fi

# Remover o arquivo flutter_tools.stamp
rm -f flutter/bin/cache/flutter_tools.stamp

# Modificar o arquivo chrome.dart para desabilitar web security
CHROME_DART_FILE="flutter/packages/flutter_tools/lib/src/web/chrome.dart"

if grep -q "--disable-web-security" "$CHROME_DART_FILE"; then
  echo "Web security already disabled in $CHROME_DART_FILE"
else
  sed -i '' 's/--disable-extensions/--disable-extensions --disable-web-security/' "$CHROME_DART_FILE"
  echo "Web security disabled in $CHROME_DART_FILE"
fi

# Executar comandos Flutter
flutter/bin/flutter doctor
flutter/bin/flutter clean
flutter/bin/flutter config --enable-web