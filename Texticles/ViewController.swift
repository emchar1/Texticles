//
//  ViewController.swift
//  Texticles
//
//
//
//  So basically... instead of using CreateML/CoreML, you're using Firebase, which
//  has it's own built in ML Natural Language classifier thingie.
//
//  Created by Eddie Char on 9/11/20.
//  Copyright © 2020 Eddie Char. All rights reserved.
//

import UIKit
import MLKit


class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitPressed(_ sender: UIButton) {
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .spanish)
        let spanishTranslator = Translator.translator(options: options)
        let conditions = ModelDownloadConditions(allowsCellularAccess: false, allowsBackgroundDownloading: true)
        
        spanishTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else {
                return
            }
            
            spanishTranslator.translate(self.textField.text ?? "") { (translatedText, error) in
                guard error == nil, let translatedText = translatedText else {
                    return
                }
                
                self.label.text = translatedText
                self.textField.text = ""
            }
        }
    }
    
}

