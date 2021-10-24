//
//  Toast.swift
//  NewsApp
//
//  Created by Mine Rala on 24.10.2021.
//

import UIKit

extension UIViewController {

    func showToast(title:String ,text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
}
