//
//  UIStoryboard+Extension.swift
//  RXWeather
//
//  Created by Zafer Caliskan on 02/06/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        if UIDevice.current.userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height < 568.0 {
            return UIStoryboard(name: "Main_iPhone4", bundle: nil)
        }

        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIStoryboard {
}
