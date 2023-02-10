//
//  ContentView.swift
//  neutron_scattering
//
//  Created by IIT Phys 440 on 2/10/23.
//

import SwiftUI


struct ContentView: View {
    
    @State var boxHeightString: String = ""
    @State var boxWidthString: String = ""
    @State var beamHeightString: String = ""
    @State var energyLossPerCollisionString: String = ""
    @State var neutronNumberString: String = ""
    var body: some View {
        
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
                }
            }
        }
        
        .padding()
    }
    
    func calculate(){
        var randomWalk = Random_Walk()
        randomWalk.boxHeight = Double(boxHeightString)!
        randomWalk.boxWidth = Double(boxWidthString)!
        randomWalk.neutronNumber = Int(neutronNumberString)!
        randomWalk.beamHeight = Double(beamHeightString)!
        randomWalk.energyLossPerCollision = Double(energyLossPerCollisionString)!
        
        randomWalk.randomWalkComputation()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
