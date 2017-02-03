//
//  CircleBoardView.swift
//  Circles
//
//  Created by MohamedDiaa on 6/21/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit

class CircleBoardView: UIView {

    //Concentric Circle
    //Radius - fixed difference between each circle radius 
    // Number of items on circle circumfrance is proportional to its Radius
    //Size and obacity can differ slightly between items
    
    var radiusShift:CGFloat {get{ return 30 //+ CGFloat(arc4random_uniform(5))
                                    }}/*between 10-15*/

    //var radiusShift:CGFloat {get{ return 30 + CGFloat(arc4random_uniform(5)) }}/*between 10-15*/
    
    //Angle Rotation between each item and next is not perfect equal,slight differnce - 20 degree
   // var angleShift :CGFloat{get{return CGFloat(M_PI/4) + CGFloat(arc4random_uniform(UInt32(M_PI/18)))}} /*between 20-25*/
    
    let itemRadius:CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 0..<50
        {
            let imView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            imView.image = UIImage(named:"avatar")
            imView.contentMode = UIViewContentMode.scaleAspectFit
            imView.layer.borderColor =  UIColor.lightGray.cgColor
            imView.layer.borderWidth = 1.0
            imView.layer.cornerRadius = imView.bounds.width/2.0
            imView.layer.masksToBounds = true
            self.addSubview(imView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Starting with inner radius , fill it then increment it
        var accumlatedRadius = radiusShift
        var accumlatedAngle:CGFloat = 0
        for subView in self.subviews
        {
            //let circlesPerRadius = CGFloat(2*M_PI*Double(accumlatedRadius)) / (itemRadius + 5)
            let angle = (12*itemRadius + 5)/CGFloat(2*M_PI*Double(accumlatedRadius))
            
            let x = accumlatedRadius * cos(accumlatedAngle) + (self.bounds.width/2.0)
            let y = accumlatedRadius * sin(accumlatedAngle) + (self.bounds.height/2.0)
            
            print("point=  \(x) , \(y)")

            subView.frame = CGRect(x: x, y: y, width: itemRadius, height: itemRadius)
            //accumlatedAngle = accumlatedAngle + angleShift
            accumlatedAngle = accumlatedAngle + angle

            if CGFloat(accumlatedAngle) >= CGFloat(2*M_PI)
            {
                accumlatedAngle = 0
                accumlatedRadius += radiusShift
            }
        }
    }
    
    func animateWave()
    {
        var circlesItems = [NSRange]()
        var lastRadius:CGFloat = 0
        var startIndex:Int? = 0
        
        //Sort items into ranges for each circle
        for (index,subView) in self.subviews.enumerated()
        {
            //let angle =  subView.frame.origin.x
            let originalX =  subView.frame.origin.x - (self.bounds.width/2.0)
            let originalY = subView.frame.origin.y  - (self.bounds.width/2.0)
            let radius = sqrt( (originalX)*(originalX) + (originalY)*(originalY))
            print("radius= \(radius)")
            if lastRadius == 0
            {
                lastRadius = radius
            }
            if lastRadius != radius
            {
                if let start = startIndex
                {
                    circlesItems.append(NSMakeRange(start, index-start))
                    startIndex = nil
                }
                else
                {
                    startIndex = index
                }
            }
        }
        
        self.animateArray(circlesItems)
    
    }
    
    func animateArray(_ circles:[NSRange])
    {
        print(circles.count)
        
        var circles = circles
        if circles.isEmpty
        {
            return
        }

        let range = circles.removeFirst()
        UIView.animate(withDuration: 0.5, delay: 0.1, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            
                for i in (range.location)..<(range.location+range.length)
                {
                    let subView = self.subviews[i]
                    subView.frame = subView.frame.insetBy(dx: subView.frame.width, dy: subView.frame.height)
                    subView.contentMode = UIViewContentMode.scaleToFill
                }
            
            }) { (success) in
                
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { 
                    
                    for i in (range.location)..<(range.location+range.length)
                    {
                        let subView = self.subviews[i]
                        subView.frame = subView.frame.insetBy(dx: -subView.frame.width, dy: -subView.frame.height)
                        subView.contentMode = UIViewContentMode.scaleAspectFit
                    }

                    }, completion: { (success) in
                        
                        self.animateArray(circles)
                       // self.performSelector(#selector(CircleBoardView.animateArray), withObject: circles, afterDelay: 1)
                })
            }
        }
    
    
}
