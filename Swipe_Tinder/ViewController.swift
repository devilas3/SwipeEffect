//
//  ViewController.swift
//  Swipe_Tinder
//
//  Created by Suraj Sonawane on 14/06/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class ViewController: UIViewController {

    
    var imageNameArray : [String] = ["photo.jpg","photo1.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
        
        self.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func reloadData(){
        
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blue
        options.nopeText = "Delete"
        options.nopeColor = UIColor.red
        options.onPan = { state -> Void in
            if state?.thresholdRatio == 1 && state?.direction == .left {
                print("Photo deleted!")
            }
            else if state?.thresholdRatio == 1 && state?.direction == .right {
                print("Photo accepted!")
            }
        }
        
        for ind in 0...self.imageNameArray.count-1{
            let view = MDCSwipeToChooseView(frame: self.view.bounds, options: options)
            view?.imageView.image = UIImage(named: self.imageNameArray[ind])
            view?.frame = CGRect(x: 10, y: 10, width: (view?.frame.size.width)!-20, height: (view?.frame.size.height)!/2)
            self.view.addSubview(view!)
        }

    }

    @IBAction func btnReloadImages(_ sender: Any) {
        self.reloadData()
    }
}


extension ViewController: MDCSwipeToChooseDelegate {
    
    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void{
        print("Couldn't decide, huh?")
    }
    
    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(_ view: UIView, shouldBeChosenWith: MDCSwipeDirection) -> Bool {
        if shouldBeChosenWith == .left {
            return true
        }else if shouldBeChosenWith == .right {
            return true
        } else {
            // Snap the view back and cancel the choice.
            UIView.animate(withDuration: 0.16, animations: { () -> Void in
                view.transform = CGAffineTransform.identity
                view.center = view.superview!.center
            })
            return false
        }
    }
    
    // This is called when a user swipes the view fully left or right.
    func view(_ view: UIView, wasChosenWith: MDCSwipeDirection) -> Void {
        if wasChosenWith == .left {
            print("Photo deleted!")
        }else if wasChosenWith == .right {
            print("Photo accepted!")
        } else {
            print("Photo saved!")
        }
    }
}
