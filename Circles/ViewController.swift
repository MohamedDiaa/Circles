//
//  ViewController.swift
//  Circles
//
//  Created by MohamedDiaa on 6/21/16.
//  Copyright © 2016 MohamedDiaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let circleView = CircleBoardView(frame: CGRect.zero)
        
        let c1 = NSLayoutConstraint(item: self.view, attribute: .leading, relatedBy: .equal, toItem: circleView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let c2 = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: circleView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let c3 = NSLayoutConstraint(item: self.view, attribute: .top, relatedBy: .equal, toItem: circleView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let c4 = NSLayoutConstraint(item: self.view, attribute: .bottom, relatedBy: .equal, toItem: circleView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    
        circleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(circleView)
        self.view.addConstraints([c1,c2,c3,c4])
        
        
    //circleView.performSelector(#selector(CircleBoardView.animateWave), withObject: nil, afterDelay: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

