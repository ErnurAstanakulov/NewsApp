//
//  ImageProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

public protocol ImageProtocol {
    
    /// Image asset value
    var rawValue: String { get }
    
    /// Image related bundle
    var bundle: Bundle? { get }
}

public extension ImageProtocol {
    
    /// Get value as **UIImage**
    var uiImage: UIImage? {
        if let bundle = bundle {
            return UIImage(named: rawValue, in: bundle, compatibleWith: nil)
        }
        return UIImage(named: rawValue)
    }
    
    /// Get value as **CGImage**
    var cgImage: CGImage? { return self.uiImage?.cgImage }
    
    var templateImage: UIImage? {
        return UIImage(named: rawValue)?.withRenderingMode(.alwaysTemplate)
    }
    
    var originalImage: UIImage? {
        return UIImage(named: rawValue)?.withRenderingMode(.alwaysOriginal)
    }
}

