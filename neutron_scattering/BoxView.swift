//
//  BoxView.swift
//  neutron_scattering
//
//  Created by IIT Phys 440 on 2/10/23.
//

import SwiftUI

struct BoxView: View {
    
    @Binding var boxWidth : Double
    @Binding var boxHeight : Double
    
    var body: some View {
    
        
        ZStack{
            
            var blueLayer = [(xPoint: 0.0, yPoint: 0.0), (xPoint: boxWidth, yPoint: 0.0), (xPoint: boxWidth, yPoint: boxHeight), (xPoint: 0.0, yPoint: boxHeight), (xPoint: 0.0, yPoint: 0.0)]
            
            drawBox(drawingPoints: blueLayer )
                .stroke(Color.black)
        }
        ///.background(Color.white)
        .aspectRatio(1, contentMode: .fill)
        
    }
}

struct BoxView_Previews: PreviewProvider {
    
    @State static var redLayer : [(xPoint: Double, yPoint: Double)] = [(10, 100), (10, 100), (0.0, 0.0), (0.0, 1.0)]
    @State static var blueLayer : [(xPoint: Double, yPoint: Double)] = [(10, 150), (2, 200), (1, 0.0)]
    
    static var previews: some View {
       
        
        drawingView(redLayer: $redLayer, blueLayer: $blueLayer)
            .aspectRatio(1, contentMode: .fill)
           
    }
}



struct drawBox: Shape {
    
   
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
        
        path.move(to: CGPoint(x: (drawingPoints[0].xPoint-negativexOffset)*Double(scale)/displayRange, y: ((drawingPoints[0].yPoint-negativeyOffset)*Double((-1.0/displayRange)*scale)+2.0*Double(center.y))))
        
        for item in 1..<(drawingPoints.endIndex) {

                    // loop over all our points to draw create the paths
                    for item in 1..<(drawingPoints.endIndex)  {
                    
                        path.addLine(to:  CGPoint(x: (drawingPoints[item].xPoint-negativexOffset)*Double(scale)/displayRange, y: ((drawingPoints[item].yPoint-negativeyOffset)*Double((-1.0/displayRange)*scale)+2.0*Double(center.y))))
                        
                        
                        }

            
//            path.addRect(CGRect(x: (item.xPoint-negativexOffset)*Double(scale)/displayRange , y: ((item.yPoint-negativeyOffset)*Double((-1.0/displayRange)*scale)+2.0*Double(center.y)), width: 3.0 , height: 3.0) )
            
        }


        return (path)
    }
}
