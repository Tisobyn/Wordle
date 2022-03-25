//
//  ViewController.swift
//  Wordle
//
//  Created by Yermek Sabyrzhan on 24.03.2022.
//

import UIKit

final class ViewController: UIViewController {
    let answer = "after"
    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 5),
        count: 6)

    private let keyboardVC = KeyboardViewController()
    private let boardVC = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildren() 
    }

    // MARK: - UI Setting Functions

    private func addChildren() {
       addKeyboardVC()
       addBoardVC()
       setConstraints()
    }

    private func addKeyboardVC() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
    }

    private func addBoardVC() {
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.dataSource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop { break }
        }

        boardVC.reloadData()
    }
}

extension ViewController: BoardViewControllerDataSource {
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        guard isFilled(rowIndex: indexPath.section) else { return nil}
        guard let letter = guesses[indexPath.section][indexPath.row] else { return nil }
        let indexedAnswer = Array(answer)
        if indexedAnswer[indexPath.row] == letter { return .systemGreen }
        if indexedAnswer.contains(letter) { return .systemOrange }
        return .systemGray3
    }

    private func isFilled(rowIndex: Int) -> Bool{
        let count = guesses[rowIndex].compactMap { $0 }.count
        return count == 5
    }

    var currentGuesses: [[Character?]] {
        return guesses
    }

}

