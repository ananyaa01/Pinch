//
//  ContentView.swift
//  Pinch
//
//  Created by Ananya Agarwal on 26/02/22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Property
    @State private var isAnimating: Bool = false
    @State private var imageOffset : CGSize = .zero
    @State private var imageScale : CGFloat = 1
    
    //MARK: Functions
    
    func resetImageView (){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    //MARK: Body
    
    var body: some View {
        NavigationView{
            ZStack{
                //MARK: PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(20)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                
                
                //MARK: DOUBLE TAP GESTURE
                    .onTapGesture (count: 2 , perform:{
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                                
                            }
                        }
                        else {
                            resetImageView()
                        }
                    }
                    )
            
                //MARK:  DRAG GESTURE
                .gesture(
                    DragGesture()
                     .onChanged { value in
                         withAnimation(.linear (duration:1)){
                             imageOffset = value.translation
                         }
                        
                    }
                        .onEnded{value in
                            if imageScale <= 1 {
                               resetImageView()
                            }
                            
                        }
                )
                
        }//ZStack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                isAnimating = true
            }
        
        
        
    }
        .navigationViewStyle(.stack)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
      .preferredColorScheme(.dark)
    }
}
