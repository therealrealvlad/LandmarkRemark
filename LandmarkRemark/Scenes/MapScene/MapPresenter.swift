//
//  MapPresenter.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

protocol MapPresenting {
    func present(viewModel: Map.ViewModel)
}

class MapPresenter: MapPresenting {
    // MARK: Properties

    /// The interactor maintains a weak reference to the view controller, thereby preventing a memory retention cycle from forming in the VIP cycle: one of the major advantages of the VIP pattern is that the system's memory allocation for the entire scene is disposed when the view controller is destroyed
    weak var viewController: MapDisplaying?

    // MARK: Lifecycle

    init(viewController: MapDisplaying) {
        self.viewController = viewController
    }

    // MARK: Presentation

    func present(viewModel: Map.ViewModel) {
        viewController?.display(viewModel: viewModel)
    }
}
