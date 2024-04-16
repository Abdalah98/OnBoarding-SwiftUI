//
//  ContentView.swift
//  Onboarding
//
//  Created by  Abdallah Omar on 15/04/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive:Bool = true
    var body: some View {
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            }else {
                HomeView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
