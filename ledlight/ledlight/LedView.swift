//
//  LedView.swift
//  ledlight
//
//  Created by 杨辉 on 16/7/5.
//  Copyright © 2016年 杨辉. All rights reserved.
//

import UIKit

class LedView: UIView {
    
    let radius = 16;
    let halfRadius = 8;
    var ledColor = UIColor.white();
    var bgColor = UIColor.black();
    var circularPos:[CGPoint]? = nil;
    var xPoints = 0;
    var yPoints = 0;

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame:CGRect){
        super.init(frame: frame);
        
//        print(frame);
        let mainScreenRect = UIScreen.main().bounds;
        print(mainScreenRect);
        
        xPoints = Int(mainScreenRect.width / CGFloat(radius * 2));
        yPoints = Int(mainScreenRect.height / CGFloat(radius * 2));
        
        let startPoint = CGPoint(x: 16, y: 16);
        circularPos = [CGPoint]();
        
        for i in 0...yPoints {
            for j in 0...xPoints {
                let curPoint = CGPoint(x: Int(startPoint.x + CGFloat(j * radius * 2)), y: Int(startPoint.y + CGFloat(i * radius * 2)));
                circularPos?.append(curPoint);
            }
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect);
        print("ledView draw \(rect)");
        
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(bgColor.cgColor);
        context?.fill(rect);
        
        context?.setFillColor(ledColor.cgColor);
        for curPos in circularPos! {
            context?.fillEllipse(in: CGRect(x: Int(curPos.x - CGFloat(halfRadius)), y: Int(curPos.y - CGFloat(halfRadius)), width: 16, height: 16));
        }
    }
}
