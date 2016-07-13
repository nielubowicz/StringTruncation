//
//  ViewController.swift
//  StringTruncation
//
//  Created by Chris Nielubowicz on 7/13/16.
//  Copyright © 2016 Chris Nielubowicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var output: UITextView!
    
    @IBOutlet weak var truncationLength: UITextField!
    
    private var truncation: Int = 1000 {
        didSet {
            self.set(text:self.textView.text)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.truncationLength.text = String(self.truncation)
        self.output.text = textView.text.truncate(forMaxLength: self.truncation)
    }
    
    func set(text text:String) {
        self.output.text = text.truncate(forMaxLength: self.truncation)
    }
    
    @IBAction func resign(gesture: UITapGestureRecognizer) {
        self.resignFirstResponder()
    }
}

//MARK- Truncation Length Handling
extension ViewController {
    @IBAction func textFieldChanged(sender: UITextField) {
        guard let text = sender.text else { return }
        guard let number = Int(text) else { return }
        self.truncation = number
    }
}

//MARK- UITextViewDelegate
extension ViewController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        guard textView != self.output else { return }
        self.set(text: textView.text)
    }
}