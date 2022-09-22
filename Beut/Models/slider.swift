//
//  Slider.swift
//  Esfenja
//
//  Created by ProjectEgy on 04/07/2022.
//

import Foundation
import UIKit

struct Slider:Decodable{
    var sliderDTOs:[SingleSlide]?
    var secondSliderDTOs:[SingleSlide]?
    enum CodingKeys: String, CodingKey {
        case sliderDTOs = "SliderDTOs"
        case secondSliderDTOs = "SecondSliderDTOs"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sliderDTOs = try values.decodeIfPresent([SingleSlide].self, forKey: .sliderDTOs)
        secondSliderDTOs = try values.decodeIfPresent([SingleSlide].self, forKey: .secondSliderDTOs)
    }
    
}

struct SingleSlide:Decodable{
    var id:Int?
    var image:String?
    var storeId:Int?
    var sortingNumber:Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case image = "Image"
        case storeId = "StoreId"
        case sortingNumber = "SortingNumber"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        storeId = try values.decodeIfPresent(Int.self, forKey: .storeId)
        sortingNumber = try values.decodeIfPresent(Int.self, forKey: .sortingNumber)
    }
}
