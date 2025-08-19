import Foundation
import CoreBluetooth
import Combine

// MARK: - Lock Models
struct TTLock: Identifiable, Codable {
    let id = UUID()
    var name: String
    var macAddress: String
    var lockData: String
    var batteryLevel: Int
    var isConnected: Bool
    var lastSeen: Date
    
    init(name: String, macAddress: String, lockData: String = "", batteryLevel: Int = 0) {
        self.name = name
        self.macAddress = macAddress
        self.lockData = lockData
        self.batteryLevel = batteryLevel
        self.isConnected = false
        self.lastSeen = Date()
    }
}

enum LockAction {
    case unlock
    case lock
    case getLog
    case setTime
}

enum LockError: Error, LocalizedError {
    case bluetoothNotAvailable
    case lockNotFound
    case connectionFailed
    case operationFailed(String)
    case permissionDenied
    
    var errorDescription: String? {
        switch self {
        case .bluetoothNotAvailable:
            return "Bluetooth no está disponible"
        case .lockNotFound:
            return "Cerradura no encontrada"
        case .connectionFailed:
            return "Error al conectar con la cerradura"
        case .operationFailed(let message):
            return "Operación fallida: \(message)"
        case .permissionDenied:
            return "Permiso denegado"
        }
    }
}

// MARK: - Lock Manager
class LockManager: NSObject, ObservableObject {
    static let shared = LockManager()
    
    @Published var discoveredLocks: [TTLock] = []
    @Published var savedLocks: [TTLock] = []
    @Published var isScanning = false
    @Published var isConnecting = false
    @Published var currentOperation: String = ""
    @Published var errorMessage: String?
    
    var centralManager: CBCentralManager?
    private var peripheralManager: CBPeripheralManager?
    private var discoveredPeripherals: [CBPeripheral] = []
    private var connectedPeripheral: CBPeripheral?
    private var lockCharacteristic: CBCharacteristic?
    
    // TTLock specific properties
    private let ttlockServiceUUID = CBUUID(string: "180D") // Example UUID
    private let ttlockCharacteristicUUID = CBUUID(string: "2A37") // Example UUID
    
    override init() {
        super.init()
        loadSavedLocks()
        setupBluetooth()
    }
    
    // MARK: - Bluetooth Setup
    private func setupBluetooth() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    // MARK: - Lock Operations
    func startScanning() {
        guard let centralManager = centralManager,
              centralManager.state == .poweredOn else {
            errorMessage = LockError.bluetoothNotAvailable.errorDescription
            return
        }
        
        isScanning = true
        discoveredLocks.removeAll()
        discoveredPeripherals.removeAll()
        
        // Scan for TTLock devices
        centralManager.scanForPeripherals(
            withServices: [ttlockServiceUUID],
            options: [CBCentralManagerScanOptionAllowDuplicatesKey: false]
        )
        
        // Stop scanning after 10 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.stopScanning()
        }
    }
    
    func stopScanning() {
        centralManager?.stopScan()
        isScanning = false
    }
    
    func connectToLock(_ lock: TTLock) {
        guard let peripheral = discoveredPeripherals.first(where: { $0.identifier.uuidString == lock.macAddress }) else {
            errorMessage = LockError.lockNotFound.errorDescription
            return
        }
        
        isConnecting = true
        currentOperation = "Conectando a \(lock.name)..."
        centralManager?.connect(peripheral, options: nil)
    }
    
    func disconnectFromLock() {
        if let peripheral = connectedPeripheral {
            centralManager?.cancelPeripheralConnection(peripheral)
        }
        connectedPeripheral = nil
        lockCharacteristic = nil
    }
    
    func unlockLock(_ lock: TTLock) {
        performLockAction(.unlock, for: lock)
    }
    
    func lockLock(_ lock: TTLock) {
        performLockAction(.lock, for: lock)
    }
    
    func getLockLog(_ lock: TTLock) {
        performLockAction(.getLog, for: lock)
    }
    
    func setLockTime(_ lock: TTLock) {
        performLockAction(.setTime, for: lock)
    }
    
    private func performLockAction(_ action: LockAction, for lock: TTLock) {
        guard connectedPeripheral != nil, lockCharacteristic != nil else {
            errorMessage = LockError.connectionFailed.errorDescription
            return
        }
        
        currentOperation = "Ejecutando \(actionDescription(action))..."
        
        // Here you would implement the actual TTLock protocol
        // This is a simplified example
        let command = createTTLockCommand(action: action, lockData: lock.lockData)
        
        if let peripheral = connectedPeripheral,
           let characteristic = lockCharacteristic {
            peripheral.writeValue(command, for: characteristic, type: .withResponse)
        }
    }
    
    private func actionDescription(_ action: LockAction) -> String {
        switch action {
        case .unlock:
            return "Apertura"
        case .lock:
            return "Cierre"
        case .getLog:
            return "Obtención de registro"
        case .setTime:
            return "Configuración de tiempo"
        }
    }
    
    private func createTTLockCommand(action: LockAction, lockData: String) -> Data {
        // This is a placeholder for the actual TTLock command structure
        // In a real implementation, you would follow TTLock's protocol specification
        var command = Data()
        
        switch action {
        case .unlock:
            command.append(contentsOf: [0x01, 0x02, 0x03]) // Example unlock command
        case .lock:
            command.append(contentsOf: [0x01, 0x02, 0x04]) // Example lock command
        case .getLog:
            command.append(contentsOf: [0x01, 0x02, 0x05]) // Example get log command
        case .setTime:
            let timestamp = Int(Date().timeIntervalSince1970)
            command.append(contentsOf: [0x01, 0x02, 0x06]) // Example set time command
            command.append(contentsOf: withUnsafeBytes(of: timestamp.littleEndian) { Data($0) })
        }
        
        return command
    }
    
    // MARK: - Lock Management
    func saveLock(_ lock: TTLock) {
        if !savedLocks.contains(where: { $0.macAddress == lock.macAddress }) {
            savedLocks.append(lock)
            saveLocksToUserDefaults()
        }
    }
    
    func removeLock(_ lock: TTLock) {
        savedLocks.removeAll { $0.macAddress == lock.macAddress }
        saveLocksToUserDefaults()
    }
    
    private func loadSavedLocks() {
        if let data = UserDefaults.standard.data(forKey: "SavedLocks"),
           let locks = try? JSONDecoder().decode([TTLock].self, from: data) {
            savedLocks = locks
        }
    }
    
    func saveLocksToUserDefaults() {
        if let data = try? JSONEncoder().encode(savedLocks) {
            UserDefaults.standard.set(data, forKey: "SavedLocks")
        }
    }
}

