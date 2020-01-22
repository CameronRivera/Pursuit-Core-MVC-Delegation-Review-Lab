//
//  AdjustFontViewController.swift
//  MVC+Delegation-Review-Lab
//
//  Created by Cameron Rivera on 11/20/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

protocol AdjustFontViewControllerDelegate: AnyObject{
    var fontSize: Double { get set }
}

class AdjustFontViewController: UIViewController {

    // MARK: Outlets of AdjustFontViewController
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var fontSlider: UISlider!
    @IBOutlet weak var fontStepper: UIStepper!
    
    // MARK: Properties of AdjustFontViewController
    var initialFont: Double = 17.0
    var fontSize: Double = 17.0 {
        didSet{
            fontSizeLabel.text = "Preview Font Size: \(String(format:"%0.f",fontSize))" 
            fontStepper.value = fontSize
            fontSlider.value = Float(fontSize)
            fontSizeChanged(self)
        }
    }
    
    // Weak reference to movieViewController
    weak var delegate: AdjustFontViewControllerDelegate?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    // MARK: Helper Methods
    private func setUp(){
        fontSlider.maximumValue = 40.0
        fontSlider.minimumValue = 10.0
        fontStepper.maximumValue = 40.0
        fontStepper.minimumValue = 10.0
        fontStepper.stepValue = 1.0
        fontSize = initialFont
    }
    
    // MARK: Target Actions
    @IBAction func sliderEngaged(_ sender: UISlider){
        fontSize = Double(sender.value)
    }
    
    @IBAction func stepperEngaged(_ sender: UIStepper){
        fontSize = sender.value
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Delegate Methods
    func fontSizeChanged(_ adjustFontViewController: AdjustFontViewController){
        delegate?.fontSize = adjustFontViewController.fontSize
    }
    
}
