//
//  ViewController.swift
//  PetReminders
//
//  Created by Mac Mini on 24/03/2021.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var addToScheduleButton: UIButton!
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var roundNameTF: UITextField!
    @IBOutlet weak var startTimeTF: DateTextField!
    
    var datePicker: UIDatePicker!
    var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = createDatePickerView()
        toolbar = createAccessoryToolBar()
        
        startTimeTF.inputView = datePicker
        startTimeTF.inputAccessoryView = toolbar
        
//        startTimeTextField.delegate = self
        
    }
    
    @IBAction func addToScheduleAction(_ sender: Any) {
        guard let companyName = companyNameTF.text?.stringAfterTrimming(), let roundName = roundNameTF.text?.stringAfterTrimming(), let roundTime = startTimeTF.date, let roundFormattedTime = startTimeTF.formatterDate() else{
            return
        }
        
        let date = roundTime.addingTimeInterval(+30)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .day, .month, .year], from: date)
//        date.compon
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationPayload = NotificationPayload(title: companyName, subtitle: roundName, body: "Interview at \(roundFormattedTime)", trigger: trigger)
        NotificationsManager.postNotification(notificationPayload: notificationPayload)
    }
    
    func createAccessoryToolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneSettingTime))
//        let cancel = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(cancelSettingTime))
        toolBar.setItems([done], animated: true)
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func doneSettingTime(){
        startTimeTF.date = datePicker.date
        setTextFieldFromDatePicker()
        unfocusTextField()
    }
    
    func unfocusTextField(){
        startTimeTF.endEditing(true)
    }
    
    @objc func cancelSettingTime(){
        unfocusTextField()
    }
    
    func createDatePickerView() -> UIDatePicker{
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }

    func setTextFieldFromDatePicker(){
        startTimeTF.text = startTimeTF.formatterDate()
    }
}


extension String{
    
    func stringAfterTrimming() -> String?{
        
        if self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return nil
        }
        else{
            return self.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

class DateTextField: UITextField{
    
    var date: Date?
    
    func formatterDate() -> String?{
        if let date = date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
}
/*
 extension ViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    }
    
}
*/
