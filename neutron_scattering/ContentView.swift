//
//  ContentView.swift
//  neutron_scattering
//
//  Created by IIT Phys 440 on 2/10/23.
//

import SwiftUI


struct ContentView: View {
    
    @State var boxHeightString: String = "5"
    @State var boxWidthString: String = "5"
    @State var beamHeightString: String = "4"
    @State var energyLossPerCollisionString: String = "10"
    @State var neutronNumberString: String = "100"
    @State var leakProbability: Double = 0.0
    @ObservedObject var randomWalk = Random_Walk()
    
    var body: some View {
        
        HStack{
            
            VStack{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Neutron Scattering Simulator")
                HStack {
                    VStack{
                        HStack {
                            Text("Box Height:")
                            TextField("Enter a value the box height", text: $boxHeightString)
                        }
                        HStack {
                            Text("Box Width:")
                            TextField("Enter a value the box width", text: $boxWidthString)
                        }
                        
                        HStack {
                            Text("Neutron Number:")
                            TextField("Enter the number of neutrons", text: $neutronNumberString)
                        }
                    }
                    
                    VStack{
                        HStack {
                            Text("Beam Height:")
                            TextField("Enter a value the beam height", text: $beamHeightString)
                        }
                        HStack {
                            Text("Energy Loss (%):")
                            TextField("Enter a value the energy loss per collision", text: $energyLossPerCollisionString)
                        }
                        
                        Button("Compute!", action: {self.calculate()})
                        
                        Button("Clear", action: {self.clear()})
                        
                        Button("Compute Single Particle Path", action: {self.singleParticle()})
                    }
                }
                HStack {
                    Text("Leakage %:")
                    Text("\(self.leakProbability, specifier: "%.7f")")
                }
            }
            .padding()
            //DrawingField
            
            ZStack{
                
            drawingView(redLayer:$randomWalk.insideData, blueLayer: $randomWalk.outsideData)
                .padding()
                .aspectRatio(1, contentMode: .fit)
                
            BoxView(boxWidth: $randomWalk.boxWidth, boxHeight:$randomWalk.boxHeight)
                .padding()
                .aspectRatio(1, contentMode: .fit)
            
            SinglePathView(boxWidth: $randomWalk.boxWidth, boxHeight:$randomWalk.boxHeight, singlePath:$randomWalk.singlePath)
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                
            }
            // Stop the window shrinking to zero.
            Spacer()
            
                //.padding()
        }
    }
    
    func calculate(){
        self.clear()
        randomWalk.boxHeight = Double(boxHeightString)!
        randomWalk.boxWidth = Double(boxWidthString)!
        randomWalk.neutronNumber = Int(neutronNumberString)!
        randomWalk.beamHeight = Double(beamHeightString)!
        randomWalk.energyLossPerCollision = Double(energyLossPerCollisionString)!
        randomWalk.randomWalkComputation()
        
        leakProbability = randomWalk.leakProbability
    }
    
    func clear(){
        randomWalk.boxHeight = 0.0
        randomWalk.boxWidth = 0.0
        randomWalk.neutronNumber = 0
        randomWalk.beamHeight = 0.0
        randomWalk.energyLossPerCollision = 0.0
        randomWalk.insideData = []
        randomWalk.outsideData = []
        randomWalk.singlePath = []
        leakProbability = 0.0
    }
    
    func singleParticle(){
        self.clear()
        randomWalk.boxHeight = Double(boxHeightString)!
        randomWalk.boxWidth = Double(boxWidthString)!
        randomWalk.neutronNumber = 1
        randomWalk.beamHeight = Double(beamHeightString)!
        randomWalk.energyLossPerCollision = Double(energyLossPerCollisionString)!
        randomWalk.randomWalkComputation()
        
        print()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
