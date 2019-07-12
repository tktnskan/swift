//
//  swipingViewController.swift
//  swipeAutoLayout
//
//  Created by Jinyung Yoon on 09/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit

class FirstPage: UIViewController {
    private let button: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("click here", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        addTargets()
    }
    
    @objc
    private func userDidClickOnButton() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipingController(collectionViewLayout: layout)
        present(swipingController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(button)
        
        button.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 30))
        button.center = view.center
        button.widthAnchor.constraint(equalToConstant: 200)
        button.heightAnchor.constraint(equalToConstant: 30)
    }
    
    private func addTargets() {
        button.addTarget(self, action: #selector(userDidClickOnButton), for: .touchUpInside)
    }
}


class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [Page(imageName: "bn_cute", headerText: "Happy Binna", bodyText: "ahsdaisjdoiasjdasijdoiasjdio"),
    Page(imageName: "bn_cute2", headerText: "wanna make you smile", bodyText: "asdasdasdasdasdsa"),
    Page(imageName: "bn_cute3", headerText: "miss you so much", bodyText: "asdascwecdcasdsxa"),
    Page(imageName: "bn_cute", headerText: "Happy Binna", bodyText: "ahsdaisjdoiasjdasijdoiasjdio"),
    Page(imageName: "bn_cute2", headerText: "wanna make you smile", bodyText: "asdasdasdasdasdsa"),
    Page(imageName: "bn_cute3", headerText: "miss you so much", bodyText: "asdascwecdcasdsxa")]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private let prevButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("<-List", for: .normal)
        bt.setTitleColor(.red, for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(userDidClickOnButton2), for: .touchUpInside)
        
        return bt
    }()
    
    @objc
    private func userDidClickOnButton2() {
        let firstPage = FirstPage()
        present(firstPage, animated: true, completion: nil)
    }
    
    @objc private func handleNext() {
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red:249/255, green:207/255, blue: 133/255, alpha: 1)
        return pc
    }()
    
    fileprivate func setupButton() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(prevButton)
        view.addSubview(bottomControlsStackView)
        
        prevButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        prevButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
//        cell.bnCuteImageView.image = UIImage(named: page.imageName)
//        cell.descriptionTextView.text = page.headerText
        
//        let imageName = imageNames[indexPath.item]
//
//        cell.bnCuteImageView.image = UIImage(named: imageName)
//        cell.descriptionTextView.text = headStrings[indexPath.item]
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
