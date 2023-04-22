//
//  RouletteView.swift
//  RestaurantRoulette
//
//  Created by Peyton Scott on 4/22/23.
//

import SwiftUI

struct RouletteView: View {
    let restaurants: [Restaurant]
    
    @State private var selectedIndex = 0
    @State private var spinAngle = Angle(degrees: 0)
    @State private var isSpinning = false
    @State private var hasSpunOnce = false
    
    private let wheelSize: CGFloat = UIScreen.main.bounds.width * 0.8
    private let segmentCount: Int
    private let segmentDegrees: Double
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
        self.segmentCount = restaurants.count
        self.segmentDegrees = 360.0 / Double(segmentCount)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Circle()
                .stroke(Color.white, lineWidth: 3)
                .frame(width: wheelSize, height: wheelSize)
                .overlay(
                    ZStack {
                        ForEach(restaurants.indices) { index in
                            let startAngle = Angle(degrees: Double(index) * self.segmentDegrees)
                            let endAngle = Angle(degrees: Double(index + 1) * self.segmentDegrees)
                            let segmentColor = index % 2 == 0 ? Color.red : Color.black
                            Path { path in
                                path.move(to: CGPoint(x: self.wheelSize / 2, y: self.wheelSize / 2))
                                path.addArc(center: CGPoint(x: self.wheelSize / 2, y: self.wheelSize / 2),
                                            radius: self.wheelSize / 2,
                                            startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: false)
                            }
                            .fill(segmentColor)
                            .rotationEffect(startAngle + self.spinAngle)
                            .offset(x: -self.wheelSize / 2, y: -self.wheelSize / 2)
                        }
                    }
                    .frame(width: wheelSize, height: wheelSize)
                    .offset(x: wheelSize / 2, y: wheelSize / 2)
                )
                .background(Color.black)
            
            Button(action: {
                withAnimation(.easeOut(duration: 3.0)) {
                    self.spinAngle += Angle(degrees: Double.random(in: 720...1440))
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.selectedIndex = Int.random(in: self.restaurants.indices)
                    self.isSpinning = false
                    self.hasSpunOnce = true
                }
                
                self.isSpinning = true
            }, label: {
                Text(isSpinning ? "Loading..." : "Spin")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
            })
            .padding(.top, 20)
            
            if hasSpunOnce {
                VStack {
                    Text("Selected Restaurant:")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(restaurants[selectedIndex].name)
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
