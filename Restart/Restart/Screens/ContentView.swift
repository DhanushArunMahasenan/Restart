//
//  ContentView.swift
//  Restart
//
//  Created by Dhanush Arun on 7/7/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true

    
    var body: some View {
        ZStack {
            if isOnBoardingViewActive {
                OnboardingView()
                
            }
            
            else {
                HomeView()
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
