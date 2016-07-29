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
    var ledLightColor = UIColor.green();
    var bgColor = UIColor.black();
    var circularPos:[CGPoint]? = nil;
    var xPoints = 0;
    var yPoints = 0;
    var shortPoint:Int{
        get{
            if xPoints > yPoints {
                return yPoints;
            }
            else{
                return xPoints;
            }
        }
    }
    
    var longPoint:Int{
        get{
            if xPoints > yPoints {
                return xPoints;
            }
            else{
                return yPoints;
            }
        }
    }
    
    var imgShowData:[[UInt8]]? = nil;

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
        
        for i in 0..<yPoints {
            for j in 0..<xPoints {
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
        
        var curPos = 0;
        if let showData = imgShowData {
            let height = showData.count;
            let width = showData[0].count;
            
            print("height = \(height), width = \(width)");
            
            for curPoint in circularPos! {
            
                let yPos = Int(curPos / xPoints);
                let xPos = Int(curPos % xPoints);
                
//                print("yPos = \(yPos), xPos = \(xPos)");
                
                if yPos >= height || xPos >= width {
                    context?.setFillColor(ledColor.cgColor);
                    context?.fillEllipse(in: CGRect(x: Int(curPoint.x - CGFloat(halfRadius)), y: Int(curPoint.y - CGFloat(halfRadius)), width: 16, height: 16));
                }
                else{
                    print("imgShowData[\(yPos)][\(xPos)] = \(imgShowData?[yPos][xPos])");
                    if imgShowData?[yPos][xPos] < 128 {
                        context?.setFillColor(ledLightColor.cgColor);
                        context?.fillEllipse(in: CGRect(x: Int(curPoint.x - CGFloat(halfRadius)), y: Int(curPoint.y - CGFloat(halfRadius)), width: 16, height: 16));
                    }
                    else{
                        context?.setFillColor(ledColor.cgColor);
                        context?.fillEllipse(in: CGRect(x: Int(curPoint.x - CGFloat(halfRadius)), y: Int(curPoint.y - CGFloat(halfRadius)), width: 16, height: 16));
                    }
                }
                
                curPos += 1;
            }
        }
        else{
            for curPoint in circularPos! {
                
//                let yPos = Int(curPos / xPoints);
//                let xPos = Int(curPos % xPoints);
//                
//                print("yPos = \(yPos), xPos = \(xPos)");
                
                context?.setFillColor(ledColor.cgColor);
                context?.fillEllipse(in: CGRect(x: Int(curPoint.x - CGFloat(halfRadius)), y: Int(curPoint.y - CGFloat(halfRadius)), width: 16, height: 16));
                
                curPos += 1;
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError: NSError?,contextInfo: AnyObject)
    {
        if didFinishSavingWithError != nil
        {
            print("error!")
            return
        }
        
        print("image was saved")
    }
    
    func image(Image image:UIImage?, didFinishSave error:NSError?, ContextInfo contextInfo:Void?){
        var msg:NSString? = nil;
        
        if error != nil {
            msg = "保存图片失败";
        }
        else{
            msg = "保存图片成功";
        }
        
        print(msg);
    }
    
    func setDisplayText(_ displayText:NSString){
        let screenBound = UIScreen.main().bounds;
        var drawRect:CGRect? = nil;
        
        
//        if screenBound.width > screenBound.height {
//            drawRect = CGRect(x: 0, y: 0, width: longPoint, height: shortPoint);
//        }
//        else{
//            drawRect = CGRect(x: 0, y: 0, width: shortPoint, height: longPoint);
//        }
        drawRect = CGRect(x: 0, y: 0, width: shortPoint * (displayText.length), height: shortPoint);
        
        UIGraphicsBeginImageContext((drawRect?.size)!);
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(UIColor.white().cgColor);
        context?.fill(drawRect!);
        
        context?.setFillColor(UIColor.black().cgColor);
        context?.setStrokeColor(UIColor.black().cgColor);
        let font = UIFont.systemFont(ofSize: CGFloat(shortPoint));
        displayText.draw(in: drawRect!, withAttributes: font.fontDescriptor().fontAttributes());
        var newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        print("newImage size is \(newImage?.size)");
        
//        UIImageWriteToSavedPhotosAlbum(newImage!, self, "image:didFinishSavingWithError:contextInfo:", nil);
        UIImageWriteToSavedPhotosAlbum(newImage!, nil, nil, nil);
        
//        let imageHelper = ImageHelper();
        imgShowData = [[UInt8]]();
        var bytePerRow:Int32 = 0;
        let imageData = ImageHelper.convertUIImage(toBitmapRGBA8: newImage, bytePerRow: &bytePerRow);
        let count = Int((newImage?.size.width)! * (newImage?.size.height)!);
        print("xPoints = \(xPoints)");
        print("yPoints = \(yPoints)");
        print("count = \(count)");
        var curPos = 0;
        var pointPerRow = Int(bytePerRow / 4);
//        var curShowData = Array<UInt8>(repeating:0, count:Int(bytePerRow));
        var curShowData = [UInt8]();
        var j = 0;
        for i in 0..<count {
            let r:UInt8 = (imageData?[i * 4])!;
            let g:UInt8 = (imageData?[i * 4 + 1])!;
            let b:UInt8 = (imageData?[i * 4 + 2])!;
            let a:UInt8 = (imageData?[i * 4 + 3])!;
            
            let tempR = CGFloat(r) * 0.299;
            let tempG = CGFloat(g) * 0.587;
            let tempB = CGFloat(b) * 0.114;
            let gray:UInt8 = UInt8(tempR + tempG + tempB);
            
            curShowData.append(gray);
            
            if Int(curShowData.count) == pointPerRow {
                imgShowData?.append(curShowData);
                curShowData = [UInt8]();
//                curShowData = Array<UInt8>(repeating:0, count:Int(bytePerRow));
                print(j += 1);
            }
        }
        
        print(imgShowData);
    }
}
