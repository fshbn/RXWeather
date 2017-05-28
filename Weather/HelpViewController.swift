//
//  HelpViewController.swift
//  Weather
//
//  Created by Boran ASLAN on 14/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "help", withExtension: "html") {
            webView.loadRequest(URLRequest(url: url))
        }
    }
    
    func closeView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        closeView()
    }

}
