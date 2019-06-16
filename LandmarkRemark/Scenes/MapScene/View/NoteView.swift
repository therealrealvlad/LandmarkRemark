//
//  NoteView.swift
//  LandmarkRemark
//
//  Created by therealrealvlad on 16/6/19.
//  Copyright © 2019 therealrealvlad. All rights reserved.
//

import UIKit

protocol NoteConfigurable {
    /// Ensures the view is configured with an action returning an optional note
    func configure(with action: ((Map.ViewModel.Note?) -> Void)?)
}

final class NoteView: UIView, ViewLoadable, UITextFieldDelegate, NoteConfigurable {
    // MARK: Outlets

    @IBOutlet var noteTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!

    // MARK: Actions

    @IBAction func didTapDone(_: UIButton) {
        dismiss()
    }

    @IBAction func didTapCancel(_: UIButton) {
        action?(nil)
        removeFromSuperview()
    }

    // MARK: Properties

    var action: ((Map.ViewModel.Note?) -> Void)?

    // MARK: NoteConfigurable

    func configure(with action: ((Map.ViewModel.Note?) -> Void)?) {
        self.action = action
    }

    // MARK: UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case noteTextField:
            userNameTextField.becomeFirstResponder()
        case userNameTextField:
            userNameTextField.resignFirstResponder()
            dismiss()
            return true
        default:
            textField.resignFirstResponder()
        }
        return false
    }

    // MARK: Private helpers

    private func dismiss() {
        guard let message = noteTextField.text,
            let userName = userNameTextField.text,
            !message.isEmpty,
            !userName.isEmpty else {
            // TODO: Show alert to advise user to complete all text fields or else cancel
            return
        }
        let note = Map.ViewModel.Note(message: message, userName: userName)
        action?(note)
        removeFromSuperview()
    }
}
