//
//  Bubble.swift
//  14358081_Bubblepop
//
//  Created by Cube on 4/3/23.
//

import Foundation
import UIKit

class Bubble: UIButton {
    
    var bubbleValue: Double = 0
    // Bubble Colors: Red Pink Green Blue Black
    // Probaility   : 40  30   15    10   5
    
    //X and Y co-ordinate positions for the geneated bubbles
    let xPosition = Int.random(in: 20...400)
    let yPosition = Int.random(in: 20...800)
    
    //Custom color declaration for Pink
    let colorPink = UIColor(red: CGFloat(0.89), green: CGFloat(0.23), blue: CGFloat(0.58), alpha: 1.00)
    
    //Probability ranges for each bubble type
    let redRange = 0...40
    let pinkRange = 41...70
    let greenRange = 71...85
    let blueRange = 86...95
    let blackRange = 96...100
    
    //Bubble radius value derived from calucations
    var bubbleRadius = UInt32(UIScreen.main.bounds.width / 15)
    
    //Constructor for Bubble Class
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.frame = CGRect(x: xPosition, y: yPosition, width: 50, height: 50)
        self.layer.cornerRadius = CGFloat(bubbleRadius)
        //generating a number that denotes the type of bubble appearnce probability
        let appearanceProbability = Int(arc4random_uniform(101))
        //all ranges are checked to see if the appearanceProbability is contained within any
        //based on the range, the corresponding color and value is set to the bubble instance
        if(redRange.contains(appearanceProbability)){
            self.backgroundColor = .red
            self.bubbleValue = 1
        }
        if(pinkRange.contains(appearanceProbability)){
            self.backgroundColor = colorPink
            self.bubbleValue = 2
        }
        if(greenRange.contains(appearanceProbability)){
            self.backgroundColor = .systemGreen
            self.bubbleValue = 5
        }
        if(blueRange.contains(appearanceProbability)){
            self.backgroundColor = .blue
            self.bubbleValue = 8
        }
        if(blackRange.contains(appearanceProbability)){
            self.backgroundColor = .black
            self.bubbleValue = 10
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Function for the necessary animations when generating a bubble
    func animation(){
        let springAnimation = CASpringAnimation(keyPath: "transform.scale")
        springAnimation.duration = 0.6
        springAnimation.fromValue = 1
        springAnimation.toValue = 0.8
        springAnimation.repeatCount = 1
        springAnimation.initialVelocity = 0.5
        springAnimation.damping = 1
        
        layer.add(springAnimation, forKey: nil)
    }
    
    //Function for enabling bubbles to flash before disappearing
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
}
