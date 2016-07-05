//
//  LedViewController.swift
//  ledlight
//
//  Created by 杨辉 on 16/7/5.
//  Copyright © 2016年 杨辉. All rights reserved.
//

import UIKit

class LedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black();
//        let ledView = LedView(frame: CGRect(x: 30, y: 30, width: 100, height: 50));
        let ledView = LedView();
        ledView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(ledView);
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[ledView]-padding-|", options: [], metrics: ["padding":0], views: ["ledView":ledView]));
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[ledView]-padding-|", options: [], metrics: ["padding":0], views: ["ledView":ledView]));
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default);
        self.navigationController?.navigationBar.shadowImage = UIImage();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default);
        self.navigationController?.navigationBar.shadowImage = nil;
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
