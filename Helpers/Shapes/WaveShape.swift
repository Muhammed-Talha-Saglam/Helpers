//
//  WaveShape.swift
//  Helpers
//
//  Created by Muhammed Talha Sağlam on 31.08.2024.
//

import SwiftUI


struct WaveShape: Shape {
    
    // how high our waves should be
    var strength: Double
    
    // how frequent our waves should be
    var frequency: Double
    
    // how much to offset our waves horizontally
    var phase: Double
    
    var progress: CGFloat
    
    // allow SwiftUI to animate the wave phase
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }

    
    func path(in rect: CGRect) -> Path {
        return Path({ path in
            // calculate some important values up front
            let width = Double(rect.width)
            let height = Double(rect.height)

            let midHeight = height / 2
            let midWith = width / 2
            
            let waveHeight = height * strength
            let waveLength = width / frequency
            
            let progressHeight = (1-progress) * height
            
            let oneOverMidWith = 1 / midWith
            
            // start at the left center
            path.move(to: CGPoint(x: 0, y: midHeight))

            
            // now count across individual horizontal points one by one
            for x in stride(from: 0, through: width, by: 2) {
                let relativeX = x / waveLength
                
                let distanceFromMidWith = x - midWith
                let normalDistance = oneOverMidWith * distanceFromMidWith
                let parabola = -(normalDistance * normalDistance) + 1
                
                // calculate the sine of that position
//                let sine = memoizedSine(Angle(degrees: x + phase).radians)
                let sine = memoizedSine(relativeX + phase)

                // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
                let y = parabola * waveHeight * sine + progressHeight
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            
        })
    }
    
}


var sineCache: [Double: Double] = [:]

// Step 2: Define the memoized sine function
func memoizedSine(_ x: Double) -> Double {
    // Step 3: Check if the value is already in the cache
    if let cachedValue = sineCache[x] {
        return cachedValue
    }
    
    // Step 4: Compute the sine value if it's not in the cache
    let sineValue = sin(x)
    
    // Step 5: Store the computed value in the cache
    sineCache[x] = sineValue
    
    return sineValue
}


struct SampleView: View {
    
    @State var progress: CGFloat = 0.5
    @State var phase: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.black
            WaveShape(strength: 0.1, frequency: 5, phase: phase, progress: progress)
                .fill(Color.red)
        }
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        })
    }
}

#Preview {
    SampleView()
}
