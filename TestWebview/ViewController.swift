//
//  ViewController.swift
//  TestWebview
//
//  Created by Sun on 07/06/2022.
//

import UIKit

class ViewController: UIViewController {

    let webviewManager = WebviewManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webviewManager.setupWebview()
        
    }
    
    @IBAction func action(_ sender: Any) {
        print("tapped")
    }
}
