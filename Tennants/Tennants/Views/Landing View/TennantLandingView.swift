import SwiftUI

struct TennantLandingView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
//            VStack {
                Spacer()
                    .frame(height: 80)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns) {
                        ForEach(0..<4) { item in
                            Text("Placeholder")
                                .frame(maxWidth: .infinity)
                                .frame(height: geometry.size.height / 2.5)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .background(Color.white)
                        }
                    }
                    .padding(.horizontal)
                }
//            }
            }
        .background {
            Color("PastelGrey")
        }
    }
}

#Preview {
    TennantLandingView()
}
