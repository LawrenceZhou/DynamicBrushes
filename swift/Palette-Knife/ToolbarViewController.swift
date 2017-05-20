//
//  ToolbarViewController.swift
//  DynamicBrushes
//
//  Created by JENNIFER MARY JACOBS on 5/18/17.
//  Copyright © 2017 pixelmaid. All rights reserved.
//

import Foundation
import UIKit

class ToolbarViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var layerPanelButton: UIButton!
    @IBOutlet weak var behaviorPanelButton: UIButton!
    
    @IBOutlet weak var eraseButton: UIButton!
    @IBOutlet weak var brushButton: UIButton!
    
    var toolEvent = Event<(String)>();
    var activePanel:String?
    var activeMode:String = "erase";
    
    let eraseHighlight = UIImage(named: "erase_button_active2x")
    let eraseStandard = UIImage(named: "erase_button2x")
    
    let brushHighlight = UIImage(named: "brush_button_active2x")
    let brushStandard = UIImage(named: "brush_button2x")


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        toolEvent.raise(data: ("VIEW_LOADED"));
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 20,y: 20), radius: CGFloat(12), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.blue.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor(colorLiteralRed: 0.85, green: 0.85, blue: 0.85, alpha: 1).cgColor
        //you can change the line width
        shapeLayer.lineWidth = 1.0

        colorPickerButton.layer.addSublayer(shapeLayer)
        
        eraseButton.addTarget(self, action: #selector(ToolbarViewController.eraseToggled), for: .touchUpInside)
        
        brushButton.addTarget(self, action: #selector(ToolbarViewController.brushToggled), for: .touchUpInside)
        
        brushToggled();
    }
    
    func eraseToggled(){
        print("erase toggled",activeMode)
        if activeMode == "brush"{
            print("activemode is brush")
            eraseButton.setImage(eraseHighlight, for: UIControlState.normal)
            brushButton.setImage(brushStandard, for: UIControlState.normal)
            activeMode = "erase"
            toolEvent.raise(data: ("ERASE_MODE"));

        }
        
    }
    
    func brushToggled(){
        print("brush toggled",activeMode)
        if activeMode == "erase"{
            print("activemode is erase")
            eraseButton.setImage(eraseStandard, for: UIControlState.normal)
            brushButton.setImage(brushHighlight, for: UIControlState.normal)
            activeMode = "brush"
            
            toolEvent.raise(data: ("BRUSH_MODE"));

            
        }
        
    }

}