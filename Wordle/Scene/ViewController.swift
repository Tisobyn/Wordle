//
//  ViewController.swift
//  Wordle
//
//  Created by Yermek Sabyrzhan on 24.03.2022.
//

import UIKit

class ViewController: UIViewController {

    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

    }

    private func addChildren() {
       addKeyboardVC()
       addBoardVC()
    }

    private func addKeyboardVC() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
    }

    private func addBoardVC() {
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
    }

    private func addConstraints() {
        
    }

}

