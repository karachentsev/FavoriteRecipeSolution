//
//  WebView.swift
//  FavoriteRecipeLibrary
//
//  Created by Karachentsev Oleksandr on 30.08.2025.
//

import SwiftUI
import WebKit

public struct WebView {

    // MARK: - Static properties

    private static var blankUrl: URL? { URL(string: "about:blank") }

    // MARK: - Properties

    let url: URL

    // MARK: - Init / Deinit

    public init(url: URL) {
        self.url = url
    }
}

#if os(iOS)
extension WebView: UIViewRepresentable {
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    public func updateUIView(_ view: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        view.load(request)
    }

    public static func dismantleUIView(_ view: WKWebView, coordinator: ()) {
        guard let blankUrl = Self.blankUrl else { return }
        view.load(URLRequest(url: blankUrl))
    }
}
#elseif os(macOS)
extension WebView: NSViewRepresentable {
    public func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    public func updateNSView(_ view: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        view.load(request)
    }

    public static func dismantleNSView(_ view: WKWebView, coordinator: ()) {
        guard let blankUrl = Self.blankUrl else { return }
        view.load(URLRequest(url: blankUrl))
    }
}
#endif
