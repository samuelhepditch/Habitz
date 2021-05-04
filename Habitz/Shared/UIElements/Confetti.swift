//
//  Confetti.swift
//  Habitz
//
//  Created by Sam on 2021-04-08.
//

import SwiftUI


struct Movement{
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var opacity: Double
}

struct Confetti: View{
    @Binding var animate: Bool
    @State var movement = Movement(x: 0, y: 0, z: 1, opacity: 0)
    
    
    var body: some View{
        ConfettiView()
            .position(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.maxY * 0.9)
            .offset(x: movement.x, y: movement.y)
            .scaleEffect(movement.z)
            .opacity(movement.opacity)
            .onChange(of: animate) { _ in
                if animate {
                withAnimation(Animation.easeOut(duration: 0.4)) {
                    movement.opacity = 1
                    movement.x = CGFloat.random(in: (-UIScreen.main.bounds.width / 2)...(UIScreen.main.bounds.width / 2))
                    movement.y = -UIScreen.main.bounds.height * CGFloat.random(in: 0.1...0.9)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(Animation.easeIn(duration: 3)) {
                        movement.y = 200
                        movement.opacity = 0
                    }
                }
            }
            }
    }
}


struct ConfettiView: View {
    @State var animate = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...2)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    let rndColour = Int.random(in: 1...3)
    
    var body: some View {
        Rectangle()
            .foregroundColor(rndColour > 1 ? (rndColour == 2 ? .red : .blue) : .green)
            .frame(width: 20, height: 20)
            .onAppear(perform: { animate = true })
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 1, y: 0, z: 0))
            .animation(Animation.linear(duration: xSpeed).repeatForever(autoreverses: false), value: animate)
            .rotation3DEffect(.degrees(animate ? 360:0), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: anchor, y: anchor))
            .animation(Animation.linear(duration: zSpeed).repeatForever(autoreverses: false), value: animate)
    }
}


