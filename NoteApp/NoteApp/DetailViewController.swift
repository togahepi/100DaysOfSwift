//
//  DetailViewController.swift
//  NoteApp
//
//  Created by user197801 on 6/28/21.
//

import UIKit

class DetailViewController: UIViewController {
    var note: Note?
    @IBOutlet var titleNote: UITextField!
    @IBOutlet var detailNote: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedNote = note {
            titleNote.text = selectedNote.title
            detailNote.text = selectedNote.detail
        }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
