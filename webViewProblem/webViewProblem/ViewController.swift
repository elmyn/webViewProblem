//
//  ViewController.swift
//  webViewProblem

import UIKit
import WebKit

class ViewController: UIViewController {
    weak var constraint_WebViewHeight: NSLayoutConstraint!
    var webView = WKWebView()
    let scrollView = UIScrollView()
    let headerView = UIView()
    let footerView = UIView()
    private let footerContainer = UIStackView()
    private let contentView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupScrollView()
        setupLayout()
        setupBinding()
        loadHTML()
    }

    private func setupSelf() {
        webView.isOpaque = false
        webView.contentScaleFactor = 1.0
        webView.scrollView.isScrollEnabled = false

        footerView.backgroundColor = .red
        headerView.backgroundColor = .blue
    }

    private func setupScrollView() {
        contentView.axis = .vertical
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(headerView)
        contentView.addArrangedSubview(webView)
        contentView.addArrangedSubview(footerView)
    }

    private func setupLayout() {
        [scrollView, contentView, headerView, webView, footerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        let constraints = [
            headerView.heightAnchor.constraint(equalToConstant: 100),
            footerView.heightAnchor.constraint(equalToConstant: 100),

            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]

        constraint_WebViewHeight = webView.heightAnchor.constraint(equalToConstant: 1)
        constraint_WebViewHeight.isActive = true

        NSLayoutConstraint.activate(constraints)
    }

    private func setupBinding() {
        webView.navigationDelegate = self
        webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old], context: nil)
    }

    private func loadHTML() {
        let html = """
                <html>
                <body>
                <h1>header</h1>
                <p>Paragraph</p>
                What is Lorem Ipsum?
                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

                Why do we use it?
                It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


                Where does it come from?
                Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

                The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
                Why do we use it?
                It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


                Where does it come from?
                Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

                The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.
                Why do we use it?
                It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


                Where does it come from?
                Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

                The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.

                end!
                </body>
                </html
                """

        webView.loadHTMLString(html, baseURL: nil)
    }
}

extension ViewController: WKNavigationDelegate {

    // method 1
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        guard let scroll = object as? UIScrollView else { return }
        guard scroll === webView.scrollView else { return }
        guard constraint_WebViewHeight.constant != scroll.contentSize.height else { return }

        if constraint_WebViewHeight.constant != webView.scrollView.contentSize.height {
            constraint_WebViewHeight.constant = webView.scrollView.contentSize.height
            view.setNeedsLayout()
        }
    }

    // method 2
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        if constraint_WebViewHeight.constant != webView.scrollView.contentSize.height {
            constraint_WebViewHeight.constant = webView.scrollView.contentSize.height
            view.setNeedsLayout()
        }
    }
}

