import SwiftUI

struct LockDetailView: View {
    let lock: TTLock
    @StateObject private var lockManager = LockManager.shared
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    @State private var showingRenameAlert = false
    @State private var newLockName = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Lock Header
                    VStack(spacing: 16) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text(lock.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(lock.macAddress)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                    .padding()
                    
                    // Status Card
                    VStack(spacing: 16) {
                        HStack {
                            Text("Estado")
                                .font(.headline)
                            Spacer()
                        }
                        
                        HStack {
                            StatusItem(
                                icon: "wifi",
                                title: "Conexión",
                                value: lock.isConnected ? "Conectado" : "Desconectado",
                                color: lock.isConnected ? .green : .red
                            )
                            
                            Divider()
                            
                            StatusItem(
                                icon: "battery.25",
                                title: "Batería",
                                value: "\(lock.batteryLevel)%",
                                color: batteryColor
                            )
                        }
                        
                        HStack {
                            StatusItem(
                                icon: "clock",
                                title: "Última vez",
                                value: timeAgoString,
                                color: .secondary
                            )
                            
                            Divider()
                            
                            StatusItem(
                                icon: "lock.fill",
                                title: "Estado",
                                value: "Desbloqueado",
                                color: .green
                            )
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Quick Actions
                    VStack(spacing: 16) {
                        HStack {
                            Text("Acciones Rápidas")
                                .font(.headline)
                            Spacer()
                        }
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ActionButton(
                                title: "Abrir",
                                icon: "lock.open.fill",
                                color: .green
                            ) {
                                lockManager.unlockLock(lock)
                            }
                            
                            ActionButton(
                                title: "Cerrar",
                                icon: "lock.fill",
                                color: .red
                            ) {
                                lockManager.lockLock(lock)
                            }
                            
                            ActionButton(
                                title: "Registro",
                                icon: "doc.text.fill",
                                color: .blue
                            ) {
                                lockManager.getLockLog(lock)
                            }
                            
                            ActionButton(
                                title: "Sincronizar",
                                icon: "clock.arrow.circlepath",
                                color: .orange
                            ) {
                                lockManager.setLockTime(lock)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Connection Status
                    if !lockManager.currentOperation.isEmpty {
                        VStack(spacing: 8) {
                            HStack {
                                Text("Operación Actual")
                                    .font(.headline)
                                Spacer()
                            }
                            
                            HStack {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text(lockManager.currentOperation)
                                    .font(.body)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Lock Information
                    VStack(spacing: 16) {
                        HStack {
                            Text("Información de la Cerradura")
                                .font(.headline)
                            Spacer()
                        }
                        
                        VStack(spacing: 12) {
                            InfoRow(title: "Nombre", value: lock.name)
                            InfoRow(title: "MAC Address", value: lock.macAddress)
                            InfoRow(title: "Datos", value: lock.lockData.isEmpty ? "No disponible" : lock.lockData)
                            InfoRow(title: "Batería", value: "\(lock.batteryLevel)%")
                            InfoRow(title: "Última conexión", value: dateString)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Detalles")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Renombrar") {
                            newLockName = lock.name
                            showingRenameAlert = true
                        }
                        
                        Button("Conectar") {
                            lockManager.connectToLock(lock)
                        }
                        
                        Button("Desconectar") {
                            lockManager.disconnectFromLock()
                        }
                        
                        Divider()
                        
                        Button("Eliminar", role: .destructive) {
                            showingDeleteAlert = true
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
        .alert("Eliminar Cerradura", isPresented: $showingDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Eliminar", role: .destructive) {
                lockManager.removeLock(lock)
                dismiss()
            }
        } message: {
            Text("¿Estás seguro de que quieres eliminar esta cerradura? Esta acción no se puede deshacer.")
        }
        .alert("Renombrar Cerradura", isPresented: $showingRenameAlert) {
            TextField("Nuevo nombre", text: $newLockName)
            Button("Cancelar", role: .cancel) { }
            Button("Guardar") {
                // Update lock name
                if let index = lockManager.savedLocks.firstIndex(where: { $0.id == lock.id }) {
                    lockManager.savedLocks[index].name = newLockName
                    lockManager.saveLocksToUserDefaults()
                }
            }
        } message: {
            Text("Ingresa el nuevo nombre para la cerradura")
        }
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
    
    private var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: lock.lastSeen)
    }
}

struct StatusItem: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    LockDetailView(lock: TTLock(name: "Cerradura Principal", macAddress: "AA:BB:CC:DD:EE:FF"))
}