//
//  Note.swift
//  NoteApp
//
//  Created by user197801 on 6/28/21.
//

import UIKit

class Note: NSObject, Codable {
    var title: String
    var detail: String
    
    init(title: String, detail: String) {
        self.title = title
        self.detail = detail
    }
}
