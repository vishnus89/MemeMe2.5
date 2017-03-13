//
//  CollectionViewController1.swift
//  MemeMe2.5
//
//  Created by Vishnu Deep Samikeri on 3/13/17.
//  Copyright © 2017 Vishnu Deep Samikeri. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "collectionCell1"

class CollectionViewController1: UICollectionViewController {
    
    let CELL_PER_ROW_PORTRAIT = 4
    let CELL_PER_ROW_LANDSCAPE = 6
    let CELL_SPACING = 2
    
    var CELL_PER_ROW: Int {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            return CELL_PER_ROW_LANDSCAPE
        case .portrait:
            return CELL_PER_ROW_PORTRAIT
        default:
            return CELL_PER_ROW_PORTRAIT
        }
    }
    
    var memes: [Meme]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = false
        reloadMemesFromSource()
    }
    
    override func viewDidLayoutSubviews() {
        let width = collectionView!.frame.width / (CGFloat(CELL_PER_ROW) + CGFloat(CELL_SPACING))
        let layout = collectionView!.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: width, height: width)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell12
        
        cell.meme = memes?[indexPath.row]
        print(cell.meme!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeDetailSegue1" {
            let indexPath = collectionView?.indexPathsForSelectedItems?[0]
            let VC = segue.destination as! MemeDetailViewController1
            VC.meme = Meme(from: memes?[(indexPath?.row)!])
        }
    }
}

extension CollectionViewController1 {
    func reloadMemesFromSource() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    // delete the meme from the AppDelegate Meme array and update views
    func deleteSingleMemeAtIndex(_ index: Int) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.remove(at: index)
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
}
