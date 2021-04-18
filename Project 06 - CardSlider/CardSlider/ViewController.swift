//
//  ViewController.swift
//  CardSlider
//
//  Created by SaJesh Shrestha on 4/18/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var resetBtn: UIButton!
    
    var divisior: CGFloat!
    
    
    //MARK:- ViewCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        divisior = (view.frame.width/2)/0.61
        configureCardView()
        configureInsideView()
        panGestures()
    }
    
    
    //MARK:- Configuration Functions
    fileprivate func configureCardView() {
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
    }
    
    fileprivate func configureInsideView() {
        insideView.layer.cornerRadius = 16
        insideView.layer.masksToBounds = true
    }
    
    fileprivate func panGestures() {
        let cardViewPan = UIPanGestureRecognizer(target: self, action: #selector(cardViewHandlePan))
        cardView.addGestureRecognizer(cardViewPan)
    }
    
    fileprivate func resetCardView() {
        UIView.animate(withDuration: 0.2) {
            self.cardView.center = self.view.center
            self.cardView.alpha = 1
            self.cardView.transform = .identity
            self.insideView.alpha = 0
        }
    }
    
    @IBAction func resetBtnPressed(_ sender: UIButton) {
        resetCardView()
    }
    
    //MARK:- ObjC Helpers
    @objc
    func cardViewHandlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let xFromCenter = cardView.center.x - view.center.x
        let xPercent = view.frame.width * 75 / 100
        
        cardView.center = CGPoint(x: view.center.x + translation.x, y: view.center.y)
        cardView.transform = CGAffineTransform(rotationAngle: xFromCenter/divisior)

        if xFromCenter > 0 {
            insideView.backgroundColor = .green
            cardView.alpha = 1 - abs(xFromCenter) /  view.center.x
        } else {
            insideView.backgroundColor = .red
            cardView.alpha = 1 - abs(xFromCenter) /  view.center.x
        }
        insideView.alpha = abs(xFromCenter) /  view.center.x

        if sender.state == .ended {
            if cardView.center.x > xPercent  {
                UIView.animate(withDuration: 0.2) {
                    self.cardView.center = CGPoint(x: self.cardView.center.x + 200,
                                                   y: self.cardView.center.y + 75)
                    self.cardView.alpha = 0
                }
            } else if cardView.center.x < (view.frame.width - xPercent) {
                UIView.animate(withDuration: 0.2) {
                    self.cardView.center = CGPoint(x: self.cardView.center.x - 200,
                                                   y: self.cardView.center.y + 75)
                    self.cardView.alpha = 0
                }
            } else { resetCardView() }
        }
    }

}

