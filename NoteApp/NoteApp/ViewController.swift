//
//  ViewController.swift
//  NoteApp
//
//  Created by user197801 on 6/28/21.
//

import UIKit

class ViewController: UITableViewController, UITextViewDelegate {
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        notes.removeAll()
//        save()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchNote))
        
        let defaults = UserDefaults.standard
        
        if let savedNote = defaults.object(forKey: "notes") as? Data {
            let jsondecoder = JSONDecoder()
            
            do {
                try notes = jsondecoder.decode([Note].self, from: savedNote)
            } catch {
                let ac = UIAlertController(title: "Something went wrong.", message: "Can not load saved notes", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(ac, animated: true)
            }
            
        }
    }

    @objc func addNote() {
        let ac = UIAlertController(title: "Add new note", message: nil, preferredStyle: .alert)
        
        ac.addTextField(configurationHandler: {$0.placeholder = "Title"})
        ac.addTextField(configurationHandler: {
            $0.placeholder = "Detail"
        })
        ac.addTextField()
        ac.addTextField()
        
        let rect = CGRect(x: 15, y: 90, width: 240, height: 100)
        let textView = UITextView(frame: rect)
        ac.view.addSubview(textView)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak ac] action in
            guard let title = ac?.textFields?[0].text else {return}
            guard let detail = textView.text else {return}
            if title.count == 0 && detail.count == 0 {
                return
            }
            let note = Note(title: title, detail: detail)
            self?.notes.append(note)
            self?.save()
            self?.tableView.reloadData()
        }
        ac.addAction(saveAction)
        present(ac, animated: true)
    }
    
    @objc func searchNote() {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if notes[indexPath.row].title.count == 0 {
            cell.textLabel?.text = "..."
        } else {
            cell.textLabel?.text = notes[indexPath.row].title
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.note = notes[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            save()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Can not save notes!")
        }
    }
}

