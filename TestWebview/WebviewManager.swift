//
//  WebviewManager.swift
//  WebviewExample
//
//  Created by Sun on 27/05/2022.
//

import WebKit

class WebviewManager: NSObject {
    
    static let shared = WebviewManager()
    
    var webview: WKWebView!
    let popupScreen = PopupViewController()
    var fistLoad = false
    
    func setupWebview() {
        let config = getConfig()
        webview = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        webview.navigationDelegate = self
        webview.backgroundColor = .green
        
        let request = getRequest()
        webview.load(request)
        
        //        let htmlFile = Bundle.main.path(forResource:"popup", ofType: "html")
        //           let htmlString = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        //        webview.loadHTMLString(htmlString!, baseURL: nil)
    }
    
    private func getRequest() -> URLRequest {
        let urlString = "https://t1.mobio.vn/static/1b99bdcf-d582-4f49-9715-1b61dfff3924/upload/629f1957b7d4f9ec3948178d.html"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            return request
        } else {
            let url = URL(string: "https://www.google.com/")!
            let request = URLRequest(url: url)
            return request
        }
    }
    
    private func getConfig() -> WKWebViewConfiguration {
        let contentController = WKUserContentController()
        contentController.add(self, name: "sumbitToiOS")
        let source = "window.addEventListener('message', function(e){ webkit.messageHandlers.sumbitToiOS.postMessage(event.data); })"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(script)
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        return config
    }
}

extension WebviewManager: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        print("-----------Finished navigating to url \(String(describing: webView.url))")
        webview.evaluateJavaScript("showPopup('\(123)')") { (any, error) in
            print("Error : \(String(describing: error))")
        }
        popupScreen.modalPresentationStyle = .custom
        popupScreen.webview = webview
        popupScreen.view.frame = CGRect(x: 0, y: 60, width: 400, height: 400)
        let rootViewController = UIApplication.shared.windows.last?.rootViewController
//        rootViewController?.present(popupScreen, animated: true, completion: nil)
        rootViewController?.view.addSubview(popupScreen.view)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("------ debug ------- navigationAction = ", navigationAction)
        decisionHandler(.allow)
    }
}

extension WebviewManager: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("---------- debug -------- message =  ", message.body)
    }
}
