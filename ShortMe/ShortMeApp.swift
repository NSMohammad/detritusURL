//
//  ShortMeApp.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

@main
struct ShortMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // baray dismiss keyboard
//                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
//extension UIApplication {
//    func addTapGestureRecognizer() {
//        guard let window = windows.first else { return }
//        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
//        tapGesture.requiresExclusiveTouchType = false
//        tapGesture.cancelsTouchesInView = false
//        tapGesture.delegate = self
//        window.addGestureRecognizer(tapGesture)
//    }
//}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
//extension UIApplication: UIGestureRecognizerDelegate {
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return !otherGestureRecognizer.isKind(of: UILongPressGestureRecognizer.self)
//    }
//}
