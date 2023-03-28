import SwiftUI

enum CardState {
    case love
    case poop
    case empty
}

struct CardView: View {
    @State private var translation: CGSize = .zero
    @State private var motionOffset: Double = .zero
    @State private var motionScale: Double = .zero
    @State private var lastCardState: CardState = .empty
    
    var cardAlpha: Double = 1.0
    var imageName: String
    var swipeAction: () -> Void
    
    private func getIconName(state: CardState) -> String {
        switch state {
            case .love:
                return "Love"
            case .poop:
                return "Poop"
            default:
                return "Empty"
        }
    }
    
    private func setCardState(offset: CGFloat) -> CardState {
        if offset <= CardViewConsts.poopTriggerZone { return .poop }
        if offset >= CardViewConsts.loveTriggerZone { return .love }
        return .empty
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Image(imageName)
                    .resizable()
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * CardViewConsts.cardRatio * 0.8)
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    Spacer()
                    Image(getIconName(state: lastCardState))
                        .frame(width: CardViewConsts.iconSize.width, height: CardViewConsts.iconSize.height)
                        .opacity(motionScale)
                        .scaleEffect(CGFloat(motionScale))
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.width * CardViewConsts.cardRatio)
            .background(Color.white)
            .opacity(cardAlpha)
            .cornerRadius(CardViewConsts.cardCornerRadius)
            .shadow(
                color: .cardShadow,
                radius: CardViewConsts.cardShadowBlur,
                x: 0,
                y: CardViewConsts.cardShadowOffset
            )
            .rotationEffect(
                .degrees(Double(translation.width / geometry.size.width * CardViewConsts.cardRotLimit)),
                anchor: .bottom
            )
            .offset(x: translation.width, y: translation.height)
            .animation(.interactiveSpring(
                        response: CardViewConsts.springResponse,
                        blendDuration: CardViewConsts.springBlendDur), value: translation
            )
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        translation = gesture.translation
                        motionOffset = Double(gesture.translation.width / geometry.size.width)
                        motionScale = Double.remap(
                            from: motionOffset,
                            fromMin: CardViewConsts.motionRemapFromMin,
                            fromMax: CardViewConsts.motionRemapFromMax,
                            toMin: CardViewConsts.motionRemapToMin,
                            toMax: CardViewConsts.motionRemapToMax
                        )
                        lastCardState = setCardState(offset: gesture.translation.width)
                    }
                    .onEnded { gesture in
                        if motionScale == 1 {
                            withAnimation { swipeAction() }
                        }
                        translation = .zero
                        motionScale = 0.0
                    }
            )
        }
    }
}

private struct CardViewConsts {
    static let cardRotLimit: CGFloat = 20.0
    static let poopTriggerZone: CGFloat = -0.1
    static let loveTriggerZone: CGFloat = 0.1
    
    static let cardRatio: CGFloat = 1.333
    static let cardCornerRadius: CGFloat = 24.0
    static let cardShadowOffset: CGFloat = 16.0
    static let cardShadowBlur: CGFloat = 16.0
    
    static let motionRemapFromMin: Double = 0.0
    static let motionRemapFromMax: Double = 0.25
    static let motionRemapToMin: Double = 0.0
    static let motionRemapToMax: Double = 1.0
    
    static let springResponse: Double = 0.5
    static let springBlendDur: Double = 0.3
    
    static let iconSize: CGSize = CGSize(width: 96.0, height: 96.0)
}
