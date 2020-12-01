//
//  SlideVC.swift
//  1lensTest
//
//  Created by Galym Anuarbek on 2/11/20.
//  Copyright © 2020 Galym Anuarbek. All rights reserved.
//

import UIKit
import EasyPeasy
import AVKit

class SlideViewController: UIViewController {
    
    let videos: [Video] = Media.getMedia()
    
    var videoViews: [VideoView] = []
    
    lazy var topView = PopupView(frame: view.frame)
    
    var helpersHidden = false
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = view.frame.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SlideCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = true
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    var like: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        b.layer.cornerRadius = 22
        b.layer.addGradienBorder(colors: [UIColor.red, UIColor.yellow], width: 2.5)
        b.backgroundColor = .black
        b.setImage(UIImage(named: "heart"), for: UIControl.State.normal)
        return b
    }()
    
    var upload: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        b.layer.cornerRadius = 22
        b.layer.addGradienBorder(colors: [UIColor.blue, UIColor.green], width: 2.5)
        b.backgroundColor = .black
        b.setImage(UIImage(named: "upload"), for: UIControl.State.normal)
        return b
    }()
    
    var menu: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        b.layer.cornerRadius = 22
        b.layer.addGradienBorder(colors: [UIColor.orange, UIColor.yellow], width: 2.5)
        b.backgroundColor = .black
        b.setImage(UIImage(named: "open-menu"), for: UIControl.State.normal)
        b.addTarget(self, action: #selector(handleMenuButton), for: UIControl.Event.touchUpInside)
        return b
    }()
    
    var download: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 68, height: 68))
        b.layer.cornerRadius = 34
        b.layer.addGradienBorder(colors: [UIColor.blue, UIColor.purple], width: 2.5)
        b.backgroundColor = .black
        b.setImage(UIImage(named: "download"), for: UIControl.State.normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideos()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.topView.video = videos[0]
    }
    
    func setupVideos() {
        for (index, video) in videos.enumerated() {
            let videoView = VideoView(frame: self.view.frame)
            videoView.didStart = {
                for cell in self.collectionView.visibleCells {
                    if let ip = self.collectionView.indexPath(for: cell), ip.row == index {
                        self.videoViews[index].play()
                    }
                }
            }
            videoView.configure(url: video.sources[0])
            self.videoViews.append(videoView)
        }
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(topView)
        view.addSubview(menu)
        view.addSubview(like)
        view.addSubview(download)
        view.addSubview(upload)
    }
    
    func setupConstraints() {
        self.collectionView.easy.layout(Edges(0))
        menu.easy.layout(Right(24), Bottom(44), Width(44), Height(44))
        upload.easy.layout(Right(24), Bottom(30).to(menu), Width(44), Height(44))
        like.easy.layout(Right(24), Bottom(30).to(upload), Width(44), Height(44))
        download.easy.layout(CenterX(), Bottom(24), Width(68), Height(68))
    }
    
    func hideShowHelpers() {
        if helpersHidden {
            UIView.animate(withDuration: 0.3) {
                self.menu.alpha += 1.0 - self.menu.alpha
                self.upload.alpha += 1.0 - self.upload.alpha
                self.like.alpha += 1.0 - self.like.alpha
                self.download.alpha += 1.0 - self.download.alpha
                self.topView.alpha += 1.0 - self.topView.alpha
            }
            helpersHidden = !helpersHidden
        } else {
            UIView.animate(withDuration: 0.3) {
                self.menu.alpha -= self.menu.alpha
                self.upload.alpha -= self.upload.alpha
                self.like.alpha -= self.like.alpha
                self.download.alpha -= self.download.alpha
                self.topView.alpha -= self.topView.alpha
            }
            helpersHidden = !helpersHidden
        }
    }
    
    @objc func handleMenuButton() {
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)

        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)

        let saveActionButton = UIAlertAction(title: "Save", style: .default)
            { _ in
               print("Save")
        }
        actionSheetController.addAction(saveActionButton)

        let deleteActionButton = UIAlertAction(title: "Delete", style: .default)
            { _ in
                print("Delete")
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
}

extension SlideViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlideCell
        for sub in cell.subviews {
            sub.removeFromSuperview()
        }
        cell.addSubview(videoViews[indexPath.row])
        videoViews[indexPath.row].easy.layout(Edges(0))
        if collectionView.visibleCells.contains(cell) {
            videoViews[indexPath.row].play()
        }
        return cell
    }
}

extension SlideViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        for sub in videoViews {
            sub.pause()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let ix = Int(targetContentOffset.pointee.x/collectionView.frame.width)
        if ix >= videoViews.count || ix < 0 { return }
        videoViews[ix].play()
        self.topView.video = videos[ix]
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        videoViews[indexPath.row].pause()
        videoViews[indexPath.row].player?.seek(to: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hideShowHelpers()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        hideShowHelpers()
    }
}
