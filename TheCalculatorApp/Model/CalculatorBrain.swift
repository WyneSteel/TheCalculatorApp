//
//  CalculatorBrain.swift
//  TheCalculatorApp
//
//  Created by Wynelher Tagayuna on 2/6/23.
//

import Foundation
import UIKit

struct CalculatorBrain{
    
    var input = ""
    var leftOperand = ""
    var rightOperand = ""
    var arithmaticOperator = ""
    var savedOperator = ""
    var retainer = ""
    
    //Change button background color when pressed
    func changeBackgroundColor(of sender: UIButton){
        if sender.backgroundColor == UIColor(named: "Gray"){
            sender.backgroundColor = UIColor(named: "Light Gray")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                sender.backgroundColor = UIColor(named: "Gray")
            }
        }else if sender.backgroundColor == UIColor(named: "Dark Gray"){
            sender.backgroundColor = UIColor(named: "Gray")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                sender.backgroundColor = UIColor(named: "Dark Gray")
            }
        }else if sender.backgroundColor == UIColor(named: "Orange"){
            sender.backgroundColor = UIColor(named: "Light Orange")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                sender.backgroundColor = UIColor(named: "Orange")
            }
        }
    }
    
    // Sets all clear button title and deletes input
    mutating func clearButton(set title: UIButton, and update: UILabel){
        if let clear = title.titleLabel{
            if rightOperand != ""{// Delete right operand and update all clear button title
                title.setTitle("AC", for: .normal)
                rightOperand = ""
                update.text = "0"
            }else if arithmaticOperator != "" && clear.text == "C"{// Delete arithmatic operator and update all clear button title
                title.setTitle("AC", for: .normal)
                arithmaticOperator = ""
                savedOperator = ""
                retainer = ""
            }else if leftOperand != "" && clear.text == "AC"{// Delete left operand
                leftOperand = ""
                update.text = "0"
                retainer = ""
            }else{// Delete left operand and update all clear button title
                title.setTitle("AC", for: .normal)
                leftOperand = ""
                update.text = "0"
            }
        }
    }
    
    // Change number sign
    mutating func positiveNegative() -> String{
        var result = ""
        
        if !leftOperand.isEmpty && !leftOperand.contains("-"){
            leftOperand.insert("-", at: leftOperand.startIndex)
            result = leftOperand
        }else if !leftOperand.isEmpty && leftOperand.contains("-"){
            leftOperand.remove(at: leftOperand.startIndex)
            result = leftOperand
        }else if !rightOperand.isEmpty && !rightOperand.contains("-"){
            rightOperand.insert("-", at: rightOperand.startIndex)
            result = rightOperand
        }else if !rightOperand.isEmpty && rightOperand.contains("-"){
            rightOperand.remove(at: rightOperand.startIndex)
            result = rightOperand
        }else{
            result = "0"
        }
        
        // Remove decimal if all zeros
        let index = result.firstIndex(of: ".") ?? result.endIndex
        let theCString = result
        let decimals = String(theCString[theCString.index(after: index)...theCString.index(before: theCString.endIndex)])
        for i in decimals{
            if let num = i.wholeNumberValue{
                if num > 0{
                    result = leftOperand
                    break
                }else{
                    result = String(leftOperand[leftOperand.startIndex..<index])
                }
            }
        }
        return result
    }
    
    // Get the percent of the number
    mutating func getPercent() -> String{
        var result = ""
        if !leftOperand.isEmpty && rightOperand.isEmpty{
            leftOperand = String(Double(leftOperand)!/100.0)
            result = leftOperand
        }else if !rightOperand.isEmpty{
            rightOperand = String(Double(rightOperand)!/100.0)
            result = rightOperand
        }

        return result
    }
    
    // Append character/s to left or right operands
    mutating func inputNumber(of button: UIButton) -> String{
        var result = ""
        if let label = button.titleLabel{
            if let character = label.text{
                if arithmaticOperator.isEmpty{// Work on left operand if there is no arithmatic operator
                    if leftOperand.filter({$0=="."}).count == 0{// Checks if operand decimal count doesn't exceed 1
                        leftOperand.append(character)// Append characters from "0","1","2","3","4","5","6","7","8","9" and "."
                        retainer.append(character)
                        result = leftOperand
                    }else{
                        if character != "."{
                            leftOperand.append(character)// Only append characters from "0" to "9"
                            retainer.append(character)
                        }
                        result = leftOperand
                    }
                }else{// Work on right operand if there is no arithmatic operator
                    if rightOperand.filter({$0=="."}).count == 0{// Checks if operand decimal count doesn't exceed 1
                        rightOperand.append(character)// Append characters from "0","1","2","3","4","5","6","7","8","9" and "."
                        result = rightOperand
                    }else{
                        if character != "."{
                            rightOperand.append(character)// Only append characters from 0 to 9
                        }
                        result = rightOperand
                    }
                }
            }
        }
        return result
    }
    
    //Perform arithmetic operator functions on numbers
    mutating func performArithmeticOperator(_ button: UILabel) -> String{
        var result = ""
        arithmaticOperator = button.text!
        if leftOperand != "" && arithmaticOperator == savedOperator && rightOperand != ""{
            let leftOp = String(Double(leftOperand)!)
            let rightOp = String(Double(rightOperand)!)
            let expression = NSExpression(format: leftOp+arithmaticOperator+rightOp)// Perform concatenated string expression
            leftOperand = String(expression.expressionValue(with: nil, context: nil) as! Double)//Get expression Value
            rightOperand = ""
            
            // Remove decimal if all zeros
            let index = leftOperand.firstIndex(of: ".") ?? leftOperand.endIndex
            let theCString = leftOperand
            let decimals = String(theCString[theCString.index(after: index)...theCString.index(before: theCString.endIndex)])
            for i in decimals{
                if let num = i.wholeNumberValue{
                    if num > 0{
                        result = leftOperand
                        break
                    }else{
                        result = String(leftOperand[leftOperand.startIndex..<index])
                    }
                }
            }
        }else if arithmaticOperator != savedOperator{// Change operator if changed
            savedOperator = arithmaticOperator
        }else{
            savedOperator = arithmaticOperator
        }
        return result
    }
    
    // Get the result
    mutating func equal(_ button: UILabel) -> String{
        var result = ""
        if rightOperand != ""{// Right Operand
            let leftOp = String(Double(leftOperand)!)
            let rightOp = String(Double(rightOperand)!)
            let expression = NSExpression(format: leftOp+arithmaticOperator+rightOp)// Perform concatenated string expression
            leftOperand = String(expression.expressionValue(with: nil, context: nil) as! Double)//Get expression Value
            rightOperand = ""
            result = leftOperand
            
            // Remove decimal if all zeros
            let index = leftOperand.firstIndex(of: ".") ?? leftOperand.endIndex
            let theCString = leftOperand
            let decimals = String(theCString[theCString.index(after: index)...theCString.index(before: theCString.endIndex)])
            for i in decimals{
                if let num = i.wholeNumberValue{
                    if num > 0{
                        result = leftOperand
                        break
                    }else{
                        result = String(leftOperand[leftOperand.startIndex..<index])
                    }
                }
            }
        }else if arithmaticOperator != "" && rightOperand.isEmpty{// Left operand
            let leftOp = String(Double(leftOperand)!)
            let expression = NSExpression(format: leftOp+arithmaticOperator+String(Double(retainer  )!))// Perform concatenated string expression
            leftOperand = String(expression.expressionValue(with: nil, context: nil) as! Double)//Get expression Value
            result = leftOperand
            
            // Remove decimal if all zeros
            let index = leftOperand.firstIndex(of: ".") ?? leftOperand.endIndex
            let theCString = leftOperand
            let decimals = String(theCString[theCString.index(after: index)...theCString.index(before: theCString.endIndex)])
            for i in decimals{
                if let num = i.wholeNumberValue{
                    if num > 0{
                        result = leftOperand
                        break
                    }else{
                        result = String(leftOperand[leftOperand.startIndex..<index])
                    }
                }
            }
        }
        return result
    }
}
