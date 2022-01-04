//
//  Extensions.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 07. 26..
//

import UIKit

extension UIViewController {
    
    func addLoadingOverlay() {
        let overlay: UIView = LoadingOverlayView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(overlay)
    }
    
    func removeLoadingOverlay() {
        for subview in self.view.subviews where subview is LoadingOverlayView {
            subview.removeFromSuperview()
        }
    }
    
    func showErrorPopUp(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
