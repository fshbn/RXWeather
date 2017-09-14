//
//  WeatherIcon.swift
//  Weather
//
//  Created by Boran ASLAN on 13/05/2017.
//  Copyright © 2017 Boran ASLAN. All rights reserved.
//

import Foundation

struct WeatherIconModel {
    let iconText: String

    enum IconType: String, CustomStringConvertible {
        case day200
        case day201
        case day202
        case day210
        case day211
        case day212
        case day221
        case day230
        case day231
        case day232
        case day300
        case day301
        case day302
        case day310
        case day311
        case day312
        case day313
        case day314
        case day321
        case day500
        case day501
        case day502
        case day503
        case day504
        case day511
        case day520
        case day521
        case day522
        case day531
        case day600
        case day601
        case day602
        case day611
        case day612
        case day615
        case day616
        case day620
        case day621
        case day622
        case day701
        case day711
        case day721
        case day731
        case day741
        case day761
        case day762
        case day781
        case day800
        case day801
        case day802
        case day803
        case day804
        case day900
        case day902
        case day903
        case day904
        case day906
        case day957
        case night200
        case night201
        case night202
        case night210
        case night211
        case night212
        case night221
        case night230
        case night231
        case night232
        case night300
        case night301
        case night302
        case night310
        case night311
        case night312
        case night313
        case night314
        case night321
        case night500
        case night501
        case night502
        case night503
        case night504
        case night511
        case night520
        case night521
        case night522
        case night531
        case night600
        case night601
        case night602
        case night611
        case night612
        case night615
        case night616
        case night620
        case night621
        case night622
        case night701
        case night711
        case night721
        case night731
        case night741
        case night761
        case night762
        case night781
        case night800
        case night801
        case night802
        case night803
        case night804
        case night900
        case night902
        case night903
        case night904
        case night906
        case night957

        var description: String {
            switch self {
            case .day200: return "\u{f010}"
            case .day201: return "\u{f010}"
            case .day202: return "\u{f010}"
            case .day210: return "\u{f005}"
            case .day211: return "\u{f005}"
            case .day212: return "\u{f005}"
            case .day221: return "\u{f005}"
            case .day230: return "\u{f010}"
            case .day231: return "\u{f010}"
            case .day232: return "\u{f010}"
            case .day300: return "\u{f00b}"
            case .day301: return "\u{f00b}"
            case .day302: return "\u{f008}"
            case .day310: return "\u{f008}"
            case .day311: return "\u{f008}"
            case .day312: return "\u{f008}"
            case .day313: return "\u{f008}"
            case .day314: return "\u{f008}"
            case .day321: return "\u{f00b}"
            case .day500: return "\u{f00b}"
            case .day501: return "\u{f008}"
            case .day502: return "\u{f008}"
            case .day503: return "\u{f008}"
            case .day504: return "\u{f008}"
            case .day511: return "\u{f006}"
            case .day520: return "\u{f009}"
            case .day521: return "\u{f009}"
            case .day522: return "\u{f009}"
            case .day531: return "\u{f00e}"
            case .day600: return "\u{f00a}"
            case .day601: return "\u{f0b2}"
            case .day602: return "\u{f00a}"
            case .day611: return "\u{f006}"
            case .day612: return "\u{f006}"
            case .day615: return "\u{f006}"
            case .day616: return "\u{f006}"
            case .day620: return "\u{f006}"
            case .day621: return "\u{f00a}"
            case .day622: return "\u{f00a}"
            case .day701: return "\u{f009}"
            case .day711: return "\u{f062}"
            case .day721: return "\u{f0b6}"
            case .day731: return "\u{f063}"
            case .day741: return "\u{f003}"
            case .day761: return "\u{f063}"
            case .day762: return "\u{f063}"
            case .day781: return "\u{f056}"
            case .day800: return "\u{f00d}"
            case .day801: return "\u{f000}"
            case .day802: return "\u{f000}"
            case .day803: return "\u{f000}"
            case .day804: return "\u{f00c}"
            case .day900: return "\u{f056}"
            case .day902: return "\u{f073}"
            case .day903: return "\u{f076}"
            case .day904: return "\u{f072}"
            case .day906: return "\u{f004}"
            case .day957: return "\u{f050}"
            case .night200: return "\u{f02d}"
            case .night201: return "\u{f02d}"
            case .night202: return "\u{f02d}"
            case .night210: return "\u{f025}"
            case .night211: return "\u{f025}"
            case .night212: return "\u{f025}"
            case .night221: return "\u{f025}"
            case .night230: return "\u{f02d}"
            case .night231: return "\u{f02d}"
            case .night232: return "\u{f02d}"
            case .night300: return "\u{f02b}"
            case .night301: return "\u{f02b}"
            case .night302: return "\u{f028}"
            case .night310: return "\u{f028}"
            case .night311: return "\u{f028}"
            case .night312: return "\u{f028}"
            case .night313: return "\u{f028}"
            case .night314: return "\u{f028}"
            case .night321: return "\u{f02b}"
            case .night500: return "\u{f02b}"
            case .night501: return "\u{f028}"
            case .night502: return "\u{f028}"
            case .night503: return "\u{f028}"
            case .night504: return "\u{f028}"
            case .night511: return "\u{f026}"
            case .night520: return "\u{f029}"
            case .night521: return "\u{f029}"
            case .night522: return "\u{f029}"
            case .night531: return "\u{f02c}"
            case .night600: return "\u{f02a}"
            case .night601: return "\u{f0b4}"
            case .night602: return "\u{f02a}"
            case .night611: return "\u{f026}"
            case .night612: return "\u{f026}"
            case .night615: return "\u{f026}"
            case .night616: return "\u{f026}"
            case .night620: return "\u{f026}"
            case .night621: return "\u{f02a}"
            case .night622: return "\u{f02a}"
            case .night701: return "\u{f029}"
            case .night711: return "\u{f062}"
            case .night721: return "\u{f0b6}"
            case .night731: return "\u{f063}"
            case .night741: return "\u{f04a}"
            case .night761: return "\u{f063}"
            case .night762: return "\u{f063}"
            case .night781: return "\u{f056}"
            case .night800: return "\u{f02e}"
            case .night801: return "\u{f022}"
            case .night802: return "\u{f022}"
            case .night803: return "\u{f022}"
            case .night804: return "\u{f086}"
            case .night900: return "\u{f056}"
            case .night902: return "\u{f073}"
            case .night903: return "\u{f076}"
            case .night904: return "\u{f072}"
            case .night906: return "\u{f024}"
            case .night957: return "\u{f050}"
            }
        }
    }

    init(condition: Int, iconString: String) {
        var rawValue: String

        // if iconString has 'n', it means night time.
        if iconString.range(of: "n") != nil {
            rawValue = "night" + String(condition)
        } else {
            // day time
            rawValue = "day" + String(condition)
        }

        guard let iconType = IconType(rawValue: rawValue) else {
            iconText = ""
            return
        }
        iconText = iconType.description
    }
}
