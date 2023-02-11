//
//  SinglePathView.swift
//  neutron_scattering
//
//  Created by IIT Phys 440 on 2/10/23.
//

import SwiftUI

struct SinglePathView: View {
    
    @Binding var boxWidth : Double
    @Binding var boxHeight : Double
    @Binding var singlePath: [(xPoint: Double, yPoint: Double)]
    
    
    var body: some View {
    
        
        ZStack{
            
            drawSinglePath(drawingPoints: singlePath)
                .stroke(Color.green)
        }
        ///.background(Color.white)
        .aspectRatio(1, contentMode: .fill)
        
    }
}

struct SinglePathView_Previews: PreviewProvider {
    
    @State static var redLayer : [(xPoint: Double, yPoint: Double)] = [(10, 100), (10, 100), (0.0, 0.0), (0.0, 1.0)]
    @State static var blueLayer : [(xPoint: Double, yPoint: Double)] = [(10, 150), (2, 200), (1, 0.0)]
    
    static var previews: some View {
       
        
        drawingView(redLayer: $redLayer, blueLayer: $blueLayer)
            .aspectRatio(1, contentMode: .fill)
           
    }
}



struct drawSinglePath: Shape {
    
    
    let smoothness : CGFloat = 1.0
    var drawingPoints: [(xPoint: Double, yPoint: Double)]  ///Array of tuples
    
    func path(in rect: CGRect) -> Path {
        
               
        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: (rect.height / 2))
        let scale = rect.width
        let negativexOffset = -5.0
        let negativeyOffset = -5.0
        let displayRange = 20.0

        // Create the Path for the display
        
        var path = Path()
        
        for item in drawingPoints {
            
            
            path.addRect(CGRect(x: (item.xPoint-negativexOffset)*Double(scale)/displayRange , y: ((item.yPoint-negativeyOffset)*Double((-1.0/displayRange)*scale)+2.0*Double(center.y)), width: 2.0 , height: 2.0) )
            
        }


        return (path)
    }
}
