# 🎨 Vista Previa de la Interfaz - TTLock iOS App

## 📱 Pantalla Principal (TabView)

```
┌─────────────────────────────────────┐
│ 🔒 TTLock App                    ⚙️ │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ │
│  │ 🔒      │ │ 🔍      │ │ ⚙️      │ │
│  │ Mis     │ │ Escanear│ │ Config  │ │
│  │Cerraduras│ │         │ │         │ │
│  └─────────┘ └─────────┘ └─────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## 🏠 Tab 1: Mis Cerraduras

### Estado Vacío
```
┌─────────────────────────────────────┐
│ ← Mis Cerraduras              ➕ │
├─────────────────────────────────────┤
│                                     │
│           🔓                        │
│                                     │
│    No hay cerraduras guardadas      │
│                                     │
│  Usa la pestaña 'Escanear' para     │
│  encontrar y agregar cerraduras     │
│  TTLock                            │
│                                     │
│        [Ir a Escanear]              │
│                                     │
└─────────────────────────────────────┘
```

### Con Cerraduras Guardadas
```
┌─────────────────────────────────────┐
│ ← Mis Cerraduras              ➕ │
├─────────────────────────────────────┤
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🏠 Cerradura Principal          │ │
│ │ AA:BB:CC:DD:EE:FF              │ │
│ │ 🔋 85%    Visto: hace 2 min    │ │
│ │ 📶 Conectado              ▶️   │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🚪 Puerta Trasera              │ │
│ │ FF:EE:DD:CC:BB:AA              │ │
│ │ 🔋 45%    Visto: hace 5 min    │ │
│ │ 📶 Desconectado           ▶️   │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## 🔍 Tab 2: Escanear

### Estado de Escaneo
```
┌─────────────────────────────────────┐
│ ← Escanear                    ⏹️ │
├─────────────────────────────────────┤
│                                     │
│           🔄                        │
│        Escaneando...                │
│                                     │
│  Buscando cerraduras TTLock         │
│  cercanas                           │
│                                     │
│  Cerraduras encontradas: 2          │
│                                     │
│        [Detener Escaneo]            │
│                                     │
└─────────────────────────────────────┘
```

### Cerraduras Descubiertas
```
┌─────────────────────────────────────┐
│ ← Escanear                    🔍 │
├─────────────────────────────────────┤
│                                     │
│ Cerraduras Descubiertas             │
│ ┌─────────────────────────────────┐ │
│ │ 🔒 TTLock-001                  │ │
│ │ 11:22:33:44:55:66              │ │
│ │ 📶 Disponible        [Agregar] │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 🔒 SmartLock-002               │ │
│ │ 66:55:44:33:22:11              │ │
│ │ 📶 Disponible        [Agregar] │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Cerraduras Guardadas                │
│ ┌─────────────────────────────────┐ │
│ │ 🏠 Cerradura Principal          │ │
│ │ AA:BB:CC:DD:EE:FF              │ │
│ │ 📶 Conectado            ✅     │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## 🔒 Vista de Detalle de Cerradura

```
┌─────────────────────────────────────┐
│ ← Detalles                    ⋯ │
├─────────────────────────────────────┤
│                                     │
│           🔒                        │
│                                     │
│      Cerradura Principal            │
│                                     │
│      AA:BB:CC:DD:EE:FF             │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Estado                          │ │
│ │ 📶 Conectado    🔋 85%         │ │
│ │ 🕐 hace 2 min   🔓 Desbloqueado│ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Acciones Rápidas                │ │
│ │ ┌─────────┐ ┌─────────┐         │ │
│ │ │ 🔓      │ │ 🔒      │         │ │
│ │ │ Abrir   │ │ Cerrar  │         │ │
│ │ └─────────┘ └─────────┘         │ │
│ │ ┌─────────┐ ┌─────────┐         │ │
│ │ │ 📋      │ │ ⏰      │         │ │
│ │ │Registro │ │Sincronizar│       │ │
│ │ └─────────┘ └─────────┘         │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ Información de la Cerradura     │ │
│ │ Nombre: Cerradura Principal     │ │
│ │ MAC Address: AA:BB:CC:DD:EE:FF │ │
│ │ Datos: No disponible            │ │
│ │ Batería: 85%                    │ │
│ │ Última conexión: 2 min atrás    │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## ⚙️ Tab 3: Configuración

