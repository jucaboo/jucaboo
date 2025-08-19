import SwiftUI

struct LockListView: View {
    @StateObject private var lockManager = LockManager.shared
    @State private var showingAddLock = false
    @State private var selectedLock: TTLock?
    
    var body: some View {
        NavigationView {
            List {
                if lockManager.savedLocks.isEmpty {
                    Section {
                        VStack(spacing: 20) {
                            Image(systemName: "lock.open.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            
                            Text("No hay cerraduras guardadas")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Text("Usa la pestaña 'Escanear' para encontrar y agregar cerraduras TTLock")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            
                            Button("Ir a Escanear") {
                                // Navigate to scan tab
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                } else {
                    ForEach(lockManager.savedLocks) { lock in
                        LockRowView(lock: lock) {
                            selectedLock = lock
                        }
                    }
                    .onDelete(perform: deleteLocks)
                }
            }
            .navigationTitle("Mis Cerraduras")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Agregar") {
                        showingAddLock = true
                    }
                }
            }
            // Note: .refreshable is iOS 15+, using pull-to-refresh gesture instead
        }
        .sheet(item: $selectedLock) { lock in
            LockDetailView(lock: lock)
        }
        .sheet(isPresented: $showingAddLock) {
            AddLockView()
        }
    }
    
    private func deleteLocks(offsets: IndexSet) {
        for index in offsets {
            let lock = lockManager.savedLocks[index]
            lockManager.removeLock(lock)
        }
    }
    
    private func refreshLockStatus() {
        // Refresh lock status - in a real app, you might reconnect to locks
        // and update their status
    }
}

struct LockRowView: View {
    let lock: TTLock
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(lock.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(lock.macAddress)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Image(systemName: "battery.25")
                            .foregroundColor(batteryColor)
                        Text("\(lock.batteryLevel)%")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("Visto: \(timeAgoString)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: lock.isConnected ? "wifi" : "wifi.slash")
                        .foregroundColor(lock.isConnected ? .green : .gray)
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var batteryColor: Color {
        switch lock.batteryLevel {
        case 0..<20:
            return .red
        case 20..<50:
            return .orange
        default:
            return .green
        }
    }
    
    private var timeAgoString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: lock.lastSeen, relativeTo: Date())
    }
}

struct AddLockView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var lockManager = LockManager.shared
    @State private var lockName = ""
    @State private var macAddress = ""
    @State private var lockData = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información de la Cerradura")) {
                    TextField("Nombre de la cerradura", text: $lockName)
                    
                    TextField("Dirección MAC", text: $macAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    TextField("Datos de la cerradura (opcional)", text: $lockData)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("Cerraduras Descubiertas")) {
                    if lockManager.discoveredLocks.isEmpty {
                        Text("No se han descubierto cerraduras")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(lockManager.discoveredLocks) { lock in
                            Button(action: {
                                lockName = lock.name
                                macAddress = lock.macAddress
                                lockData = lock.lockData
                            }) {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(lock.name)
                                            .font(.headline)
                                        Text(lock.macAddress)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
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
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        saveLock()
                    }
                    .disabled(lockName.isEmpty || macAddress.isEmpty)
                }
            }
        }
    }
    
    private func saveLock() {
        let newLock = TTLock(
            name: lockName,
            macAddress: macAddress,
            lockData: lockData
        )
        
        lockManager.saveLock(newLock)
        dismiss()
    }
}

#Preview {
    LockListView()
}