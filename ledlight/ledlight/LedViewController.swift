//
//  LedViewController.swift
//  ledlight
//
//  Created by 杨辉 on 16/7/5.
//  Copyright © 2016年 杨辉. All rights reserved.
//

import UIKit

class LedViewController: UIViewController {
    
    var displayText:String? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black();
//        let ledView = LedView(frame: CGRect(x: 30, y: 30, width: 100, height: 50));
        let ledView = LedView();
        if displayText != nil {
            ledView.setDisplayText((self.displayText)!);
        } 
        //设置属性为false，表示这个视图对象需要从代码层级去控制
        ledView.translatesAutoresizingMaskIntoConstraints = false;
        //添加到当前的视图上
        self.view.addSubview(ledView);
        
        //增加水平约束以及垂直约束，使其能够填充整个父视图
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[ledView]-padding-|", options: [], metrics: ["padding":0], views: ["ledView":ledView]));
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[ledView]-padding-|", options: [], metrics: ["padding":0], views: ["ledView":ledView]));
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LedViewController.tapScreen));
        self.view.addGestureRecognizer(tapGesture);
        
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    func tapScreen(){
        print("tapScreen");
        let isHidden = self.navigationController?.isNavigationBarHidden;
        
        if isHidden != nil && isHidden! {
            self.navigationController?.isNavigationBarHidden = false;
        }
        else{
            self.navigationController?.isNavigationBarHidden = true;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default);
        self.navigationController?.navigationBar.shadowImage = UIImage();
//        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default);
        self.navigationController?.navigationBar.shadowImage = nil;
//        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
