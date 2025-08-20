# TTLock iOS App

Una aplicación iOS nativa para el control de cerraduras inteligentes TTLock.

## 🚀 Características

- **Escaneo Bluetooth**: Descubre cerraduras TTLock cercanas automáticamente
- **Gestión de Cerraduras**: Agrega, elimina y gestiona múltiples cerraduras
- **Control Remoto**: Abre y cierra cerraduras desde la app
- **Estado en Tiempo Real**: Monitorea el estado de batería y conexión
- **Registro de Eventos**: Obtiene el historial de acceso de las cerraduras
- **Sincronización**: Sincroniza el tiempo de las cerraduras
- **Interfaz Moderna**: Diseño SwiftUI con UX optimizada
- **Compatibilidad Amplia**: Funciona desde iPhone 6s (iOS 13.0) en adelante

## 📱 Requisitos

- iOS 13.0 o superior (iPhone 6s en adelante)
- Xcode 12.0 o superior
- Dispositivo con Bluetooth LE
- Cerraduras TTLock compatibles

## 🛠️ Instalación

1. **Clona el repositorio**:
   ```bash
   git clone <repository-url>
   cd TTLockApp
   ```

2. **Abre el proyecto en Xcode**:
   ```bash
   open TTLockApp.xcodeproj
   ```

3. **Configura el equipo de desarrollo**:
   - En Xcode, selecciona tu equipo de desarrollo
   - Cambia el Bundle Identifier si es necesario
   - Configura los certificados de firma

4. **Compila y ejecuta**:
   - Selecciona un simulador o dispositivo físico
   - Presiona ⌘+R para compilar y ejecutar

## 🔧 Configuración

### Permisos Requeridos

La app requiere los siguientes permisos:

- **Bluetooth**: Para conectarse con las cerraduras
- **Ubicación**: Para escanear dispositivos Bluetooth (requerido por iOS)

Estos permisos se configuran automáticamente en el archivo `Info.plist`:

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Esta app necesita acceso a Bluetooth para conectarse con las cerraduras TTLock</string>

<key>NSBluetoothPeripheralUsageDescription</key>
<string>Esta app necesita acceso a Bluetooth para conectarse con las cerraduras TTLock</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Esta app necesita acceso a la ubicación para escanear cerraduras TTLock cercanas</string>
```

### Integración con TTLock

Para integrar completamente con el protocolo TTLock:

1. **Obtén credenciales de desarrollador**:
   - Regístrate en [TTLock Developer Portal](https://open.ttlock.com)
   - Obtén tu Client ID y Client Secret

2. **Configura el SDK**:
   - Agrega el SDK de TTLock al proyecto
   - Configura las credenciales en `LockManager.swift`

3. **Implementa el protocolo completo**:
   - Reemplaza los comandos de ejemplo con el protocolo real de TTLock
   - Implementa la autenticación y encriptación requeridas

## 📖 Uso

### Escaneo de Cerraduras

1. Abre la app y ve a la pestaña "Escanear"
2. Presiona "Escanear" para buscar cerraduras cercanas
3. Las cerraduras encontradas aparecerán en la lista
4. Selecciona una cerradura para agregarla

### Gestión de Cerraduras

1. Ve a "Mis Cerraduras" para ver las cerraduras guardadas
2. Toca una cerradura para ver sus detalles
3. Usa las acciones rápidas para controlar la cerradura:
   - **Abrir**: Desbloquea la cerradura
   - **Cerrar**: Bloquea la cerradura
   - **Registro**: Obtiene el historial de acceso
   - **Sincronizar**: Sincroniza el tiempo

### Configuración

1. Ve a la pestaña "Configuración"
2. Revisa el estado del sistema
3. Accede a enlaces útiles y documentación
4. Gestiona los datos de la app

## 🏗️ Arquitectura

### Estructura del Proyecto

```
TTLockApp/
├── TTLockApp/
│   ├── AppDelegate.swift          # Configuración de la app
│   ├── SceneDelegate.swift        # Gestión de escenas
│   ├── ContentView.swift          # Vista principal con tabs
│   ├── LockManager.swift          # Gestión de cerraduras y Bluetooth
│   ├── LockListView.swift         # Lista de cerraduras guardadas
│   ├── LockDetailView.swift       # Detalles y control de cerradura
│   ├── ScanView.swift             # Escaneo de nuevas cerraduras
│   └── Assets.xcassets/           # Recursos gráficos
```

### Componentes Principales

#### LockManager
- Singleton que gestiona todas las operaciones de Bluetooth
- Implementa los protocolos `CBCentralManagerDelegate` y `CBPeripheralDelegate`
- Maneja la conexión, descubrimiento y comunicación con cerraduras

#### Vistas SwiftUI
- **ContentView**: Contenedor principal con navegación por tabs
- **LockListView**: Muestra cerraduras guardadas con opciones de gestión
- **LockDetailView**: Vista detallada con controles de cerradura
- **ScanView**: Interfaz de escaneo con animaciones y estados

### Modelos de Datos

```swift
struct TTLock: Identifiable, Codable {
    let id = UUID()
    var name: String
    var macAddress: String
    var lockData: String
    var batteryLevel: Int
    var isConnected: Bool
    var lastSeen: Date
}
```

## 🔌 Integración con TTLock

### Protocolo de Comunicación

La app implementa un protocolo básico de comunicación Bluetooth con cerraduras TTLock:

1. **Descubrimiento**: Escanea dispositivos con servicios TTLock específicos
2. **Conexión**: Establece conexión Bluetooth LE con la cerradura
3. **Autenticación**: Autentica la app con la cerradura
4. **Comandos**: Envía comandos para controlar la cerradura
5. **Respuestas**: Procesa las respuestas de la cerradura

### Comandos Implementados

- **Unlock**: Desbloquea la cerradura
- **Lock**: Bloquea la cerradura
- **GetLog**: Obtiene el registro de eventos
- **SetTime**: Sincroniza el tiempo

## 🚨 Limitaciones Actuales

⚠️ **Nota**: Esta es una implementación de demostración. Para uso en producción:

1. **Protocolo TTLock**: Los comandos actuales son ejemplos. Necesitas implementar el protocolo real de TTLock
2. **Autenticación**: Implementa el sistema de autenticación requerido por TTLock
3. **Encriptación**: Agrega la encriptación de datos requerida
4. **SDK Oficial**: Considera usar el SDK oficial de TTLock para iOS

## 🔒 Seguridad

- La app solicita permisos mínimos necesarios
- Los datos de cerraduras se almacenan localmente
- Las conexiones Bluetooth usan protocolos seguros
- Se implementan validaciones de entrada

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 Soporte

- **Documentación TTLock**: [https://open.ttlock.com/doc/api/v3/index](https://open.ttlock.com/doc/api/v3/index)
- **Soporte Técnico**: support@ttlock.com
- **Issues**: Usa la sección de Issues de GitHub

## 🙏 Agradecimientos

- TTLock por proporcionar la plataforma de cerraduras inteligentes
- La comunidad de desarrolladores iOS
- Contribuidores del proyecto

---

**Desarrollado con ❤️ para la comunidad TTLock**