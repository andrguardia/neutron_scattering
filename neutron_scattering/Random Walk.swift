//
//  Random Walk.swift
//  neutron_scattering
//
//  Created by IIT Phys 440 on 2/10/23.
//

import SwiftUI
import Foundation

class Random_Walk: ObservableObject {
    @Published var boxHeight: Double = 0.0
    @Published var boxWidth: Double = 0.0
    
    var beamHeight: Double = 0.0
    var energyLossPerCollision: Double = 0.0
    var neutronNumber: Int = 0
    var initialEnergy: Double = 1.0
    var meanFreePath: Double = 1.0
    
    var randTheta: Double = 0.0
    
    var randX: Double = 0.0
    var randY: Double = 0.0
    var leakProbability: Double = 0.0
    
    @Published var insideData = [(xPoint: Double, yPoint: Double)]()
    @Published var outsideData = [(xPoint: Double, yPoint: Double)]()
    @Published var singlePath = [(xPoint: Double, yPoint: Double)]()
    
    
    
    
    func randomize(){
        ///This function randomly populates a random value for theta and from there it uses the mean free path to calculate the new coordinates for x and y in a particle
        randTheta = Double.random(in: 0.0...2.0*Double.pi)
        
        let deltaX = meanFreePath*cos(randTheta)
        let deltaY = meanFreePath*sin(randTheta)
        
        randX = randX + deltaX
        randY = randY + deltaY

    }

    func scatter(){
        ///When called, this function recalculates the remainding energy after a collision as well as randomizes a particle's path
        var remaindingEnergy: Double = initialEnergy
        randX = meanFreePath
        randY = beamHeight
        let lowerEnergyBound = energyLossPerCollision/100.0
        
        while remaindingEnergy > lowerEnergyBound && randY >= 0.0 && randX < boxWidth && randY < boxHeight && randX >= 0.0 {
            remaindingEnergy = remaindingEnergy - energyLossPerCollision/100.0
            
            if neutronNumber==1{
                singlePath.append((randX,randY))
            }else{}
            
            self.randomize()
        }
    }
    
    func randomWalkComputation(){
        ///This function computes the random walk function for the specified number of neutrons, and saves their final position
        ///neutronList is a list made out of tuple objects in the form of [(x Coordinate, y Coordinate)]
        var neutronList: [(Double, Double)] = []
//        var inBoundsList: [(Double, Double)] = []
//        var outBoundsList: [(Double, Double)] = []
        
        for i in 0..<neutronNumber{
            self.scatter()
            neutronList.append((randX, randY))
            
            if neutronList[i].1 > 0.0 && neutronList[i].0 < boxWidth && neutronList[i].1 < boxHeight {
                insideData.append((randX, randY))
            }else{
                outsideData.append((randX, randY))
            }
        }
        
        leakProbability = (Double(outsideData.count)/Double(neutronNumber))*100
    }
    
    
    
    

    
}
