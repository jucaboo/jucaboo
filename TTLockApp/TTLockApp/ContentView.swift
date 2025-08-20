import SwiftUI

struct ContentView: View {
    @StateObject private var lockManager = LockManager.shared
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LockListView()
                .tabItem {
                    Image(systemName: "lock.fill")
                    Text("Mis Cerraduras")
                }
                .tag(0)
            
            ScanView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Escanear")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Configuración")
                }
                .tag(2)
        }
        .accentColor(.blue)
        .alert(isPresented: .constant(lockManager.errorMessage != nil)) {
            Alert(
                title: Text("Error"),
                message: Text(lockManager.errorMessage ?? ""),
                dismissButton: .default(Text("OK")) {
                    lockManager.errorMessage = nil
                }
            )
        }
    }
}

struct SettingsView: View {
    @StateObject private var lockManager = LockManager.shared
    @State private var showingAbout = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Estado del Sistema")) {
                    HStack {
                        Text("Bluetooth")
                        Spacer()
                        Image(systemName: lockManager.errorMessage == nil ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(lockManager.errorMessage == nil ? .green : .red)
                    }
                    
                    if !lockManager.currentOperation.isEmpty {
                        HStack {
                            Text("Operación Actual")
                            Spacer()
                            Text(lockManager.currentOperation)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Información")) {
                    Button("Acerca de TTLock") {
                        showingAbout = true
                    }
                    
                    Link("Documentación TTLock", destination: URL(string: "https://open.ttlock.com/doc/api/v3/index")!)
                    
                    Link("Soporte Técnico", destination: URL(string: "mailto:support@ttlock.com")!)
                }
                
                Section(header: Text("Datos")) {
                    Button("Limpiar Cerraduras Guardadas") {
                        lockManager.savedLocks.removeAll()
                        UserDefaults.standard.removeObject(forKey: "SavedLocks")
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Configuración")
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
    }
}

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("TTLock App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Versión 1.0")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("Aplicación iOS para el control de cerraduras inteligentes TTLock")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Text("© 2024 TTLock. Todos los derechos reservados.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .navigationTitle("Acerca de")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar") {
                        // Dismiss sheet
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}