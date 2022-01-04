//
//  LoadingOverlayView.swift
//  CheapPriceDetector
//
//  Created by Grimm Dániel on 2021. 07. 26..
//

import UIKit

class LoadingOverlayView: UIView {

    override init (frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubViews()
    }
    
    func createSubViews() {
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = center
        addSubview(activityView)
        activityView.startAnimating()
    }
    
}
