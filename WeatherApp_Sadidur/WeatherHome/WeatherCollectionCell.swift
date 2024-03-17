//
//  WeatherCollectionCell.swift
//  WeatherApp_Sadidur
//
//  Created by Md Sadidur Rahman on 17/3/24.
//

import UIKit

class WeatherCollectionCell: UICollectionViewCell {
    static let identifier = "WeatherCollectionCell"
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDay: UILabel!
    @IBOutlet weak var weatherTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(day: String,
               image: UIImage,
               temp: String) {
        weatherImage.image = image
        weatherDay.text = day
        weatherTemp.text = temp
    }
}
