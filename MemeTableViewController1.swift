//
//  MemeTableViewController1.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/13/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import Foundation
import UIKit


class MemeTableViewController1: UITableViewController {
    
    var memes: [Meme]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = false
        isEditing = false
        
        reloadMemesFromSource()
        navigationItem.leftBarButtonItem?.isEnabled = (memes?.count ?? 0) > 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell1", for: indexPath) as! MemeTableViewCell1
        
        let meme = memes?[indexPath.row]
        cell.meme = meme
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteSingleMemeAtIndex(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetailSegue1" {
            let indexPath = tableView.indexPathForSelectedRow
            let VC = segue.destination as! MemeDetailViewController1
            VC.meme = Meme(from: memes?[(indexPath?.row)!])
        }
    }
    
}


extension MemeTableViewController1 {
    func reloadMemesFromSource() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }
    
    // delete the meme from the AppDelegate Meme array and update views
    func deleteSingleMemeAtIndex(at index: Int) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.remove(at: index)
        memes = appDelegate.memes
    }
}
