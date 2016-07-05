//
//  ViewController.swift
//  ledlight
//
//  Created by 杨辉 on 16/7/5.
//  Copyright © 2016年 杨辉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mLedText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickSure(_ sender: AnyObject) {
        let content = mLedText.text;
        
        if content?.characters.count == 0 || content == nil {
            let alert = UIAlertController(title: "提示", message: "没有输入显示的文字", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            return;
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let ledViewController = mainStoryboard.instantiateViewController(withIdentifier: "ledVC");
        self.navigationController?.pushViewController(ledViewController, animated: true);
    }

    @IBAction func onTextDone(_ sender: AnyObject) {
        print("onTextDone");
    }
}

