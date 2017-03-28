//
//  ViewController.swift
//  loanCaculate
//
//  Created by BoLing on 2017/3/23.
//  Copyright © 2017年 BoLing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loanAmountField: UITextField!
    @IBOutlet weak var interestRateField: UITextField!
    @IBOutlet weak var loanTermField: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBAction func simpleButton(_ sender: Any) {
        
        
        let calculate1 = simpleCalculate()
        guard let loanTermField = loanTermField.text, let loanAmountField = loanAmountField.text, let interestRateField = interestRateField.text
            else {
                return
        }
        guard let loanTerm = Int(loanTermField),let loanAmount = Double(loanAmountField),let interestRate = Double(interestRateField) else{
            print("Format Error")
            return
        }
        result.text = calculate1.calculate(loanAmount: loanAmount, years: loanTerm, interestRate: interestRate).money
        
        //result.text = calculate1.calculate(loanAmount: Double(loanAmountField.text!)!, years:Int(loanTermField.text!)!, interestRate:Double(interestRateField.text!)!).money
    }
    @IBAction func compoundButton(_ sender: Any) {
        
        let calculate2 = compoundCalculate()
        guard let loanTermField = loanTermField.text, let loanAmountField = loanAmountField.text, let interestRateField = interestRateField.text
           else {
               return
        }
        guard let loanTerm = Int(loanTermField),let loanAmount = Double(loanAmountField),let interestRate = Double(interestRateField) else{
            print("Format Error")
            return
        }
        result.text = calculate2.calculate(loanAmount: loanAmount, years: loanTerm, interestRate: interestRate).money
        //result.text = calculate2.calculate(loanAmount: Double(loanAmountField.text!)!, years:Int(loanTermField.text!)!, interestRate:Double(interestRateField.text!)!).money
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        loanAmountField.resignFirstResponder()
        loanTermField.resignFirstResponder()
        interestRateField.resignFirstResponder()
    }
    
    func demo(name:String?,age:Int?){
        
        guard let name = name,let age = age else {
            print("name or age is nil")
            return
        }
        print(name + String(age))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //demo(name:nil, age:100)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class simpleCalculate {
    func calculate(loanAmount:Double,years:Int,interestRate:Double) -> Double {
        let rate = interestRate / 100
        let interest = loanAmount * rate * Double(years)
        return loanAmount + interest
    }
}

class compoundCalculate {
    func calculate(loanAmount:Double,years:Int,interestRate:Double) -> Double {
        let rate = interestRate / 100
        let compoundInterest = pow(1.0+rate,Double(years))
        return compoundInterest * loanAmount
    }
}


extension Double{
    var money:String{
        let formatter =  NumberFormatter()
        formatter.numberStyle = .currency
        let result:String?
        result = formatter.string(from: NSNumber(value:self))
        if result == nil{
            return "format error"
        }
        return result!
    }
}
