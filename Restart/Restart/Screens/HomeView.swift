//
//  HomeView.swift
//  Restart
//
//  Created by Dhanush Arun on 7/7/22.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("onboarding") var IsOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            //HEADER
            
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? -35 : 35)
                    
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever()
                        ,value: isAnimating
                        
                    )
            }
            
            //CENTER
            
            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
                
            
            //FOOTER
            
            Spacer()
            
            Button(action: {
                PlaySound(sound: "success", type: "m4a")
                IsOnboardingViewActive = true
                
                /*
                withAnimation{
                    IsOnboardingViewActive = true
                    
                }
                 */
                
            }) {
                
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("Restart")
                
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
                
            })
        })
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
