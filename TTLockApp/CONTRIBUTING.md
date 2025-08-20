# 🤝 Contributing to TTLock iOS App

¡Gracias por tu interés en contribuir al proyecto TTLock iOS App! 🎉

## 📋 **Cómo Contribuir**

### **1. Reportar Bugs**
- Usa la sección [Issues](https://github.com/tu-usuario/ttlock-ios-app/issues)
- Incluye información detallada del problema
- Adjunta capturas de pantalla si es posible
- Especifica tu versión de iOS y dispositivo

### **2. Solicitar Features**
- Crea un issue con la etiqueta `enhancement`
- Describe la funcionalidad que te gustaría ver
- Explica el caso de uso y beneficio

### **3. Contribuir Código**
- Fork el repositorio
- Crea una rama para tu feature
- Haz commit de tus cambios
- Abre un Pull Request

## 🛠️ **Configuración del Entorno de Desarrollo**

### **Requisitos**
- Xcode 12.0+ (recomendado Xcode 13.2)
- iOS 13.0+ SDK
- macOS 10.15.4+ (Catalina)
- Git

### **Configuración Inicial**
```bash
# 1. Clonar el repositorio
git clone https://github.com/tu-usuario/ttlock-ios-app.git
cd ttlock-ios-app

# 2. Ejecutar script de configuración
./setup.sh

# 3. Abrir en Xcode
open TTLockApp.xcodeproj
```

## 📝 **Guías de Código**

### **Swift Style Guide**
- Usar **SwiftLint** para consistencia
- Seguir las [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Usar **SwiftUI** para nuevas vistas
- Implementar **MVVM** pattern

### **Estructura de Archivos**
```
TTLockApp/
├── Models/           # Modelos de datos
├── Views/            # Vistas SwiftUI
├── ViewModels/       # ViewModels
├── Managers/         # Gestores de servicios
├── Utils/            # Utilidades
└── Resources/        # Recursos
```

### **Convenciones de Nomenclatura**
```swift
// Views
struct LockListView: View { }

// ViewModels
class LockListViewModel: ObservableObject { }

// Models
struct TTLock: Identifiable, Codable { }

// Managers
class LockManager: NSObject, ObservableObject { }

// Extensions
extension TTLock { }
```

## 🔧 **Proceso de Desarrollo**

### **1. Crear una Rama**
```bash
git checkout -b feature/nombre-de-la-feature
# o
git checkout -b fix/nombre-del-fix
```

### **2. Hacer Cambios**
- Escribe código limpio y bien documentado
- Agrega comentarios cuando sea necesario
- Sigue las convenciones del proyecto

### **3. Testing**
- Prueba en simulador iOS 13+
- Prueba en dispositivo físico si es posible
- Verifica que no haya regresiones

### **4. Commit**
```bash
git add .
git commit -m "feat: agregar nueva funcionalidad de escaneo

- Implementar escaneo automático de cerraduras
- Agregar filtros por tipo de dispositivo
- Mejorar UX con animaciones"
```

### **5. Push y Pull Request**
```bash
git push origin feature/nombre-de-la-feature
```

## 📋 **Checklist para Pull Requests**

### **Antes de Enviar**
- [ ] Código compila sin errores
- [ ] Tests pasan (si existen)
- [ ] Documentación actualizada
- [ ] No hay warnings críticos
- [ ] Código sigue las convenciones

### **Descripción del PR**
```markdown
## 🎯 Descripción
Breve descripción de los cambios

## 🔧 Cambios Realizados
- [ ] Cambio 1
- [ ] Cambio 2
- [ ] Cambio 3

## 📱 Testing
- [ ] Probado en simulador iOS 13
- [ ] Probado en simulador iOS 14
- [ ] Probado en dispositivo físico

## 📸 Screenshots (si aplica)
Adjuntar capturas de pantalla de los cambios

## 🔗 Issues Relacionados
Closes #123
```

## 🧪 **Testing**

### **Tipos de Testing**
- **Unit Tests**: Para lógica de negocio
- **UI Tests**: Para flujos de usuario
- **Integration Tests**: Para servicios externos

### **Ejecutar Tests**
```bash
# En Xcode: ⌘+U
# En terminal:
xcodebuild test -project TTLockApp.xcodeproj -scheme TTLockApp
```

## 📚 **Documentación**

### **Actualizar Documentación**
- README.md para cambios importantes
- CHANGELOG.md para nuevas features
- Comentarios en código para funciones complejas

### **Ejemplo de Documentación**
```swift
/// Manager para gestionar operaciones de cerraduras TTLock
/// 
/// Este manager maneja:
/// - Conexión Bluetooth con cerraduras
/// - Operaciones de apertura/cierre
/// - Gestión de estado de dispositivos
class LockManager: NSObject, ObservableObject {
    // Implementation...
}
```

## 🚨 **Reportar Problemas**

### **Template de Bug Report**
```markdown
## 🐛 Descripción del Bug
Descripción clara y concisa del problema

## 🔄 Pasos para Reproducir
1. Ir a '...'
2. Hacer clic en '...'
3. Scroll hasta '...'
4. Ver error

## ✅ Comportamiento Esperado
Lo que debería pasar

## 📱 Información del Sistema
- iOS: 13.0
- Dispositivo: iPhone 6s
- Xcode: 13.2
- Versión de la app: 1.0.0

## 📸 Screenshots
Adjuntar capturas de pantalla si es posible

## 📋 Información Adicional
Cualquier contexto adicional
```

## 🎯 **Áreas de Contribución**

### **Prioridad Alta**
- 🔐 Implementación del protocolo TTLock real
- 🔒 Sistema de autenticación completo
- 📱 Mejoras de UX/UI
- 🐛 Fixes de bugs críticos

### **Prioridad Media**
- 🧪 Unit tests
- 📊 Analytics
- 🌍 Localización
- 🔧 Optimizaciones de rendimiento

### **Prioridad Baja**
- 📚 Mejoras de documentación
- 🎨 Refactoring de código
- 🔍 Mejoras de accesibilidad

## 📞 **Contacto**

- **Issues**: [GitHub Issues](https://github.com/tu-usuario/ttlock-ios-app/issues)
- **Discussions**: [GitHub Discussions](https://github.com/tu-usuario/ttlock-ios-app/discussions)
- **Email**: tu-email@ejemplo.com

## 🙏 **Agradecimientos**

¡Gracias a todos los contribuidores que hacen este proyecto posible! 

---

**¡Juntos hacemos la mejor app TTLock para iOS!** 🚀