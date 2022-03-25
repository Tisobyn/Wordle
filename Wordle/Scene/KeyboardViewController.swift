//
//  KeyboardViewController.swift
//  Wordle
//
//  Created by Yermek Sabyrzhan on 24.03.2022.
//

import UIKit

final class KeyboardViewController: UIViewController {
    private let letters = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
    private var keys: [[Character]] = []

    let keyboard: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboard()
    }

    private func addKeyboard() {
        view.addSubview(keyboard)
        keyboard.delegate = self
        keyboard.dataSource = self
        NSLayoutConstraint.activate([
            keyboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboard.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            keyboard.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        for rows in letters {
            let chars = Array(rows)
            keys.append(chars)
        }
    }

}

extension KeyboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: KeyCell.identifier,
            for: indexPath) as? KeyCell
        else { fatalError() }
        cell.configure(with: keys[indexPath.section][indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10
        return CGSize(width: size, height: size*1.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var left: CGFloat = 1
        var right: CGFloat = 1
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))

        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/10
        let inset: CGFloat = (collectionView.frame.size.width - (size*count) - (2*count))/2
        left = inset
        right = inset

        return UIEdgeInsets(top:  2, left: left, bottom: 2, right: right)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

}