// MARK: - CBCentralManagerDelegate
extension LockManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth está disponible")
        case .poweredOff:
            errorMessage = "Bluetooth está desactivado"
        case .unauthorized:
            errorMessage = LockError.permissionDenied.errorDescription
        case .unsupported:
            errorMessage = "Bluetooth no es compatible"
        default:
            errorMessage = "Estado de Bluetooth desconocido"
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Check if this is a TTLock device
        if let name = peripheral.name, name.contains("TTLock") || name.contains("SmartLock") {
            let lock = TTLock(
                name: name,
                macAddress: peripheral.identifier.uuidString,
                batteryLevel: 100 // Default value
            )
            
            if !discoveredLocks.contains(where: { $0.macAddress == lock.macAddress }) {
                discoveredLocks.append(lock)
                discoveredPeripherals.append(peripheral)
            }
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        peripheral.delegate = self
        peripheral.discoverServices([ttlockServiceUUID])
        
        isConnecting = false
        currentOperation = "Conectado a \(peripheral.name ?? "Cerradura")"
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        isConnecting = false
        errorMessage = LockError.connectionFailed.errorDescription
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        connectedPeripheral = nil
        lockCharacteristic = nil
        currentOperation = "Desconectado"
    }
}

// MARK: - CBPeripheralDelegate
extension LockManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            errorMessage = "Error al descubrir servicios: \(error!.localizedDescription)"
            return
        }
        
        for service in peripheral.services ?? [] {
            peripheral.discoverCharacteristics([ttlockCharacteristicUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            errorMessage = "Error al descubrir características: \(error!.localizedDescription)"
            return
        }
        
        for characteristic in service.characteristics ?? [] {
            if characteristic.uuid == ttlockCharacteristicUUID {
                lockCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
                currentOperation = "Listo para operaciones"
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            errorMessage = "Error al recibir datos: \(error!.localizedDescription)"
            return
        }
        
        if let data = characteristic.value {
            handleTTLockResponse(data)
        }
    }
    
    private func handleTTLockResponse(_ data: Data) {
        // Handle TTLock response data
        // This would parse the actual TTLock protocol response
        currentOperation = "Operación completada"
        
        // Example response handling
        if data.count >= 3 {
            let status = data[2]
            switch status {
            case 0x00:
                currentOperation = "Operación exitosa"
            case 0x01:
                errorMessage = "Error en la operación"
            default:
                errorMessage = "Respuesta desconocida"
            }
        }
    }
}

// MARK: - CBPeripheralManagerDelegate
extension LockManager: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        // Handle peripheral manager state changes if needed
    }
}