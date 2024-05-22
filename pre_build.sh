#!/bin/bash

# Clone ou atualize o repositório do Flutter
if cd flutter; then
  git pull && cd .. ;
else
  git clone https://github.com/flutter/flutter.git;
fi

# Listar os arquivos no diretório atual
ls

# Remover o arquivo flutter_tools.stamp
rm -f flutter/bin/cache/flutter_tools.stamp

# Modificar o arquivo chrome.dart para desabilitar web security
CHROME_DART_FILE="flutter/packages/flutter_tools/lib/src/web/chrome.dart"

if [ -f "$CHROME_DART_FILE" ]; then
  sed -i 's/--disable-extensions/--disable-extensions --disable-web-security/' "$CHROME_DART_FILE"
  echo "Web security disabled in $CHROME_DART_FILE"
else
  echo "File $CHROME_DART_FILE does not exist"
fi

# Executar comandos Flutter
flutter/bin/flutter doctor
flutter/bin/flutter clean
flutter/bin/flutter config --enable-web