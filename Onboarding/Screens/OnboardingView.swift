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
   // @State private var imageOffset:CGSize = CGSize(width: 0, height: 0)
    @State private var imageOffset:CGSize = .zero
    @State private var indicatorOpacity:Double = 1.0
    @State private var textTitle :String = "Share."
    
    let hepticFeedback = UINotificationFeedbackGenerator()
    //MARK: - Body
    var body: some View {
        ZStack{
            Color("ColorBlue")
                .ignoresSafeArea()
            Spacer()

            VStack{
                //MARK: - Header
                VStack(spacing:0 ){
                    Text(textTitle )
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        . foregroundColor(.white)
                         .transition(.opacity)
                        .id(textTitle)
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
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration:  1),value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x:imageOffset.width * 1.2 , y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20 )))
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                }
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                })
                                
                        )//: gesture
                        .animation(.easeOut(duration:  1),value: imageOffset)
                }//: Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:5)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity )
,
                    alignment: .bottom
                 )
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
                                        playSound(sound: "chimeup", type: "mp3")
                                        hepticFeedback.notificationOccurred(.success)
                                        buttonOffset = buttonWidth - 80
                                        isOnboardingViewActive = false
                                    }else {
                                        hepticFeedback.notificationOccurred(.warning)
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
              .overlay {
                  if buttonOffset > buttonWidth / 2{
                           Text("Keep Swipe")
                              .font(.system(.title3,design: .rounded))
                              .fontWeight(.bold)
                              .foregroundColor(.white)
                              .padding(.trailing)
                  }
              }
            }
        }//: VStack
        .onAppear(perform: {
            isAnimating =  true
        })
        .preferredColorScheme(.dark)
    }//: ZStack
        
}

#Preview {
    OnboardingView()
}
