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
                Color.clear
                
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
        
            //MARK: Info Panel
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top,30)
            , alignment: .top
        )
            //MARK: Contols
            .overlay(
                Group{
                    HStack{
                        //scale down
                        Button {
                            if imageScale > 1 {
                                imageScale -= 1
                            }
                                if imageScale <= 1 {
                                resetImageView()
                            }
                        } label: {
                            ContolImageView(icon: "minus.magnifyingglass")
                        }
                        
                        Button {
                          resetImageView()
                        } label: {
                            ContolImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        Button {
                            if imageScale < 5 {
                                imageScale += 1
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        } label: {
                            ContolImageView(icon: "plus.magnifyingglass")
                        }
                        
                        //reset
                        
                        //scale up
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.top,30)
            ,alignment: .bottom
                    
                
            )
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
