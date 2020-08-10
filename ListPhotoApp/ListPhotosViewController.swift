//
//  ViewController.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import UIKit
import Alamofire

class ListPhotosViewController: UIViewController {

    @IBOutlet weak var listPhotosCollectionView: UICollectionView!
    var collectionViewFlowLayout = UICollectionViewFlowLayout()
    @IBOutlet weak var regularCompactSegmentedControl: UISegmentedControl!
    var idSelected: Int = 0
    var listPhotosVM = ListPhotoDataViewModel()
    var defaults = UserDefaults.standard
    let deviceType = UIDevice().type
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPhotosVM.fetchListPhotos(refreshController : myRefreshControl,
                                     refresh: true)
        checkStateSelected()
        listPhotosVM.vc = self
        listPhotosCollectionView.refreshControl = myRefreshControl
    }

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        listPhotosCollectionView.setupCollectionViewItemSize(view: view,
                                                             collectionViewFlowLayout: collectionViewFlowLayout, listPhotosCollectionView: listPhotosCollectionView, defineCell: regularCompactSegmentedControl.selectedSegmentIndex, deviceType: deviceType)
    }
    // Setup ListPhotos CollectionView
    private func setupCollectionView(index : Int) {
        listPhotosCollectionView.delegate = self
        listPhotosCollectionView.dataSource = self
        var nibString = ""
        var identifier = ""
        if index == 0 {
            nibString = CellIdentifier.nibRegularNameCollectionView
            identifier = CellIdentifier.RegularListPhotosCellIdentifier
        } else {
            nibString = CellIdentifier.nibCompactNameCollectionView
            identifier = CellIdentifier.CompactListPhotosCellIdentifier
        }
        
        listPhotosCollectionView.setupCollectionViewItemSize(view: view,
                                                             collectionViewFlowLayout: collectionViewFlowLayout, listPhotosCollectionView: listPhotosCollectionView, defineCell: regularCompactSegmentedControl.selectedSegmentIndex, deviceType: deviceType)
        
        let nib = UINib(nibName: nibString, bundle: nil)
        listPhotosCollectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    // Change layout for displaying List of Photos
    @IBAction func changeShowingListPhotosAction(_ sender: Any) {
        switch regularCompactSegmentedControl.selectedSegmentIndex
        {
            case 0:
                idSelected = 0
                saveState()
                setupCollectionView(index: idSelected)
                listPhotosCollectionView.reloadData()
            case 1:
                idSelected = 1
                saveState()
                setupCollectionView(index: idSelected)
                listPhotosCollectionView.reloadData()
            default:
                break
            }
    }
    
    @objc private func refreshData(sender : UIRefreshControl) {
        listPhotosVM.fetchListPhotos(refreshController: myRefreshControl,
                                     refresh: true)
    }
    
    private func saveState() {
        defaults.set(idSelected, forKey: Keys.stateSelected)
        
    }
    
    private func checkStateSelected() {
        let state = defaults.bool(forKey: Keys.stateSelected)
        if state {
            regularCompactSegmentedControl.selectedSegmentIndex = 1
            idSelected = 1
        } else {
            regularCompactSegmentedControl.selectedSegmentIndex = 0
            idSelected = 0
        }
        setupCollectionView(index: regularCompactSegmentedControl.selectedSegmentIndex)
    }
    
}

