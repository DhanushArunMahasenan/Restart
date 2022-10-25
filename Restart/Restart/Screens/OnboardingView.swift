//
//  OnboardingView.swift
//  Restart
//
//  Created by Dhanush Arun on 7/7/22.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnBoardingViewActive: Bool = true
    
    @State private var ButtonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var ButtonOffset: CGFloat = 0
    @State private var IsAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20){
                //HEADER
                
                Spacer()
                
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                        
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                }
                .opacity(IsAnimating ? 1 : 0)
                .offset(y: IsAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: IsAnimating)
                
                //CENTER
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(IsAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: IsAnimating)
                        .offset(x: imageOffset.width * 1.2, y:0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if abs(imageOffset.width) <= 150{
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                            
                                        }
                                        
                                    }
                                    
                                }
                                .onEnded { _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                        
                                    }
                                    
                                    
                                }
                                
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                }
                
                Spacer()
                
                //FOOTER
                ZStack {
                    //Background  (STATIC)
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    //call to action(STATIC)
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    
                    //Capsule(Dynamic width)
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: ButtonOffset + 80)
                        
                        Spacer()
                        
                    }
                    
                    //Circle(draggable)
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))

                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: ButtonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged( { gesture in
                                    if gesture.translation.width > 0 && ButtonOffset <= ButtonWidth - 80{
                                        ButtonOffset = gesture.translation.width
                                        
                                    }
                                    
                                })
                                .onEnded{ _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if ButtonOffset > ButtonWidth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            PlaySound(sound: "chimeup", type: "mp3")
                                            ButtonOffset = ButtonWidth - 80
                                            isOnBoardingViewActive = false
                                            
                                        }
                                        
                                        else {
                                            ButtonOffset = 0
                                        }
                                        
                                    }
                                    
                                }
                        )
                        
                        Spacer()
                        
                }
                    
                }
                
                .frame(width: ButtonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(IsAnimating ? 1 : 0)
                .offset(y: IsAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: IsAnimating)
                
            }
            .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .foregroundColor(.white)
                    .offset(y: 240)
                    .opacity(IsAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: IsAnimating)
                    .opacity(indicatorOpacity)
                , alignment: .center
                
            )
            
            
        }
        .onAppear(perform: {
            IsAnimating = true
            
        })
        .preferredColorScheme(.dark)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewInterfaceOrientation(.portrait)
    }
}
