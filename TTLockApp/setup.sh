#!/bin/bash

# TTLock iOS App Setup Script
# Este script ayuda a configurar el proyecto Xcode

echo "🔧 Configurando proyecto TTLock iOS App..."

# Verificar que estamos en el directorio correcto
if [ ! -f "TTLockApp.xcodeproj/project.pbxproj" ]; then
    echo "❌ Error: No se encontró el proyecto Xcode. Asegúrate de estar en el directorio TTLockApp."
    exit 1
fi

# Crear directorios necesarios si no existen
echo "📁 Creando directorios necesarios..."

mkdir -p "TTLockApp.xcworkspace/xcshareddata"
mkdir -p "TTLockApp.xcworkspace/xcuserdata/user.xcuserdata/xcschemes"
mkdir -p "TTLockApp.xcodeproj/xcuserdata/user.xcuserdata/xcschemes"
mkdir -p "TTLockApp.xcodeproj/xcuserdata/user.xcuserdata"
mkdir -p "TTLockApp/Assets.xcassets/AppIcon.appiconset"
mkdir -p "TTLockApp/Assets.xcassets/AccentColor.colorset"
mkdir -p "TTLockApp/Preview Content/Preview Assets.xcassets"

echo "✅ Directorios creados correctamente"

# Verificar archivos Swift
echo "📱 Verificando archivos Swift..."

SWIFT_FILES=(
    "TTLockApp/AppDelegate.swift"
    "TTLockApp/SceneDelegate.swift"
    "TTLockApp/ContentView.swift"
    "TTLockApp/LockManager.swift"
    "TTLockApp/LockListView.swift"
    "TTLockApp/LockDetailView.swift"
    "TTLockApp/ScanView.swift"
)

for file in "${SWIFT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ Faltante: $file"
    fi
done

# Verificar archivos de configuración
echo "⚙️ Verificando archivos de configuración..."

CONFIG_FILES=(
    "TTLockApp.xcodeproj/project.pbxproj"
    "TTLockApp.xcodeproj/project.xcworkspace/contents.xcworkspacedata"
    "TTLockApp.xcodeproj/xcshareddata/xcschemes/TTLockApp.xcscheme"
    "TTLockApp.xcodeproj/xcshareddata/IDEWorkspaceChecks.plist"
    "TTLockApp.xcworkspace/contents.xcworkspacedata"
    "TTLockApp.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist"
)

for file in "${CONFIG_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ Faltante: $file"
    fi
done

# Verificar archivos de assets
echo "🎨 Verificando archivos de assets..."

ASSET_FILES=(
    "TTLockApp/Assets.xcassets/Contents.json"
    "TTLockApp/Assets.xcassets/AppIcon.appiconset/Contents.json"
    "TTLockApp/Assets.xcassets/AccentColor.colorset/Contents.json"
    "TTLockApp/Preview Content/Preview Assets.xcassets/Contents.json"
)

for file in "${ASSET_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ Faltante: $file"
    fi
done

echo ""
echo "🎉 Configuración completada!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Abrir TTLockApp.xcodeproj en Xcode"
echo "2. Seleccionar tu equipo de desarrollo"
echo "3. Cambiar el Bundle Identifier si es necesario"
echo "4. Compilar y ejecutar (⌘+R)"
echo ""
echo "📱 Compatibilidad: iOS 13.0+ (iPhone 6s en adelante)"
echo "🔧 Xcode requerido: 12.0 o superior"
echo ""
echo "📚 Documentación disponible:"
echo "- README.md: Guía principal"
echo "- iOS13_COMPATIBILITY.md: Compatibilidad iOS 13"
echo "- SCREENSHOTS.md: Vista previa de la interfaz"
echo ""
echo "¡Listo para desarrollar! 🚀"