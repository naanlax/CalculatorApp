//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Nandhika T M on 17/12/24.
//

import UIKit

class ViewController: UIViewController
{
    var buttonEql = MainButton()
    var buttonAdd = MainButton()
    var buttonSub = MainButton()
    var buttonMul = MainButton()
    var buttonDiv = MainButton()
    
    var button1 = MainButton()
    var button2 = MainButton()
    var button3 = MainButton()
    var button4 = MainButton()
    var button5 = MainButton()
    var button6 = MainButton()
    var button7 = MainButton()
    var button8 = MainButton()
    var button9 = MainButton()
    var button0 = MainButton()
    
    var buttonAC = MainButton()
    var buttonOR = MainButton()
    var buttonper = MainButton()
    var buttondot = MainButton()
    var buttonGoBack = MainButton()
    
    var inputField = UILabel()
    
    var count = 0
    var leftValue:Double = 0
    var rightValue:Double = 0
    var leftDecimal: Double = 0
    var rightDecimal: Double = 0
    var operationPerformed = ""
    var isoperation = false
    var isDecimal = false
    var total: Double = 0.0
    var rc = 0
    var lc = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpUI()
        setUpName()
        setUpOperation()
    }

    func setUpUI()
    {
        [buttonEql, buttonAdd, buttonSub, buttonMul, buttonDiv, button0, button1, button2, button3, button4, button5, button6, button7, button8, button9, buttondot, buttonAC, buttonOR, buttonper, buttonGoBack].forEach
        {
            button in
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 37.5
            button.titleLabel?.font = .systemFont(ofSize: 35)
            button.widthAnchor.constraint(equalToConstant: 75).isActive = true
            button.heightAnchor.constraint(equalToConstant: 75).isActive = true
            button.addTarget(self, action: #selector(valueInButton(sender: )), for: .touchUpInside)
            view.addSubview(button)
        }
        
        [buttonEql, buttonAdd, buttonSub, buttonMul, buttonDiv].forEach
        {
            button in
            button.backgroundColor = UIColor(red: 186/225, green: 142/225, blue: 35/225, alpha: 1.0)
        }
        
        [button0, button1, button2, button3, button4, button5, button6, button7, button8, button9].forEach
        {
            button in
            button.name = count
            button.backgroundColor = .darkGray
            count += 1
        }
        
        [buttonAC, buttonOR, buttonper].forEach
        {
            button in
            button.backgroundColor = .systemGray2
        }
        
        buttondot.backgroundColor = .darkGray
        buttonGoBack.backgroundColor = .darkGray
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.textColor = .white
        inputField.minimumScaleFactor = 0.2
        inputField.font = .systemFont(ofSize: 90)
        inputField.adjustsFontSizeToFitWidth = true
        inputField.text = "0"
        inputField.textAlignment = .right
        
        view.addSubview(inputField)
        
        let stack1 = UIStackView(arrangedSubviews: [buttonAC, buttonOR, buttonper, buttonDiv])
        let stack2 = UIStackView(arrangedSubviews: [button7, button8, button9, buttonMul])
        let stack3 = UIStackView(arrangedSubviews: [button4, button5, button6, buttonSub])
        let stack4 = UIStackView(arrangedSubviews: [button1, button2, button3, buttonAdd])
        let stack5 = UIStackView(arrangedSubviews: [buttonGoBack, button0, buttondot, buttonEql])
        
        [stack1, stack2, stack3, stack4, stack5].forEach
        {
            stackView in
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = 30
            stackView.alignment = .fill
            stackView.layer.masksToBounds = true
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.widthAnchor.constraint(equalToConstant: 400).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: 75).isActive = true
            
            view.addSubview(stackView)
        }
        
        let stackView = UIStackView(
            arrangedSubviews: [stack1, stack2, stack3, stack4, stack5]
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.layer.masksToBounds = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        NSLayoutConstraint.activate([
            inputField.bottomAnchor.constraint(equalTo: stackView.topAnchor)
        ])
    }
    
    func setUpName()
    {
        button0.setTitle("0", for: .normal)
        button1.setTitle("1", for: .normal)
        button2.setTitle("2", for: .normal)
        button3.setTitle("3", for: .normal)
        button4.setTitle("4", for: .normal)
        button5.setTitle("5", for: .normal)
        button6.setTitle("6", for: .normal)
        button7.setTitle("7", for: .normal)
        button8.setTitle("8", for: .normal)
        button9.setTitle("9", for: .normal)
        button0.setTitle("0", for: .normal)
        buttondot.setTitle(".", for: .normal)
        buttonDiv.setTitle("/", for: .normal)
        buttonMul.setTitle("X", for: .normal)
        buttonSub.setTitle("-", for: .normal)
        buttonAdd.setTitle("+", for: .normal)
        buttonEql.setTitle("=", for: .normal)
        buttonAC.setTitle("A/C", for: .normal)
        buttonOR.setTitle("+/-", for: .normal)
        buttonper.setTitle("%", for: .normal)
        buttonGoBack.setTitle("<-", for: .normal)
    }
    
    func setUpOperation()
    {
        buttonAdd.operation = "+"
        buttonSub.operation = "-"
        buttonMul.operation = "X"
        buttonDiv.operation = "/"
        buttonEql.operation = "="
        buttonGoBack.operation = "<-"
        buttonAC.operation = ""
        buttondot.operation = "."
    }
    
    @objc func valueInButton(sender: MainButton)
    {
        if sender.operation == "" && sender.name != -1
        {
            if inputField.text == String(0)
            {
                inputField.text = ""
            }
            inputField.text?.append(String(sender.name))
            if isoperation == false
            {
                if isDecimal == false
                {
                    leftValue = leftValue*10 + Double(sender.name)
                    print("Value Left \(leftValue)")
                }
                else
                {
                    lc+=1
                    print(lc)
                    leftDecimal = leftDecimal + (Double(sender.name))/pow(10, Double(lc))
                    print(leftDecimal)
                    print("leftDecimal \(leftDecimal)")
                }
            }
            else
            {
                if isDecimal == false
                {
                    rightValue = rightValue*10 + Double(sender.name)
                    print("Value Right \(rightValue)")
                }
                else
                {
                    rc += 1
                    rightDecimal =  rightDecimal + (Double(sender.name))/pow(10, Double(rc))
                    print("rightDecimal \(rightDecimal)")
                    
                }
            }
        }
        else if sender.operation == "."
        {
            isDecimal = true
            inputField.text?.append(sender.operation)
        }
        else if sender.operation == "="
        {
            let totalleft: Double = Double(leftValue)+leftDecimal
            let totalright: Double = Double(rightValue)+rightDecimal
            switch operationPerformed
            {
            case "+":
                inputField.text = String(totalleft+totalright)
                leftValue = Double(totalleft+totalright)
            case "-":
                inputField.text = String(totalleft-totalright)
                leftValue =  Double(totalleft-totalright)
            case "X":
                inputField.text = String(totalleft*totalright)
                leftValue =  Double(totalleft*totalright)
            case "/":
                inputField.text = String(totalleft/totalright)
                leftValue = Double(totalleft/totalright)
            default:
                inputField.text = ""
                break
            }
            if inputField.text == "0"
            {
                inputField.text = ""
            }
            rightValue = 0
            isoperation = false
        }
        else if sender.operation == "<-"
        {
            var value: Int = 0
            
            if isoperation == true
            {
                rightValue /= 10
                value = Int(rightValue)
                
            }
            leftValue /= 10
            value = Int(leftValue)
            
            inputField.text = String(value)
        }
        
        else if sender.operation != ""
        {
            inputField.text?.append(sender.operation)
            isoperation = true
            operationPerformed = sender.operation
            isDecimal = false
        }
        else
        {
            inputField.text = "0"
            leftValue = 0
            rightValue = 0
            leftDecimal = 0
            rightDecimal = 0
        }
    }
}

class MainButton: UIButton
{
    var name: Int = -1
    var operation: String = ""
}
