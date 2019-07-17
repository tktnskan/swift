//
//  swipingViewController.swift
//  swipeAutoLayout
//
//  Created by Jinyung Yoon on 09/07/2019.
//  Copyright © 2019 Jinyung Yoon. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class FirstPage: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let API_KEY = "2c313abc6b9408365cd1a1badd61bf9f"
    
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    private var homeButton: UIButton = {
        let hB = UIButton(type: .system)
        hB.setTitle("BACK", for: .normal)
        hB.setTitleColor(.white, for: .normal)
        hB.backgroundColor = UIColor.black
        hB.layer.cornerRadius = 5
        hB.translatesAutoresizingMaskIntoConstraints = false
        
        return hB
    }()
    
    private var cityLabel: UILabel! = {
        let cL = UILabel()
        cL.text = "city Label"
        cL.contentMode = .scaleAspectFit
        cL.translatesAutoresizingMaskIntoConstraints = false
        return cL
    }()
    
    private var tempLabel: UILabel! = {
        let tL = UILabel()
        tL.text = "temperature Label"
        tL.contentMode = .scaleAspectFit
        tL.translatesAutoresizingMaskIntoConstraints = false
        return tL
    }()
    
    private var weatherIcon: UIImageView! = {
        let wI = UIImageView()
        wI.translatesAutoresizingMaskIntoConstraints = false
        return wI
    }()
    
    private let searchButton: UIButton! = {
        let sB = UIButton(type: .system)
        sB.setTitle("search", for: .normal)
        sB.setTitleColor(.blue, for: .normal)
        sB.translatesAutoresizingMaskIntoConstraints = false
        return sB
    }()
    
    private var searchCity: UITextField! = {
        let sC = UITextField()
        sC.sizeThatFits(CGSize(width: 120, height: 30))
        sC.borderStyle = .roundedRect
        sC.clearButtonMode = .whileEditing
        sC.placeholder = "Search cities"
        sC.translatesAutoresizingMaskIntoConstraints = false
        return sC
    }()
    
    private let imageView: UIImageView! = {
        let iv = UIImageView()
        let bC = UIImage(named: "bn_cute")
        let resizedImage = bC!.resized(to: CGSize(width: 200, height: 200))
        iv.image = resizedImage
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    
    var pickedImage = false
    let imagePicker = UIImagePickerController()
    
//    func savePhoto(imageData: Notes) {
//        do {
//            try realm.write {
//                realm.add(imageData)
//            }
//        } catch {
//            print("error")
//        }
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                    imageView.contentMode = .scaleAspectFit
                    let resizedImage = image.resized(to: CGSize(width: 200, height: 200))
                    imageView.image = resizedImage
                    print("image saved")
            }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private let button: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("click here", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        return bt
    }()
    
    private let button2: UIButton = {
        let bt2 = UIButton(type: .system)
        bt2.setTitle("choose image", for: .normal)
        bt2.setTitleColor(.red, for: .normal)
        return bt2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        setupUI()
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        addTargets()
        imagePicker.delegate = self
    }
    
    // Networking
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "load failed"
                self.tempLabel.text = "load failed"
            }
        }
    }
    
    func updateWeatherData(json: JSON) {
        let tempResult  = json["main"]["temp"].doubleValue
        
        weatherDataModel.temperature = Int(tempResult - 273.15)
        
        weatherDataModel.city = json["name"].stringValue
        
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        updateUIWithWeatherData()
            
//        } else {
//            cityLabel.text = "weather Unavailable"
//            tempLabel.text = "temperatue Unavailable"
//        }
    }
    
    func updateUIWithWeatherData() {
        if weatherDataModel.city == "" {
            cityLabel.text = "City not found"
            tempLabel.text = ""
        } else {
            cityLabel.text = weatherDataModel.city
            tempLabel.text = "\(weatherDataModel.temperature) °C"
        }
        
        let wC = UIImage(named: weatherDataModel.weatherIconName)
        let resizedImage = wC!.resized(to: CGSize(width: 30, height: 30))
        weatherIcon.image = resizedImage
        
    }
    
    
    // Location manager delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String: String] = ["lat" : latitude, "lon" : longitude, "appid" : API_KEY]
            
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    

    @objc
    private func userDidClickOnButton() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = SwipingController(collectionViewLayout: layout)
        present(swipingController, animated: true, completion: nil)
    }
    
    @objc
    private func userDidClickOnButton2() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc
    private func userDidClickOnButoon3() {
        
        let inputCity = searchCity.text!
        if (inputCity != "") {
            let cityName : [String: String] = ["q" : inputCity, "appid" : API_KEY]
            
            getWeatherData(url: WEATHER_URL, parameters: cityName)
            self.view.endEditing(true)
            searchCity.text = ""
            print(searchCity!)
        }
    }
    
    @objc
    private func userClickHome() {
        let Intro = IntroController()
        
        present(Intro, animated: true, completion: nil)
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(homeButton)
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(cityLabel)
        view.addSubview(tempLabel)
        view.addSubview(weatherIcon)
        view.addSubview(searchCity)
        view.addSubview(searchButton)
        
        homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        
        searchCity.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        searchCity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30).isActive = true
        searchButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        searchButton.rightAnchor.constraint(equalTo: searchCity.rightAnchor, constant: 60).isActive = true
        
        
        cityLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 60).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -15).isActive = true
        weatherIcon.topAnchor.constraint(equalTo: cityLabel.bottomAnchor).isActive = true
        weatherIcon.leftAnchor.constraint(equalTo: tempLabel.leftAnchor, constant: 45).isActive = true

//
        button2.frame = CGRect(x: view.frame.width / 2 - 100, y: 50, width: 200, height: 30)
        button.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height - 60, width: 200, height: 30)
    }

    private func addTargets() {
        button.addTarget(self, action: #selector(userDidClickOnButton), for: .touchUpInside)
        button2.addTarget(self, action: #selector(userDidClickOnButton2), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(userDidClickOnButoon3), for: .touchUpInside)
        homeButton.addTarget(self, action: #selector(userClickHome), for: .touchUpInside)
    }
    
    
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
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
        bt.setTitle("BACK", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = UIColor.black
        bt.layer.cornerRadius = 5
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
        
        prevButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        prevButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        
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

