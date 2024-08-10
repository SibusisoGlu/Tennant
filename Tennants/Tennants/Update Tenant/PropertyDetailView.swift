import SwiftUI
import MyLibrary

struct PropertyDetailView: View {
    @State var showDetailView: Bool
    @State var selectedTenant = Tennant()
    @State var tenants = MockTenants.tenants
    
    @ObservedObject var viewModel: PropertiesViewModel
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    var property: Property
    
    init(property: Property, viewModel: PropertiesViewModel, path: Binding<NavigationPath>) {
        _showDetailView = State(initialValue: false)
        self.property = property
        self.viewModel = viewModel
        self._path = path
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        VStack {
                            Text(property.buildingAddress)
                                .foregroundStyle(.black.opacity(0.7))
                            
                            Text("  All Units ocupied")
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    
                    ScrollView {
                        ForEach(tenants) { tenant in
                            UpdateTennantTopCardView(unitNumber: tenant.unitID, 
                                                     name: tenant.name,
                                                     surname: tenant.surname,
                                                     balance: "\(tenant.balance)",
                                                     amountDue: "\(tenant.amountDue)")
                                .onTapGesture {
                                    selectedTenant = tenant
                                    showDetailView = true
                                }
                                .padding(.horizontal)
                        }
                    }
                }
                .navigationTitle(property.buildingName)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        CustomMenuButton {
                            print("edit")
                        } option2Action: {
                            viewModel.manager.deleteProperties(property: property)
                            viewModel.refreshData()
                            dismiss()
                        }

                    }
                }
                .navigationDestination(isPresented: $showDetailView) {
                    withAnimation {
                        UpdateTennantView(tenant: $selectedTenant, $path)
                    }
                }
            }
        }
    }
}

//#Preview {
//    PropertyDetailView(property: Property(buildingName: "Telesto", buildingAddress: "Pinotage Street"), viewModel: <#PropertiesViewModel#>)
//}

struct CustomMenuButton: View {
    var option1Action: () -> Void
    var option2Action: () -> Void
    
    init(option1Action: @escaping () -> Void,
         option2Action: @escaping () -> Void) {
        self.option1Action = option1Action
        self.option2Action = option2Action
    }
    
    var body: some View {
        Menu {
            Button {
                option1Action()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(role: .destructive) {
                option2Action()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Label("", systemImage: "ellipsis.circle")
        }
    }
}
