//
//  SelectDateVC.swift
//  CheapPriceDetector
//
//  Created by grimmdaniel on 2021. 07. 24..
//

import UIKit

class SelectDateVC: UIViewController, StoryboardAble {
    
    var selectDateClosure: ((Date) -> Void)?
    var minimumDate: Date!
    
    @IBOutlet weak var datePickerBackgroundView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        datePickerBackgroundView.layer.cornerRadius = 8.0
        setUpDatePicker()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if isBeingDismissed {
            selectDateClosure?(datePicker.date)
        }
    }

    fileprivate func setUpDatePicker() {
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 60, to: Date())!
        datePicker.tintColor = ColorTheme.primaryColor
    }
}

enum DateRequester {
    
    case earliestDate
    case latestDate
    
}
