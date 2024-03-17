//
//  ViewController.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 16/3/24.
//

import UIKit
import Lottie
import ViewAnimator

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButon: UIButton!
    
    @IBOutlet weak var location: LottieAnimationView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherIconIamge: UIImageView!
    @IBOutlet weak var weatherDesc: UILabel!
    
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!

    @IBOutlet weak var dailyWeather: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            registerCell()
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.delegate = self
            collectionView.dataSource = self
           
            // collection flow layout
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
        }
    }
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var shadowThreeView: UIView!
    @IBOutlet weak var shadowTwoView: UIView!
    @IBOutlet weak var shadowOneView: UIView!

    
    var viewModel: WeatherHomeVMP? = WeatherHomeViewModel()
    var weatherTime : String =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // loading the lottie animation
        location.play()
        viewModel?.delegate = self
        searchTextField.delegate = self
        viewModel?.onViewLoaded()
//        collectionViewAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // animations
        viewAnimation(view: shadowThreeView,
                      duration: 0.3)
        viewAnimation(view: shadowTwoView,
                      duration: 0.8)
        viewAnimation(view: shadowOneView,
                      duration: 1.3)
        viewAnimation(view: dailyWeather,
                      duration: 1.8)
    }
    
    private func updateView() {
        var cornerRadius: CGFloat = 50
        [dailyWeather,
         shadowOneView,
         shadowTwoView,
         shadowThreeView].forEach({ view in
            guard let view = view else { return }
            view.layer.masksToBounds = false
            view.layer.cornerRadius = cornerRadius - 5.0
            cornerRadius = view.layer.cornerRadius
            view.clipsToBounds = true
        })
    }
    
    private func registerCell() {
        collectionView.register(nibWithCellClass: WeatherCollectionCell.self,
                                at: WeatherCollectionCell.self)
    }
    
    func viewAnimation(view: UIView,
                       duration: TimeInterval) {
        let transform = CGAffineTransform(translationX: 0,
                                          y: -30)
        UIView.animate(withDuration: 0.3,
                       animations:  {
            view.transform = transform
        }, completion: nil)
    }
    
    func collectionViewAnimation() {
        let animation = AnimationType.zoom(scale: 0.5)
        UIView.animate(views : self.collectionView.visibleCells,
                       animations: [animation])
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let searchText = searchTextField.text else { return }
        if (searchText.isEmpty) {
            loadErrorViewController()
            searchTextField.text = ""
            return
        } else {
            if let searching =  searchTextField.text?.lowercased() {
                viewModel?.fetchWeather(for: searching)
            }
            searchTextField.endEditing(true)
        }
    }
}

// textfield delegate
extension WeatherViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
       // print(search.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Enter the city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
}

//Collection view delegate and datasource
extension WeatherViewController: UICollectionViewDelegate,
                                 UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.forecastList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.identifier,
                                                      for: indexPath) as! WeatherCollectionCell
        let weatherForecast = viewModel?.forecastList?[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateString = weatherForecast?.datetime,
              let date = dateFormatter.date(from: dateString) else { return cell }
        
        dateFormatter.dateFormat = "MMM d"
        dateFormatter.locale = Locale(identifier: "en")
        
    
        cell.setUp(day: dateFormatter.string(from: date),
                   image: UIImage(systemName: (weatherForecast?.weather?.getIcon()) ?? "") ?? UIImage(),
                   temp: "\(weatherForecast?.temp ?? 0)°")
        return cell
    }
}

// collection view flow layout
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func reloadCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.collectionView.reloadData()
            self.collectionView.performBatchUpdates({
                self.collectionViewAnimation()
            })
        })
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5,
                            left: 5,
                            bottom: 5,
                            right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let cellWidth = (width-20) / 3
        return CGSize(width: cellWidth  ,
                      height: cellWidth*1.2)
    }
}

extension WeatherViewController: WeatherHomeVMViewDelegate {
    func didFetchWeatherSuccessfully(with weather: WeatherData) {
        // since view need to update, calling the main thread for this
        DispatchQueue.main.async { [weak self] in
            self?.updateBGImage(timeZone: weather.timezone ?? "")
            self?.cityNameLabel.text = weather.cityName
            // need to check
            self?.dateLabel.text = self?.weatherTime
            self?.weatherTempLabel.text = weather.appTemp?.doubleToString
            self?.weatherIconIamge.image = UIImage(systemName: (weather.weatherDesc?.getIcon())!)
            self?.weatherDesc.text = weather.weatherDesc?.description
            self?.sunsetLabel.text = weather.sunrise
            self?.windyLabel.text = String(format: "%0.2f", weather.windSpd ?? 0.0) + "m/s"
            self?.cloudLabel.text = "\(weather.clouds ?? 0) %"
        }
    }
    
    func updateBGImage(timeZone: String) {
        let date = Date()
        let formattedDateString = String.dateString(from: date,
                                                    timeZone: timeZone)
        weatherTime = formattedDateString.dateStr
        
        formattedDateString.dateFormatter.dateFormat = "HH"
        let stringHour = formattedDateString.dateStr
        let hour = Int(stringHour) ?? 0
        
        switch hour {
        case 5...18:
            self.backgroundImage.image = UIImage(named:"Daytime")
        case 18...24:
            self.backgroundImage.image = UIImage(named: "NightDay")
        default:
            self.backgroundImage.image = UIImage(named:"NightDay")
        }
    }
    
    func didFailToFetchWeather(with error: Error) {
        loadErrorViewController ()
    }
    
    func loadErrorViewController () {
        DispatchQueue.main.async { [weak self] in
            // Present the popup view controller
            let storyboard = UIStoryboard(name: "ErrorScreen",
                                          bundle: nil)
            guard let popupVC = storyboard.instantiateViewController(withIdentifier: "ErrorViewController") as? ErrorViewController else {
                return
            }
            popupVC.modalPresentationStyle = .overFullScreen
            self?.present(popupVC, animated: true, completion: nil)
        }
    }
    
    func didFailToFetchForecast(with error: Error) {
        loadErrorViewController ()
    }
    
    func didFetchforecastSuccessfully() {
        reloadCollectionView()
    }
}
