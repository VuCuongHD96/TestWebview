//
//  PopupViewController.swift
//  WebviewExample
//
//  Created by Sun on 27/05/2022.
//

import UIKit
import WebKit

class PopupViewController: UIViewController {
    
    var webview = WKWebView()
    let presentTransition = WebPresentTransition()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView1: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        transitioningDelegate = self
    }
    
    private func setupStackView() {
        webview.scrollView.isScrollEnabled = false
        webview.heightAnchor.constraint(equalToConstant: 1100).isActive = true
        stackView1.addArrangedSubview(webview)
        
        
        let myView = UIView()
        myView.backgroundColor = .green
        myView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        stackView1.addArrangedSubview(myView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupStackView()
    }
}

extension PopupViewController: UIViewControllerTransitioningDelegate {

    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransition
    }
}
