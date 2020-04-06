//
//  OnBoardingViewController.swift
//  Onboarding
//
//  Created by Christophe Hoste on 28.03.20.
//  Copyright © 2020 Christophe Hoste. All rights reserved.
//
// swiftlint:disable line_length multiple_closures_with_trailing_closure

import UIKit

class OnBoardingViewController: UIViewController {

    let tabBar: UITabBar
    let numberOfItems: Int

    let titles = ["Home", "About", "Trending", "Settings"]
    let subTitles = [
        "Learn stuff about the Home-Tab: Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
        "Learn stuff about the About-Tab: Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        "Learn stuff about the Trending-Tab: Lorem Ipsum has been the industry's standard, printer took a galley of type and scrambled it to make a type specimen book.",
        "Learn stuff about the Settings-Tab: it to make a type specimen book."]

    let onBoardingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.alpha = 0.8
        view.constrainHeight(constant: 300)
        return view
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        button.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        button.constrainWidth(constant: 44)
        button.constrainHeight(constant: 44)
        button.tintColor = .black
        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(next(_:)), for: .touchUpInside)
        button.constrainHeight(constant: 44)
        button.constrainWidth(constant: 70)
        return button
    }()

    let prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(prev(_:)), for: .touchUpInside)
        button.constrainHeight(constant: 44)
        button.constrainWidth(constant: 70)
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    let subLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        return label
    }()

    init(forTabbar: UITabBar, numberOfItems: Int) {
        self.tabBar = forTabbar
        self.numberOfItems = numberOfItems
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        setupOnBoardingView()
        setupTopControls()
        cutItem(0)
    }

    func setupTopControls() {
        let closeStackView = UIStackView(arrangedSubviews: [closeButton, prevButton, UIView(), nextButton])
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, subLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 8
        textStackView.isLayoutMarginsRelativeArrangement = true
        textStackView.layoutMargins = .init(top: 0, left: 32, bottom: 32, right: 32)
        let stackView = UIStackView(arrangedSubviews: [closeStackView, textStackView])
        stackView.axis = .vertical
        onBoardingView.addSubview(stackView)

        stackView.anchor(top: onBoardingView.topAnchor,
                         leading: onBoardingView.leadingAnchor,
                         bottom: onBoardingView.bottomAnchor,
                         trailing: onBoardingView.trailingAnchor,
                         padding: .init(top: 8, left: 8, bottom: tabBar.frame.height, right: 8))
    }

    func setupOnBoardingView() {
        view.addSubview(onBoardingView)
        onBoardingView.anchor(top: nil,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor)
    }

    func cutItem(_ atIndex: Int) {
        updateControls(atIndex)
        let itemFrame = tabBar.getFrameForTabAt(index: atIndex)

        guard let safeItemFrame = itemFrame else {
            return
        }

        let heightOffSet: CGFloat = 5
        let wishWidth: CGFloat = 80
        let diffWidth = (safeItemFrame.width - wishWidth)/2

        onBoardingView.layoutIfNeeded()
        let newRect: CGRect = .init(x: safeItemFrame.origin.x + diffWidth,
                                    y: safeItemFrame.origin.y + (onBoardingView.frame.height - tabBar.frame.height - heightOffSet),
                                    width: wishWidth,
                                    height: safeItemFrame.height + 15)

        onBoardingView.cutHole(atRect: newRect)
    }

    func updateControls(_ index: Int) {
        nextButton.tag = index
        prevButton.tag = index

        titleLabel.text = titles[index]
        subLabel.text = subTitles[index]

        if index == 0 {
            prevButton.isHidden = true
        } else {
            prevButton.isHidden = false
        }

        if index == numberOfItems - 1 {
            nextButton.setTitle("Done", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingViewController {
    @objc
    func close(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.onBoardingView.transform = CGAffineTransform(translationX: 0, y: self.onBoardingView.frame.height)
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }

    @objc
    func next(_ sender: UIButton) {
        sender.tag += 1
        if sender.tag == numberOfItems {
            closeButton.sendActions(for: .touchUpInside)
            return
        }
        cutItem(sender.tag)
    }

    @objc
    func prev(_ sender: UIButton) {
        sender.tag -= 1
        cutItem(sender.tag)
    }
}
