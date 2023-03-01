//
//  ViewController.swift
//  TheCalculatorApp
//
//  Created by Wynelher Tagayuna on 2/2/23.
//

import UIKit

class ViewController: UIViewController {
    var calculatorBrain = CalculatorBrain()// Calculator Brain object
    
    @IBOutlet weak var calculatorLabel: UILabel!// Screen
    @IBOutlet weak var allClearButtonOutlet: UIButton!// AC button
    
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Clear input and output
    @IBAction func allClearButton(_ sender: UIButton) {
        //Change button color when pressed
        calculatorBrain.changeBackgroundColor(of: sender)
        
        // Sets AC button title and deletes input
        calculatorBrain.clearButton(set: allClearButtonOutlet, and: calculatorLabel)
    }
    
    // Change number sign
    @IBAction func positiveNegativeButton(_ sender: UIButton) {
        //Change button color when pressed
        calculatorBrain.changeBackgroundColor(of: sender)
        
        // change number sign and return result to change label text
        calculatorLabel.text = calculatorBrain.positiveNegative()
    }
    
    // Get the percent of the number
    @IBAction func percent(_ sender: UIButton) {
        //Change button color when pressed
        calculatorBrain.changeBackgroundColor(of: sender)
        
        // Get the percent of the number and return result to change label text
        calculatorLabel.text = calculatorBrain.getPercent()
    }
    
    // Number inputs
    @IBAction func numberButtons(_ sender: UIButton) {
        //Change button color when pressed
        calculatorBrain.changeBackgroundColor(of: sender)
        
        // Display input into screen
        number = calculatorBrain.inputNumber(of: sender)
        calculatorLabel.text = number
        
        // Set all clear button title when there is number input
        if let clear = allClearButtonOutlet.titleLabel{
            if number != "" && clear.text == "AC"{
                allClearButtonOutlet.setTitle("C", for: .normal)
            }
        }
    }
    
    // Perform arithmatic operator functions on numbers
    @IBAction func arithmaticOperatorButtons(_ sender: UIButton) {
        //Change button color when pressed
        calculatorBrain.changeBackgroundColor(of: sender)
        
        var result = ""
        if let label = sender.titleLabel{
            result = calculatorBrain.performArithmeticOperator(label)
            if result != ""{
                calculatorLabel.text = result
            }
        }
    }
    
    // Get the result 
    @IBAction func equalButton(_ sender: UIButton) {
        //Change button color when pressed
        calculatorBrain.changeBackgroundColor(of: sender)
        
        var result = ""
        if let label = sender.titleLabel{
            result = calculatorBrain.equal(label)
            if result != ""{
                calculatorLabel.text = result
            }
        }
    }
}

