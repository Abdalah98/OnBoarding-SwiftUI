//
//  OnboardingView.swift
//  Onboarding
//
//  Created by  Abdallah Omar on 15/04/2024.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Proper ty
    @AppStorage("onboarding") var isOnboardingViewActive:Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating:Bool = false
    
    //MARK: - Body
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea()
            Spacer()

            VStack{
                //MARK: - Header
                VStack(spacing:0 ){
                    Text("Share.")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        . foregroundColor(.white)
                    Text("""
                        It's not how much we give but
                        how much love we put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light )
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center )
                    .padding(.horizontal,10)

                }
                .opacity(isAnimating ? 1 : 0 )
                .offset(y:isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1),value: isAnimating)
                //MARK: - Centre
                ZStack{
                    CirculeGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x:isAnimating ? 0 : 40)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                }//: Center
                
                Spacer()
                //MARK: - Footer
                ZStack{
                    //1 step
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8   )
                    
                    // 2 step
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
 
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80  )
//                            .overlay {
//                                Image(systemName: "arrow.right")
//                                    .font(.system(size: 40,weight: .heavy))
//                                    .foregroundColor(.white.opacity(0.5))
//                            }
                        Spacer()
                    }
                    
                    // 4 step
                    HStack{
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(height: 80,alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                if gesture.translation.width > 0  &&  buttonOffset <= buttonWidth - 80{
                                    buttonOffset = gesture.translation.width
                                }
                            })
                            .onEnded({ _ in
                                withAnimation(Animation.easeInOut(duration: 0.4 )){
                                    if buttonOffset > buttonWidth / 2{
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    }else {
                                        buttonOffset = 0
                                    }
                                }
                            })
                        )//: Gesture
                        Spacer()
                    }
                }
               .frame(width: buttonWidth,height: 80,alignment: .center)
              .padding()
              .opacity(isAnimating ? 1 : 0 )
              .offset(y : isAnimating  ? 0 : 40 )
              .animation(.easeOut(duration: 1),value: isAnimating)

            }
        }//: VStack
        .onAppear(perform: {
            isAnimating = true
        })
    }//: ZStack
        
}

#Preview {
    OnboardingView()
}
