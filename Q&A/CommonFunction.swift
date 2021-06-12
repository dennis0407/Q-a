//
//  CommonFunction.swift
//  Q&A
//
//  Created by Dennis Lin on 2021/6/5.
//

import Foundation
import UIKit
func produceBackground(_ frame: CGRect)-> UIImageView{
    
    let backgroundImage = UIImage(named: "background")
    let ImageView = UIImageView(image: backgroundImage)
    ImageView.frame = frame
    
    return ImageView
}

