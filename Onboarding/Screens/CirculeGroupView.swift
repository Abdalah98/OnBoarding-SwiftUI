//
//  CirculeGroupView.swift
//  Onboarding
//
//  Created by  Abdallah Omar on 16/04/2024.
//

import SwiftUI

struct CirculeGroupView: View {
    //MARK: - Property
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State private var isAnimating:Bool = false

    var body: some View {
        ZStack{
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity ),lineWidth: 40)
                .frame(width: 260,height: 260,alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity),lineWidth: 80)
                .frame(width: 260,height: 260,alignment: .center)
        }.blur(radius: isAnimating ? 0 : 10)
            .opacity(isAnimating ? 1: 0)
            .scaleEffect(isAnimating ? 1 : 0.5 )
            .animation(.easeOut(duration: 1),value: isAnimating )
            .onAppear(perform: {
                isAnimating = true
            })
    }
}

#Preview {
    ZStack {
        Color("ColorBlue")
             .ignoresSafeArea(.all,edges: .all )
        CirculeGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
    }
}
