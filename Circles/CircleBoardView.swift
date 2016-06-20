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
    
    var radiusShift:CGFloat {get{ return 30 + CGFloat(arc4random_uniform(5)) }}/*between 10-15*/
    
    //Angle Rotation between each item and next is not perfect equal,slight differnce - 20 degree
    var angleShift :CGFloat{get{return CGFloat(M_PI/8) + CGFloat(arc4random_uniform(UInt32(M_PI/18)))}} /*between 20-25*/
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 0..<100
        {
            let imView = UIImageView(image: UIImage(named:"avatar")!)
            imView.contentMode = UIViewContentMode.ScaleAspectFit
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
        var accumlatedAngle = angleShift
        for subView in self.subviews
        {
            let x = accumlatedRadius * cos(accumlatedAngle) + (self.bounds.width/2.0)
            let y = accumlatedRadius * sin(accumlatedAngle) + (self.bounds.height/2.0)
            
            print("point=  \(x) , \(y)")

            subView.frame = CGRectMake(x, y, 30, 30)
            accumlatedAngle = accumlatedAngle + angleShift
            if accumlatedAngle >= CGFloat(2*M_PI)
            {
                accumlatedAngle = angleShift
                accumlatedRadius += radiusShift
            }
        }
    }
    
    
    
}
