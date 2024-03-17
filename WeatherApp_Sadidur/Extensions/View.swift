//
//  View.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable open var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}

// MARK: - IBInspectable
public extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func fadeIn(duration: TimeInterval = 1,
                completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1,
                 completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    func round(corners: UIRectCorner, with radius: CGFloat) {
        let mask = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        clipsToBounds = true
        let shape = CAShapeLayer()
        shape.path = mask.cgPath
        layer.mask = shape
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                installShadow()
            }
        }
    }
    
    func installShadow() {
        layer.shadowRadius = 1
        layer.shadowColor = UIColor(red: 0.549, green: 0.608, blue: 0.647, alpha: 0.2).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1
        layer.masksToBounds = false
//        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
//                                                     y: bounds.maxY - layer.shadowRadius,
//                                                     width: bounds.width,
//                                                     height: layer.shadowRadius)).cgPath
        /*
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowOpacity = 0.45
        layer.masksToBounds = false
        layer.shadowRadius = 2
         */
    }

}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
