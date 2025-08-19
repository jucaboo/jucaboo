import SwiftUI
import CoreBluetooth

struct ScanView: View {
    @StateObject private var lockManager = LockManager.shared
    @State private var showingPermissionAlert = false
    @State private var showingAddLock = false
    @State private var selectedLock: TTLock?
    
    var body: some View {
        NavigationView {
            VStack {
                if lockManager.isScanning {
                    scanningView
                } else {
                    if lockManager.discoveredLocks.isEmpty {
                        emptyStateView
                    } else {
                        discoveredLocksView
                    }
                }
            }
            .navigationTitle("Escanear Cerraduras")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(lockManager.isScanning ? "Detener" : "Escanear") {
                        if lockManager.isScanning {
                            lockManager.stopScanning()
                        } else {
                            startScanning()
                        }
                    }
                    .disabled(lockManager.isConnecting)
                }
            }
        }
        .sheet(item: $selectedLock) { lock in
            AddLockSheet(lock: lock)
        }
        .alert("Permisos Requeridos", isPresented: $showingPermissionAlert) {
            Button("Configuración") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            Button("Cancelar", role: .cancel) { }
        } message: {
            Text("Esta app necesita acceso a Bluetooth y ubicación para escanear cerraduras TTLock. Por favor, habilita estos permisos en Configuración.")
        }
    }
    
    private var scanningView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 4)
                        .frame(width: 120, height: 120)
                    
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: lockManager.isScanning)
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
                
                VStack(spacing: 8) {
                    Text("Escaneando...")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Buscando cerraduras TTLock cercanas")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                if !lockManager.discoveredLocks.isEmpty {
                    Text("Cerraduras encontradas: \(lockManager.discoveredLocks.count)")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                Button("Detener Escaneo") {
                    lockManager.stopScanning()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "lock.open.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.gray)
                
                VStack(spacing: 12) {
                    Text("No se encontraron cerraduras")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Asegúrate de que las cerraduras TTLock estén encendidas y cerca de tu dispositivo")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button("Comenzar Escaneo") {
                    startScanning()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                Text("El escaneo durará 10 segundos")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
    
    private var discoveredLocksView: some View {
        List {
            Section(header: Text("Cerraduras Descubiertas")) {
                ForEach(lockManager.discoveredLocks) { lock in
                    DiscoveredLockRow(lock: lock) {
                        selectedLock = lock
                    }
                }
            }
            
            if !lockManager.savedLocks.isEmpty {
                Section(header: Text("Cerraduras Guardadas")) {
                    ForEach(lockManager.savedLocks) { lock in
                        SavedLockRow(lock: lock)
                    }
                }
            }
        }
        .refreshable {
            startScanning()
        }
    }
    
    private func startScanning() {
        // Check Bluetooth permissions
        if let centralManager = lockManager.centralManager,
           centralManager.state == .poweredOn {
            lockManager.startScanning()
        } else {
            showingPermissionAlert = true
        }
    }
}

struct DiscoveredLockRow: View {
    let lock: TTLock
    let onAdd: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(lock.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(lock.macAddress)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: "signal.3")
                        .foregroundColor(.green)
                    Text("Disponible")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
            
            Spacer()
            
            Button("Agregar") {
                onAdd()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
        }
        .padding(.vertical, 4)
    }
}

struct SavedLockRow: View {
    let lock: TTLock
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(lock.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(lock.macAddress)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    Image(systemName: lock.isConnected ? "wifi" : "wifi.slash")
                        .foregroundColor(lock.isConnected ? .green : .gray)
                    Text(lock.isConnected ? "Conectado" : "Desconectado")
                        .font(.caption)
                        .foregroundColor(lock.isConnected ? .green : .gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
        }
        .padding(.vertical, 4)
    }
}

struct AddLockSheet: View {
    let lock: TTLock
    @Environment(\.dismiss) private var dismiss
    @StateObject private var lockManager = LockManager.shared
    @State private var lockName: String = ""
    @State private var lockData: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información de la Cerradura")) {
                    HStack {
                        Text("Nombre")
                        Spacer()
                        TextField("Nombre de la cerradura", text: $lockName)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("MAC Address")
                        Spacer()
                        Text(lock.macAddress)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Datos")
                        Spacer()
                        TextField("Datos de la cerradura", text: $lockData)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Detalles")) {
                    HStack {
                        Text("Batería")
                        Spacer()
                        Text("\(lock.batteryLevel)%")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Estado")
                        Spacer()
                        Text("Disponible")
                            .foregroundColor(.green)
                    }
                }
                
                Section {
                    Button("Agregar Cerradura") {
                        addLock()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(lockName.isEmpty)
                }
            }
            .navigationTitle("Agregar Cerradura")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                lockName = lock.name
                lockData = lock.lockData
            }
        }
    }
    
    private func addLock() {
        let newLock = TTLock(
            name: lockName,
            macAddress: lock.macAddress,
            lockData: lockData,
            batteryLevel: lock.batteryLevel
        )
        
        lockManager.saveLock(newLock)
        dismiss()
    }
}

#Preview {
    ScanView()
}