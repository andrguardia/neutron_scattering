//
//  DrawingView.swift
//  Valentine's Day
//
//  Created by Jeff Terry on 12/31/20.
//

import SwiftUI

struct drawingView: View {
    
    @Binding var redLayer : [(xPoint: Double, yPoint: Double)]
    @Binding var blueLayer : [(xPoint: Double, yPoint: Double)]
    
    var body: some View {
    
        
        ZStack{
        
            drawIntegral(drawingPoints: redLayer )
                .stroke(Color.red)
            
            drawIntegral(drawingPoints: blueLayer )
                .stroke(Color.black)
        }
        .background(Color.white)
        .aspectRatio(1, contentMode: .fill)
        
    }
}

struct DrawingView_Previews: PreviewProvider {
    
    @State static var redLayer : [(xPoint: Double, yPoint: Double)] = [(10, 100), (10, 100), (0.0, 0.0), (0.0, 1.0)]
    @State static var blueLayer : [(xPoint: Double, yPoint: Double)] = [(10, 150), (2, 200), (1, 0.0)]
    
    static var previews: some View {
       
        
        drawingView(redLayer: $redLayer, blueLayer: $blueLayer)
            .aspectRatio(1, contentMode: .fill)
           
    }
}



struct drawIntegral: Shape {
    
   
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
            
            let myX = (item.xPoint-negativexOffset)*Double(scale)/displayRange
            let myY = ((item.yPoint-negativeyOffset)*Double((-1.0/displayRange)*scale)+2.0*Double(center.y))
            
            path.addRect(CGRect(x: myX, y: myY, width: 1.0 , height: 1.0) )
            
        }


        return (path)
    }
}
