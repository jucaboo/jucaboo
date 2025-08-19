# 🔧 Guía de Solución de Problemas - TTLock iOS App

## ❌ **Problemas Comunes de Compatibilidad con Xcode**

### **1. Error: "Project file is corrupted"**
**Síntomas:**
- Xcode no puede abrir el proyecto
- Mensaje de error sobre archivo corrupto
- Proyecto aparece en gris

**Solución:**
```bash
# 1. Limpiar archivos de Xcode
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Caches/com.apple.dt.Xcode

# 2. Regenerar el proyecto
cd TTLockApp
./setup.sh
```

### **2. Error: "Unsupported Xcode version"**
**Síntomas:**
- Xcode muestra error de versión no soportada
- No se puede compilar el proyecto

**Versiones Compatibles:**
- **Xcode 15**: macOS 13.5+ (Ventura)
- **Xcode 14**: macOS 12.5+ (Monterey)
- **Xcode 13**: macOS 11.3+ (Big Sur)
- **Xcode 12**: macOS 10.15.4+ (Catalina)

### **3. Error: "Swift version incompatible"**
**Síntomas:**
- Error de compilación Swift
- Versiones de Swift incompatibles

**Solución:**
```swift
// En Build Settings del proyecto:
// Swift Language Version: Swift 5
// iOS Deployment Target: 13.0
```

### **4. Error: "Missing files"**
**Síntomas:**
- Archivos Swift no encontrados
- Referencias rotas en el proyecto

**Solución:**
```bash
# Verificar estructura de archivos
ls -la TTLockApp/TTLockApp/
ls -la TTLockApp/TTLockApp.xcodeproj/
```

## 🛠️ **Soluciones Rápidas**

### **Opción 1: Regenerar Proyecto Completo**
```bash
# 1. Navegar al directorio
cd TTLockApp

# 2. Ejecutar script de configuración
./setup.sh

# 3. Abrir en Xcode
open TTLockApp.xcodeproj
```

### **Opción 2: Crear Proyecto Nuevo**
```bash
# 1. Crear nuevo proyecto en Xcode
# File > New > Project > iOS > App

# 2. Configurar:
# - Product Name: TTLockApp
# - Team: Tu equipo de desarrollo
# - Organization Identifier: com.ttlock.app
# - Language: Swift
# - Interface: SwiftUI
# - Deployment Target: iOS 13.0

# 3. Copiar archivos Swift
cp TTLockApp/*.swift /ruta/al/nuevo/proyecto/
```

### **Opción 3: Usar Workspace**
```bash
# 1. Abrir workspace en lugar de proyecto
open TTLockApp.xcworkspace

# 2. Si no funciona, crear workspace manualmente
```

## 📱 **Configuración Manual del Proyecto**

### **1. Configuración del Target**
```
Target: TTLockApp
Deployment Target: iOS 13.0
Devices: iPhone, iPad
Orientation: Portrait, Landscape
```

### **2. Build Settings**
```
iOS Deployment Target: 13.0
Swift Language Version: Swift 5
Base SDK: Latest iOS
```

### **3. Info.plist (Generado automáticamente)**
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Esta app necesita acceso a Bluetooth para conectarse con las cerraduras TTLock</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>Esta app necesita acceso a Bluetooth para conectarse con las cerraduras TTLock</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Esta app necesita acceso a la ubicación para escanear cerraduras TTLock cercanas</string>
```

## 🔍 **Verificación de Archivos**

### **Archivos Requeridos:**
```
TTLockApp/
├── TTLockApp.xcodeproj/
│   ├── project.pbxproj ✅
│   ├── project.xcworkspace/
│   └── xcshareddata/
├── TTLockApp/
│   ├── AppDelegate.swift ✅
│   ├── SceneDelegate.swift ✅
│   ├── ContentView.swift ✅
│   ├── LockManager.swift ✅
│   ├── LockListView.swift ✅
│   ├── LockDetailView.swift ✅
│   ├── ScanView.swift ✅
│   └── Assets.xcassets/ ✅
└── README.md ✅
```

## 🚨 **Errores Específicos y Soluciones**

### **Error: "Could not find a storyboard named 'Main'**
**Solución:**
- El proyecto usa SwiftUI, no Storyboard
- Verificar que `SceneDelegate.swift` esté configurado correctamente

### **Error: "No such module 'CoreBluetooth'"**
**Solución:**
- Agregar `import CoreBluetooth` en `LockManager.swift`
- Verificar que el framework esté incluido

### **Error: "SwiftUI previews not working"**
**Solución:**
- Xcode 11+ requerido para SwiftUI
- Verificar versión de Xcode

### **Error: "Code signing issues"**
**Solución:**
```
1. Seleccionar tu equipo de desarrollo
2. Cambiar Bundle Identifier
3. Configurar certificados de firma
```

## 📋 **Checklist de Verificación**

### **Antes de Abrir el Proyecto:**
- [ ] Xcode 12.0+ instalado
- [ ] macOS compatible
- [ ] Equipo de desarrollo configurado
- [ ] Archivos del proyecto descargados completamente

### **Al Abrir el Proyecto:**
- [ ] Proyecto se abre sin errores
- [ ] Todos los archivos Swift están presentes
- [ ] Build Settings configurados correctamente
- [ ] Target seleccionado

### **Al Compilar:**
- [ ] No hay errores de compilación
- [ ] Warnings aceptables
- [ ] Proyecto se ejecuta en simulador
- [ ] Funcionalidades básicas funcionan

## 🆘 **Si Nada Funciona**

### **Opción Nuclear: Proyecto Completamente Nuevo**
```bash
# 1. Crear proyecto nuevo en Xcode
# 2. Copiar solo los archivos Swift
# 3. Configurar manualmente
# 4. Agregar permisos en Info.plist
```

### **Contacto de Soporte:**
- **Documentación**: README.md
- **Compatibilidad**: iOS13_COMPATIBILITY.md
- **Interfaz**: SCREENSHOTS.md

---

**¡No te rindas! La mayoría de problemas de compatibilidad tienen solución.** 💪