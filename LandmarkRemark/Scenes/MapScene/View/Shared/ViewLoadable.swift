//
//  ViewLoadable.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 16/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import UIKit

protocol ViewLoadable: UIView {
    static var nib: UINib { get }
    static func loadView() -> Self
}

extension ViewLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static func loadView() -> Self {
        guard let view = nib.instantiate(withOwner: String(describing: self).self, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
