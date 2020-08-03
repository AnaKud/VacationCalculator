//
//  ViewController.swift
//  Vacation
//
//  Created by Анастасия Кудашева on 18.07.2020.
//  Copyright © 2020 Анастасия Кудашева. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var middleGrossTextField: UITextField!
    @IBOutlet weak var nowSalary: UITextField!
    @IBOutlet weak var vacationDaysLabel: UILabel!
    @IBOutlet weak var workedDaysLabel: UILabel!
    @IBOutlet weak var workCalendarDaysLabel: UILabel!
    @IBOutlet weak var workDaysStepperOutlet: UIStepper!
    @IBOutlet weak var vacationDaysStepper: UIStepper!
    @IBOutlet weak var vacationCostLabel: UILabel!
    @IBOutlet weak var workCostLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    var vacationDaysDouble: Double!
    var workDaysFloat: Float!
    var workedDaysDouble: Double!
    var workDaysInt: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dissmissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        assignbackground()
    }

    //MARK: - Actions
    
    // worked days stepper
    @IBAction func workedDaysChangingStepper(_ sender: UIStepper) {
        sender.minimumValue = 0.00
        sender.maximumValue = 45.00
        workedDaysDouble = sender.value
        let dayWord = dayWordFunc(numberCurrent: workedDaysDouble)
        let workedWord = workedWordFunc(numberCurrent: workedDaysDouble)
        workedDaysLabel.text = String(format: "%1.0f", workedDaysDouble) + " " + dayWord + " " + workedWord
    }
    
    // vacation days stepper
    @IBAction func vacationDaysChangingStepper(_ sender: UIStepper) {
        sender.minimumValue = 0.00
        sender.maximumValue = 28.00
        vacationDaysDouble = sender.value
        let dayWord = dayWordFunc(numberCurrent: vacationDaysDouble)
        vacationDaysLabel.text = String(format: "%1.0f", vacationDaysDouble) + " " + dayWord + " " + "отпуска"
    }
    
    // work days in calendar slider
    @IBAction func sliderValueCHanged(_ sender: UISlider) {
        sender.minimumValue = 16.00
        sender.maximumValue = 46.00
        workDaysFloat = sender.value
        workDaysInt = Int(workDaysFloat)
        let workDaysDouble = Double(workDaysInt)
        print(workDaysDouble)
        let dayWord = dayWordFunc(numberCurrent: workDaysDouble)
        let workWord = daysWorkWordFunc(numberCurrent: workDaysDouble)
        workCalendarDaysLabel.text = String(workDaysInt) + " " + workWord + " " + dayWord + " " + "в период отпуска (по производственому календарю)"
    }
    
    // button for calculation
    @IBAction func calcButton(_ sender: UIButton) {
        let averageSalary = Double(middleGrossTextField.text ?? "0.0")
        let todaySalary = Double(nowSalary.text ?? "0.0")
        
        let constMonthDays: Double = 29.300000000000000000000
        if let midSalary = averageSalary, let nowSalary = todaySalary,  let totalWorkDays = workDaysInt, let workedDays = workedDaysDouble {
            var vacationCost: Double = 0.0
            if vacationDaysDouble == 0.0 {
                vacationCost = 0
            } else {
                vacationCost = (midSalary / constMonthDays) * vacationDaysDouble
            }
            let workCost = (nowSalary / Double(totalWorkDays)) * workedDays
            let totalCost = workCost + vacationCost
            print(totalCost)
            workCostLabel.text = "Ваша ЗП в период отпуска: " + String(format: "%1.2f", workCost)
            vacationCostLabel.text = "Ваши отпускные: " + String(format: "%1.2f", vacationCost)
            totalCostLabel.text = "Итого вы получите: " + String(format: "%1.2f", totalCost)
        }
    }
    
    //MARK: - methods
    // methods for declension of words
    func dayWordFunc(numberCurrent: Double) -> String {
        var dayWord = "дней"
        switch numberCurrent {
        case 1.0, 21.0, 31.0, 41.0:
            dayWord = "день"
        case 2.0, 3.0, 4.0, 22.0, 23.0, 24.0, 32.0, 33.0, 34.0, 42.0, 43.0, 44.0:
            dayWord = "дня"
        default:
            dayWord = "дней"
        }
       return dayWord
    }
    
    func daysWorkWordFunc(numberCurrent: Double) -> String {
        var daysWorkWord = "рабочих"
        switch numberCurrent {
        case 1.0, 21.0, 31.0, 41.0:
            daysWorkWord = "рабочий"
        default:
            daysWorkWord = "рабочих"
        }
        return daysWorkWord
    }
    
    func workedWordFunc(numberCurrent: Double) -> String {
        var workedWord = "отработано"
        switch numberCurrent {
        case 1.0, 21.0, 31.0, 41.0:
            workedWord = "отработан"
        default:
            workedWord = "отработано"
        }
        return workedWord
    }
    // background method
    func assignbackground(){
        let background = UIImage(named: "backgroundImageVacationApp")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
}
