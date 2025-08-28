TTLockApp (Delphi 12 FMX)

Pequeño esqueleto FMX con interfaz de servicio TTLock y mock para probar UI.

Estructura
- `TTLockApp.dpr` – entrada de app
- `src/App.MainForm.pas` – lista de puertas y escaneo
- `src/App.DoorForm.pas` – detalle de puerta con botón "Abrir"
- `src/TTLock/` – servicios e implementaciones
  - `ITTLockService.pas`, `TTLockModels.pas`, `TTLockServiceFactory.pas`
  - `TTLockService.Mock.pas` (mock), `TTLockService.Android.pas`, `TTLockService.iOS.pas`

Flujo
- Al iniciar, pide un código (por defecto `1234`).
- Muestra puertas disponibles (mock o SDK real).
- Al tocar una puerta, aparece pantalla con botón "Abrir". Muestra OK/Error y vuelve al listado.

Integración SDK TTLock
Android
- Añade AAR/JAR del SDK TTLock.
- Revisa `AndroidManifest.template.xml` para permisos BLE.
- Implementa métodos reales en `TTLockService.Android.pas`.

iOS
- Añade `TTLock.framework` al proyecto.
- Revisa `Info.plist.TemplateIOS.xml` para permisos.
- Implementa métodos reales en `TTLockService.iOS.pas`.

Credenciales
Sustituye en `App.MainForm.pas`:
  FService.Initialize('YOUR_TTLOCK_APP_ID', 'YOUR_TTLOCK_APP_SECRET');

Nota
El mock devuelve dispositivos simulados y siempre abre con éxito. Sustituir por SDK real para producción.
