//
//  StorageService.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 16/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import Foundation
import RealmSwift

/// Controls the storage and retreival of user notes
protocol StorageServiceProviding {
    /// Store note in the database list
    func store(note: Domain.Note)

    /// Configures the async retrieval of stored notes
    func configure(completion: @escaping (Result<[Domain.Note], Error>) -> Void)
}

final class StorageService: NSObject, StorageServiceProviding {
    // MARK: Constants

    /// Represents the namespace for storage service constants
    enum Constants {
        /// The realm instance address for the app
        static let instanceAddress = "vladusiclandmarkremark.us1.cloud.realm.io"

        /// The auth url for the app
        static let authUrl = URL(string: "https://\(instanceAddress)")!

        /// The realm url for the app
        static let realmUrl = URL(string: "realms://\(instanceAddress)/VladusicLandmarkRemark")!
    }

    // MARK: Properties

    let name = "tony"
    lazy var credentials = SyncCredentials.nickname(name, isAdmin: true)
    var realm: Realm?
    var lists: Results<RealmList>?
    var subscriptionToken: NotificationToken?
    var subscription: SyncSubscription<RealmList>?

    // MARK: Lifecycle

    deinit {
        subscriptionToken?.invalidate()
    }

    // MARK: StorageServiceProviding

    func store(note: Domain.Note) {
        /// If a list exists add the note to it else create a new list
        if let lists = lists,
            !lists.isEmpty,
            !lists.isInvalidated {
            // do nothing here, fall through to adding note below
        } else {
            do {
                try realm?.write {
                    let list = RealmList()
                    // We can safely bang here, as we've set default property values
                    list.owner = SyncUser.current!.identity!
                    list.name = name
                    self.realm?.add(list)
                }
            } catch {
                // TODO: handle or throw exception
            }
        }

        // Add the note to storage
        do {
            try realm?.write {
                let realmNote = RealmNote()
                realmNote.message = note.message
                realmNote.userName = note.user.name
                realmNote.latitude = note.location.latitude
                realmNote.longitude = note.location.longitude

                if let list = lists?.first {
                    list.notes.append(realmNote)
                    self.realm?.add(list)
                }
            }
        } catch {
            // TODO: handle or throw exception
        }
    }

    func configure(completion: @escaping (Result<[Domain.Note], Error>) -> Void) {
        // Login to realm to get the stored notes for the default user
        SyncUser.logIn(with: credentials, server: Constants.authUrl) { [weak self] user, error in
            guard let self = self,
                let _ = user,
                error == nil,
                let configuration = SyncUser.current?.configuration(),
                let syncUser = SyncUser.current?.identity
            else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            self.realm = try? Realm(configuration: configuration)
            self.lists = self.realm?.objects(RealmList.self).filter("owner = %@", syncUser).sorted(byKeyPath: "timestamp", ascending: false)
            self.subscription = self.lists?.subscribe(named: "my-lists")
            // TODO: show an activity indicator to while waiting for the subscription to be processed
            self.subscriptionToken = self.subscription?.observe(\.state, options: .initial) { state in
                switch state {
                case .creating, .pending:
                    // do nothing until state returns as complete
                    break
                case .complete:
                    var domainNotes: [Domain.Note] = []
                    if let list = self.lists?.first {
                        list.notes.forEach { note in
                            let domainNote = Domain.Note(message: note.message, user: Domain.User(name: note.userName), location: Domain.Location(latitude: note.latitude, longitude: note.longitude))
                            domainNotes.append(domainNote)
                        }
                    }
                    completion(.success(domainNotes))
                // TODO: remove activity indicator
                case .invalidated:
                    // TODO: Handle invalid responses
                    break
                case let .error(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
