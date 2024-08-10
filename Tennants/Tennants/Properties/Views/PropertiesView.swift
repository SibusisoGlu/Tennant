import SwiftUI
import MyLibrary
import SwiftData

struct PropertiesView: View {
    let modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PropertiesViewModel
    @State private var path: NavigationPath
    @State var mockProperies = ["Telesto"]
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        _viewModel = StateObject(wrappedValue: PropertiesViewModel(modelContext: modelContext))
        _path = State(initialValue: NavigationPath())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        if viewModel.properties.isEmpty {
                            AddView(title: "Add your first Property",
                                    image: Image("EmptyViewImage"),
                                    width: 250,
                                    height: 250,
                                    buttonTitle: "Add Property") {
                                viewModel.shouldAddPropertyOptions = true
                            }
                        } else {
                            Spacer()
                                .frame(height: 80)
                            
                                LazyVGrid(columns: viewModel.columns) {
                                    ForEach(Array(viewModel.properties.enumerated()), id: \.offset) { index, property in
                                        CardView(title: property.buildingName, 
                                                 image: Image("image\(index)"),
                                                 geometry: geometry) {
                                            viewModel.selectedProperty(property)
                                        }
                                    }
                                    
                                    VStack {
                                        PlusView(image: Image(systemName: "plus"), 
                                                 width: 100,
                                                 height: 100,
                                                 buttonColour: Color("DarkPastelBlue")) {
                                            viewModel.shouldAddPropertyOptions = true
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: geometry.size.height / 2.5)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.shouldAddPropertyOptions) {
                        PropertyOptionsView() { selectedOption in
                            viewModel.managePropertyOptions(selectedOption)
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.shouldShowAddProperty) {
                        AddPropertyView(data: $viewModel.newData, propertyOptions: viewModel.propertyType) {
                            viewModel.addProperty()
                        }
                    }
                    .navigationDestination(isPresented: $viewModel.showPropertyDetailView) {
                        withAnimation {
                            PropertyDetailView(property: viewModel.selectedProperty, viewModel: viewModel, path: $path)
                        }
                    }
                    //                .navigationDestination(isPresented: $showTennantView) {
                    //                    AddTenantView(data: $viewModel.newData, selectedProperty: viewModel.newProperty.buildingName) {
                    //                        viewModel.newData.isAProperty = false
                    //                        viewModel.addData()
                    //                    }
                    //                }
                }
            }
        }
    }
}
