//
//  Alerts.swift
//  NewsApp
//
//  Created by Mine Rala on 24.10.2021.
//

import UIKit

class Alerts: NSObject {
    
    static func showAlertDelete(controller: UIViewController, _ message: String, deletion: @escaping () -> Void) {
        let dialogMessage = UIAlertController(title: "Deletion Confirmation", message: message, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { (action) in
         deletion()
         })
        deleteAction.setValue(Configuration.Color.redColor, forKey: "titleTextColor")
         dialogMessage.addAction(deleteAction)

        dialogMessage.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print("cancel is tapped.")
         }))
         controller.present(dialogMessage, animated: true, completion: {})
    }
}
