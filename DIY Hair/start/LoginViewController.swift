//
//  LoginViewController.swift
//  myfistlib
//
//  Created by student on 2018/12/23.
//  Copyright © 2018年 蒋宇童. All rights reserved.
//

import UIKit
import LeanCloud
class LoginViewController: UIViewController, UITextFieldDelegate{
    
    var btn: DKTransitionButton!
    // @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var goLB: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var imgview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        passwordTF.delegate=self
        userTF.delegate=self
        passwordTF.returnKeyType = UIReturnKeyType.done
        userTF.returnKeyType = UIReturnKeyType.done
        btn = DKTransitionButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 100, height: 44))
        btn.backgroundColor = UIColor(red: 1, green: 0, blue: 128.0 / 255.0, alpha: 0.6)
        btn.center = self.view.center
        btn.frame.bottom = self.view.frame.height - 100
        btn.setTitle("Sign in", for: [])
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 14)
        btn.addTarget(self, action: #selector(onTapButton(_:)), for: UIControlEvents.touchUpInside)
      //  btn.addTarget(self, action: #selector(onTapButton(_:)), for: UIControl.Event.touchUpInside)
        btn.spiner.spinnerColor = UIColor.white
        textFieldShouldReturn(passwordTF)
        textFieldShouldReturn(userTF)
        
        let filter = UIView()
        
        filter.frame = self.view.frame
        
        filter.backgroundColor = UIColor.black
        filter.alpha = 0.2
        view.addSubview(filter)
        self.view.bringSubview(toFront: myview)
        self.view.addSubview(btn)
        imgview.image=UIImage(named: "login3")
        userTF.alpha=0.5
        passwordTF.alpha=0.5
        goLB.alpha=0.5
        //btn2.layer.cornerRadius=10
        passwordTF.isSecureTextEntry=true
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    /*   @IBAction func isLogin(_ sender: UIButton) {
     if passwordTF.text=="admin"&&userTF.text=="admin" as String as String
     {
     self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
     }
     }*/
    @IBAction func onTapButton(_ button: DKTransitionButton) {
        
        // 开始加载动画
        button.startLoadingAnimation()
//        let query = LCQuery(className: "Todo")
//        if passwordTF.text != ""&&userTF.text != ""{
//            // 成功，进行界面切换
//            let username=userTF.text!
//            query.whereKey("username", .equalTo(username))
//        } else {
//            // 失败返回并提示
//            button.startShakeAnimation(1, completion: {
//                // 提示登录失败
//                print("badend")
//            })
//        }
      
    
        
        LCUser.logIn(username: userTF.text!, password: passwordTF.text!) { result in
            switch result {
            case .success(let user):
                button.startSwitchAnimation(1, completion: { [unowned self]() -> () in
                    self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
                })
               
                break
            case .failure(let error):
               
                button.startShakeAnimation(1, completion: {
                    // 提示登录失败
                    print("badend")
                })
                print(error)
            }
        }


//        if passwordTF.text=="admin"&&userTF.text=="admin" as String as String {
//            // 成功，进行界面切换
//            button.startSwitchAnimation(1, completion: { [unowned self]() -> () in
//                self.performSegue(withIdentifier: "LoginSuccess", sender: nil)
//            })
//
//
//        } else {
//            // 失败返回并提示
//
//
//            button.startShakeAnimation(1, completion: {
//                // 提示登录失败
//                print("badend")
//            })
//        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

