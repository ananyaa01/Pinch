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
    @State private var imageScale : CGFloat = 1
    
    
    //MARK: Body
    
    var body: some View {
        NavigationView{
            ZStack{
                //MARK: PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                //MARK: PROPERTY 1
                    .onTapGesture (count: 2 , perform:{
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                                
                            }
                        }
                        else{
                            withAnimation(.spring()){
                                imageScale = 1

                            }
                        }
                            
                        }
                    )
            
                
                
        }
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
