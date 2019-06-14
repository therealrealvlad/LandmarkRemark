//
//  MapInteractor.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 14/6/19.
//  Copyright (c) 2019 therealrealvlad. All rights reserved.

import UIKit

protocol MapInteracting {
    func perform(request: Map.RequestModel)
}

final class MapInteractor: MapInteracting {
    // MARK: Properties

    let presenter: MapPresenting
    let worker: MapWorking
    let router: MapRouting

    // MARK: Lifecycle

    init(presenter: MapPresenting, worker: MapWorking, router: MapRouting) {
        self.presenter = presenter
        self.worker = worker
        self.router = router
    }

    // MARK: Perform

    func perform(request _: Map.RequestModel) {
        worker.perform()
        let domainModel = Map.DomainModel()
        let viewModel = Map.ViewModel()
        presenter.present(viewModel: viewModel)
    }
}
