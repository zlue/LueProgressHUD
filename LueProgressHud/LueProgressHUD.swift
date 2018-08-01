//
//  LueProgressHUD.swift
//  LueProgressHud
//
//  Created by Mac on 2018/7/6.
//  Copyright © 2018年 lue. All rights reserved.
//

import UIKit

extension UIResponder {
    func showMessage(_ text: String?) {
        LueHUD.showMessage(text ?? "")
    }
}
class LueHUD: NSObject {
    static var windows: [UIWindow] = []
    static var loadingWindow: UIWindow?
    
    static func clearAllHUD() {
        self.cancelPreviousPerformRequests(withTarget: self)
        windows.removeAll(keepingCapacity: false)
        hideLoad()
    }
    static func showLoading() {
        if loadingWindow != nil {
            return
        }
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activity.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activity.backgroundColor = UIColor.blue
        activity.layer.cornerRadius = 8
        activity.startAnimating()
        
        let window = getWindow(frame: UIScreen.main.bounds)
        
        window.addSubview(activity)
        var center = window.center
        center.y -= 120
        activity.center = center
        
        loadingWindow = window
    }
    static func hideLoad() {
        if let window = loadingWindow {
            clearHUD(window)
        }
        loadingWindow = nil
    }
    
    static func showMessage(_ text: String, afterDelayClear: Double = 2) {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 100, height: CGFloat.greatestFiniteMagnitude))
        
        let view = getContentView(frame: CGRect(x: 0, y: 0, width: size.width + 20, height: size.height + 20))
        view.addSubview(label)
        label.frame = CGRect(origin: CGPoint.zero, size: size)
        label.center = view.center
        
        let window = getWindow(frame: view.bounds)
        window.addSubview(view)
        
        self.perform(#selector(clearHUD(_:)), with: window, afterDelay: afterDelayClear)
    }
    @objc static private func clearHUD(_ sender: UIWindow) {
        UIView.animate(withDuration: 0.16, animations: {
            sender.alpha = 0
        }) { (_) in
            if let index = windows.index(of: sender) {
                windows.remove(at: index)
            }
        }
    }
    static private func getContentView(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 4
        return view
    }
    static private func getWindow(frame: CGRect) -> UIWindow {
        let window = UIWindow(frame: frame)
        window.windowLevel = UIWindowLevelAlert
        window.backgroundColor = .clear
        window.isHidden = false
        if let center = UIApplication.shared.delegate?.window??.center {
            window.center = center
        }
        windows.append(window)
        return window
    }
}
