//
//  HomeView.swift
//  Onboarding
//
//  Created by  Abdallah Omar on 15/04/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Propty

    @AppStorage("onboarding") var isOnboardingViewActive:Bool = true
    @State private var isAnimating:Bool = false

    // MARK: - Body

    var body: some View {
        
        VStack(spacing:20){
            Spacer()
            // H
            ZStack {
                CirculeGroupView(ShapeColor:  .gray, ShapeOpacity: 0.1 )
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y:isAnimating ? 35 : -35)
                    .animation(
                        .easeIn(duration: 4)
                        .repeatForever()
                        ,value: isAnimating
                    )
            }
            
            // C
            Spacer()
            Text("The time that leads to mastery is dependent on the  intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // F
            Spacer()
            VStack{
                Button(action: {
                    withAnimation {
                        playSound(sound: "success", type: "m4a")
                        isOnboardingViewActive = true
                    }
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Restart")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                })
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:{
                isAnimating = true
            })
        })
    }
}

#Preview {
    HomeView()
}
 