```
┌─────────────────────────────────────┐
│ ← Configuración                    │
├─────────────────────────────────────┤
│                                     │
│ Estado del Sistema                  │
│ ┌─────────────────────────────────┐ │
│ │ 📶 Bluetooth              ✅   │ │
│ │ Operación Actual: Conectado     │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Información                         │
│ ┌─────────────────────────────────┐ │
│ │ Acerca de TTLock                │ │
│ │ Documentación TTLock            │ │
│ │ Soporte Técnico                 │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Datos                               │
│ ┌─────────────────────────────────┐ │
│ │ Limpiar Cerraduras Guardadas    │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## 📋 Modal: Agregar Cerradura

```
┌─────────────────────────────────────┐
│ ← Agregar Cerradura           ❌ │
├─────────────────────────────────────┤
│                                     │
│ Información de la Cerradura         │
│ ┌─────────────────────────────────┐ │
│ │ Nombre: [Cerradura Nueva    ]   │ │
│ │ MAC Address: 11:22:33:44:55:66 │ │
│ │ Datos: [Datos de la cerradura]  │ │
│ └─────────────────────────────────┘ │
│                                     │
│ Detalles                            │
│ ┌─────────────────────────────────┐ │
│ │ Batería: 90%                    │ │
│ │ Estado: Disponible              │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │      [Agregar Cerradura]        │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
```

## 🎨 Características de Diseño

### Colores y Temas
- **Color Principal**: Azul (#007AFF)
- **Color de Éxito**: Verde (#34C759)
- **Color de Error**: Rojo (#FF3B30)
- **Color de Advertencia**: Naranja (#FF9500)
- **Fondo**: Gris claro (#F2F2F7)
- **Tarjetas**: Blanco (#FFFFFF)

### Tipografía
- **Títulos**: SF Pro Display Bold
- **Subtítulos**: SF Pro Display Medium
- **Cuerpo**: SF Pro Text Regular
- **Captions**: SF Pro Text Regular (más pequeño)

### Iconografía
- **Cerraduras**: 🔒 🔓
- **Bluetooth**: 📶
- **Batería**: 🔋
- **Tiempo**: 🕐 ⏰
- **Acciones**: 🔍 ⚙️ ➕

### Estados Visuales
- **Cargando**: Animación de spinner circular
- **Éxito**: Iconos verdes con checkmarks
- **Error**: Iconos rojos con mensajes
- **Desconectado**: Iconos grises
- **Conectado**: Iconos azules/verdes

### Interacciones
- **Taps**: Feedback háptico
- **Deslizar**: Para eliminar cerraduras
- **Pull to Refresh**: En listas
- **Long Press**: Para opciones adicionales

## 📱 Responsive Design

La app se adapta a diferentes tamaños de pantalla:
- **iPhone SE**: Layout compacto
- **iPhone 12/13/14**: Layout estándar
- **iPhone Pro Max**: Layout expandido
- **iPad**: Layout adaptativo con más espacio

## 🎯 UX/UI Highlights

1. **Navegación Intuitiva**: Tabs claros y accesibles
2. **Feedback Visual**: Estados claros para cada acción
3. **Acciones Rápidas**: Botones grandes y fáciles de tocar
4. **Información Clara**: Datos organizados en secciones
5. **Animaciones Suaves**: Transiciones fluidas entre estados
6. **Accesibilidad**: Soporte para VoiceOver y Dynamic Type