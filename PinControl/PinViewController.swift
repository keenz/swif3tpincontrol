//
//  PinViewController.swift
//  AnswerMe
//
//  Created by Anton Mac on 07.01.17.
//  Copyright © 2017 Anton Mac. All rights reserved.
//

import UIKit
import AudioToolbox

class PinViewController: UIViewController {
    
    struct Colors {
        static let DefaultColor = UIColor.white.cgColor
        static let ErrorColor = UIColor.red.cgColor
    }
    
    struct Strings {
        static let EnterYourPin = "Enter Your PIN"
    }
    
    struct CircleDefaults {
        static let AnumationInterval = 0.15
        static let ShakeDuration = 0.05
        static let XAnumationOffset = CGFloat(5)
        static let YPosOffeset = 40.0
        static let XPosOffset = 25
        static let Radius = 5.0
        static let LineWidth = 1.0
    }
    
    @IBOutlet weak var textLabel: UILabel!
    
    private var _circle1: CAShapeLayer!
    private var _circle2: CAShapeLayer!
    private var _circle3: CAShapeLayer!
    private var _circle4: CAShapeLayer!
    
    private var _numbers: [Int] = []
    
    private let _correctPin = 1234
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = Strings.EnterYourPin
        
        _circle1 = drawCircle(offset: -(CircleDefaults.XPosOffset * 3))
        _circle2 = drawCircle(offset: -(CircleDefaults.XPosOffset))
        _circle3 = drawCircle(offset: CircleDefaults.XPosOffset)
        _circle4 = drawCircle(offset: CircleDefaults.XPosOffset * 3)
    }
    
    private func drawCircle(offset: Int) -> CAShapeLayer
    {
        let y = textLabel.frame.origin.y + CGFloat(CircleDefaults.YPosOffeset)
        let x = view.frame.width/2.0 + CGFloat(offset)
        
        let centerPoint = CGPoint(x: x, y: y)
        
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: CGFloat(CircleDefaults.Radius), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = Colors.DefaultColor
        shapeLayer.lineWidth = CGFloat(CircleDefaults.LineWidth)
        view.layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
    func showError()
    {
        _circle1.fillColor = Colors.ErrorColor
        _circle1.strokeColor = Colors.ErrorColor
        
        _circle2.fillColor = Colors.ErrorColor
        _circle2.strokeColor = Colors.ErrorColor
        
        _circle3.fillColor = Colors.ErrorColor
        _circle3.strokeColor = Colors.ErrorColor
        
        _circle4.fillColor = Colors.ErrorColor
        _circle4.strokeColor = Colors.ErrorColor
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        UIView.animate(
            withDuration: CircleDefaults.ShakeDuration,
            animations: {
                self.textLabel.transform = self.textLabel.transform.translatedBy(x: -CircleDefaults.XAnumationOffset, y: 0.0)
        },
            completion: { finished in
                if finished {
                    UIView.animate(
                        withDuration: CircleDefaults.ShakeDuration,
                        animations: {
                            self.textLabel.transform = self.textLabel.transform.translatedBy(x: CircleDefaults.XAnumationOffset, y: 0.0)
                    },
                        completion: { finished in
                            if finished {
                                UIView.animate(
                                    withDuration: CircleDefaults.ShakeDuration,
                                    animations: {
                                        self.textLabel.transform = self.textLabel.transform.translatedBy(x: -CircleDefaults.XAnumationOffset, y: 0.0)
                                },
                                    completion: { finished in
                                        if finished {
                                            UIView.animate(
                                                withDuration: CircleDefaults.ShakeDuration,
                                                animations: {
                                                    self.textLabel.transform = self.textLabel.transform.translatedBy(x: CircleDefaults.XAnumationOffset, y: 0.0)
                                            },
                                                completion: { finished in
                                                    if finished {
                                                        UIView.animate(
                                                            withDuration: CircleDefaults.ShakeDuration,
                                                            animations: {
                                                                self.textLabel.transform = self.textLabel.transform.translatedBy(x: -CircleDefaults.XAnumationOffset, y: 0.0)
                                                        },
                                                            completion: { finished in
                                                                if finished {
                                                                    UIView.animate(
                                                                        withDuration: CircleDefaults.ShakeDuration,
                                                                        animations: {
                                                                            self.textLabel.transform = self.textLabel.transform.translatedBy(x: CircleDefaults.XAnumationOffset, y: 0.0)
                                                                    },
                                                                        completion: { finished in
                                                                            if finished {
                                                                                
                                                                            }
                                                                    }
                                                                    )
                                                                }
                                                        }
                                                        )
                                                    }
                                            }
                                            )
                                        }
                                }
                                )
                            }
                    }
                    )
                }
        }
        )
        
        Timer.scheduledTimer(
            timeInterval: CircleDefaults.AnumationInterval,
            target: self, selector: #selector(PinViewController.clearCircles),
            userInfo: nil,
            repeats: false
        )
    }
    
    func clearCircles()
    {
        _circle1.fillColor = UIColor.clear.cgColor
        _circle2.fillColor = UIColor.clear.cgColor
        _circle3.fillColor = UIColor.clear.cgColor
        _circle4.fillColor = UIColor.clear.cgColor
        
        _circle1.strokeColor = Colors.DefaultColor
        _circle2.strokeColor = Colors.DefaultColor
        _circle3.strokeColor = Colors.DefaultColor
        _circle4.strokeColor = Colors.DefaultColor
        
        _numbers.removeAll()
    }
    
    private func comparePins() -> Bool
    {
        let pin = _numbers[0] * 1000 + _numbers[1] * 100 + _numbers[2] * 10 + _numbers[3]
        
        return pin == _correctPin
    }
    
    @IBAction func numberTouched(_ sender: UIButton)
    {
        if (_numbers.count == 0)
        {
            _circle1.fillColor = Colors.DefaultColor
        }
        else if (_numbers.count == 1)
        {
            _circle2.fillColor = Colors.DefaultColor
        }
        else if (_numbers.count == 2)
        {
            _circle3.fillColor = Colors.DefaultColor
        }
        else if (_numbers.count == 3)
        {
            _circle4.fillColor = Colors.DefaultColor
            
        }
        else if (_numbers.count >= 4)
        {
            return
        }
        
        if let numberString = sender.currentTitle
        {
            if let number = Int(numberString)
            {
                _numbers.append(number)
            }
        }
        
        if _numbers.count == 4
        {
            if (comparePins())
            {
                
            }
            else
            {
                Timer.scheduledTimer(
                    timeInterval: CircleDefaults.AnumationInterval,
                    target: self, selector: #selector(PinViewController.showError),
                    userInfo: nil,
                    repeats: false
                )
            }
        }
        
    }
    
    /*
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
