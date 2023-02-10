//
//  Random Walk.swift
//  neutron_scattering
//
//  Created by IIT Phys 440 on 2/10/23.
//

import SwiftUI
import Foundation

class Random_Walk: NSObject {
    var boxHeight: Double = 0.0
    var boxWidth: Double = 0.0
    var beamHeight: Double = 0.0
    var energyLossPerCollision: Double = 0.0
    var neutronNumber: Int = 0
    var initialEnergy: Double = 1.0
    var meanFreePath: Double = 1.0
    
    var randTheta: Double = 0.0
    var randX: Double = 0.0
    var randY: Double = 0.0
    
    
    
    func randomize(){
        ///This function randomly populates a random value for theta and from there it uses the mean free path to calculate the new coordinates for x and y in a particle
        randTheta = Double.random(in: 0...2*Double.pi)
        randX = randX + meanFreePath*cos(randTheta)
        randY = randY + meanFreePath*sin(randTheta)
    }

    func scatter(){
        ///When called, this function recalculates the remainding energy after a collision as well as randomizes a particle's path
        var remaindingEnergy: Double = initialEnergy
        
        while remaindingEnergy > 0 {
            remaindingEnergy = remaindingEnergy - energyLossPerCollision/100
            self.randomize()
        }
    }
    
    func randomWalkComputation(){
        ///This function computes the random walk function for the specified number of neutrons, and saves their final position
        ///neutronList is a list made out of tuple objects in the form of [(x Coordinate, y Coordinate)]
        var neutronList: [(Double, Double)] = []
        
        for _ in 0..<neutronNumber{
            self.scatter()
            neutronList.append((randX, randY))
        }
        print(neutronList)
    }
    
    
    
    

    
}
