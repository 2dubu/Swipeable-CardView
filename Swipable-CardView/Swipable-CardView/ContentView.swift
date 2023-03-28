import SwiftUI

struct ContentView: View {
    @State private var catImageNames: [String]
    
    private let cardOffset: CGFloat = 24
    private let cardRatio: CGFloat = 1.333
    private let cardOffsetMultiplier: CGFloat = 4
    private let cardAlphaStep: Double = 0.1
    
    init(catImageNames: [String]) {
        self.catImageNames = catImageNames
    }
    
    private var yCardsOffset: CGFloat {
        return -1.5 * cardOffset
    }
    
    private func calculateCardWidth(
        geo: GeometryProxy,
        offset: CGFloat,
        cardIndex: Int
    ) -> CGFloat {
        return geo.size.width - ((offset * 2) * CGFloat(cardIndex))
    }
    
    private func calculateCardYOffset(
        offset: CGFloat,
        cardIndex: Int
    ) -> CGFloat {
        return offset * CGFloat(cardIndex)
    }
    
    private func calculateItemInvertIndex(
        arr: [String],
        item: String
    ) -> Int {
        if arr.isEmpty { return 0 }
        return arr.count - 1 - arr.firstIndex(of: item)!
    }
    
    private func calculateCardAlpha(cardIndex: Int) -> Double {
        return 1.0 - Double(cardIndex) * cardAlphaStep
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    ZStack {
                        ForEach (catImageNames.suffix(3), id: \.self) { cat in
                            CardView(cardAlpha: calculateCardAlpha(cardIndex: calculateItemInvertIndex(arr: catImageNames, item: cat)), imageName: cat) {
                                catImageNames.removeLast()
                            }
                            .frame(width: calculateCardWidth(geo: geometry, offset: cardOffset, cardIndex: calculateItemInvertIndex(arr: catImageNames, item: cat)), height: geometry.size.width * cardRatio)
                            .offset(x: 0, y: calculateCardYOffset(offset: cardOffset, cardIndex: calculateItemInvertIndex(arr: catImageNames, item: cat)) * cardOffsetMultiplier)
                        }
                        
                        if catImageNames.isEmpty {
                            HStack {
                                Spacer()
                                Text("We're out of cute cat pictures now!")
                                Spacer()
                            }
                        }
                    }
                    .offset(y: yCardsOffset)
                    
                    Spacer()
                }
            }
        }
        .padding(cardOffset)
        .background(Color.accentColor)
        .edgesIgnoringSafeArea(.all)
    }
}
