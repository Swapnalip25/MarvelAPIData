//
//  ActivityIndicator.swift
//  MarvelData
//
//  Created by Swapnali Patil on 01/05/22.
//

import Foundation
import UIKit

class ActivityIndicator {
    static func activityStartAnimating() {
        if let window  =  UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let indicatorView = UIView()
            indicatorView.backgroundColor = UIColor.clear
            indicatorView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height)
            indicatorView.tag = 789789
            let activityIndicator =  UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            activityIndicator.center = window.center
            activityIndicator.color = .darkGray
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            indicatorView.addSubview(activityIndicator)
            window.viewWithTag(789789)?.removeFromSuperview()
            window.addSubview(indicatorView)
        }
    }
    
    static func activityIndicator() -> UIActivityIndicatorView {
        let activityIndicator =  UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    static func activityStopAnimating() {
        if let window  =  UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            window.viewWithTag(789789)?.removeFromSuperview()
        }
    }
}
