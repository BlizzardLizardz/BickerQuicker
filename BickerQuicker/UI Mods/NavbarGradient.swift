//
//  NavBarGradient.swift
//  BickerQuicker
//
//  Created by Harjas Monga on 4/2/18.
//  Copyright © 2018 Jonathan Grider. All rights reserved.
//

import Foundation

extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.width += self.frame.origin.x
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
    }
}
