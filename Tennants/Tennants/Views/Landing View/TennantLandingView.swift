import SwiftUI

struct TennantLandingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: LandingViewModel
    @State var shouldShowAddProperty: Bool
    
    init() {
        _viewModel = StateObject(wrappedValue: LandingViewModel())
        _shouldShowAddProperty = State(initialValue: false)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("PastelGrey")
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.properties.isEmpty {
                        AddView(shouldShowAddProperty: $shouldShowAddProperty,
                                title: "Add your first Property",
                                width: 250,
                                height: 250,
                                isNoData: viewModel.properties.isEmpty)
                    } else {
                        Spacer()
                            .frame(height: 80)
                    
                        GeometryReader { geometry in
                            LazyVGrid(columns: viewModel.columns) {
                                ForEach(Array(viewModel.properties.enumerated()), id: \.offset) { index, property in
                                    CardView(property: property, image: Image("image\(index)"), geometry: geometry)
                                }
                                
                                VStack {
                                    AddView(shouldShowAddProperty: $shouldShowAddProperty,
                                            width: 100,
                                            height: 100,
                                            isNoData: viewModel.properties.isEmpty)
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
                .sheet(isPresented: $shouldShowAddProperty, content: {
                    AddNewView(data: $viewModel.newData, isAProperty: true) {
                        viewModel.addData()
                        viewModel.clearData()
                    }
                })
            }
        }
    }
}

#Preview {
    TennantLandingView()
}
