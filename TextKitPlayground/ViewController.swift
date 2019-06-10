//
//  ViewController.swift
//  TextKitPlayground
//
//  Created by Alexander Ney on 9/6/19.
//  Copyright © 2019 Alexander Ney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textStorage = TextStorage()
    let layoutManager = LayoutManager()
    let textContainerA =  TextContainer(size: CGSize(width: 100, height: 100))
    let textContainerB =  TextContainer(size: CGSize(width: 100, height: 100))
    var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //textContainer.widthTracksTextView = false

        layoutManager.addTextContainer(textContainerA)
        //layoutManager.addTextContainer(textContainerB)
        textStorage.addLayoutManager(layoutManager)
        textStorage.append(NSAttributedString(string: "test"))

        textView = UITextView(frame: CGRect.zero, textContainer: textContainerA)
        //textView.layoutManager.addTextContainer(textContainerB)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true


        //textView.font = UIFont.preferredFont(forTextStyle: .body)
        //textView.textColor = UIColor.blue
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
}

class TextContainer: NSTextContainer {


    override func lineFragmentRect(forProposedRect proposedRect: CGRect, at characterIndex: Int, writingDirection baseWritingDirection: NSWritingDirection, remaining remainingRect: UnsafeMutablePointer<CGRect>?) -> CGRect {

        let rect = super.lineFragmentRect(forProposedRect: proposedRect, at: characterIndex, writingDirection: baseWritingDirection, remaining: remainingRect)

        print(characterIndex, rect)
        return CGRect(x: 100, y: rect.origin.y, width: 100, height: rect.height)
    }

    override var isSimpleRectangularTextContainer: Bool {
        return true
    }
}

let tesString = """
Open TimeIndicatorView.swift and take look at curvePathWithOrigin(_:). The time indicator view uses this code when filling its background. You can also use it to determine the path around which you’ll flow your text. That’s why the calculation of the Bezier curve is broken out into its own method. Open TimeIndicatorView.swift and take look at curvePathWithOrigin(_:). The time indicator view uses this code when filling its background. You can also use it to determine the path around which you’ll flow your text. That’s why the calculation of the Bezier curve is broken out into its own method.
"""

class TextStorage: NSTextStorage {

    var backingStore = NSMutableAttributedString(string: tesString)

    override init() {
        super.init()

        let attrs: [NSAttributedString.Key : Any] = [
            .font : UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: UIColor.red
        ]

        let fullRange = NSRange(location: 0, length: backingStore.string.count)
        backingStore.setAttributes(attrs, range: fullRange)
    }

    override var string: String {
        return backingStore.string
    }

    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedString.Key : Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func replaceCharacters(in range: NSRange, with str: String) {
        print(#function)

        /*
        beginEditing()
        backingStore.replaceCharacters(in: range, with:str)
        edited(.editedCharacters, range: range,
               changeInLength: (str as NSString).length - range.length)
        endEditing()
 */
    }

    override func setAttributes(_ attrs: [NSAttributedString.Key : Any]?, range: NSRange) {
        print(#function)
/*
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
 */
    }
}

class LayoutManager: NSLayoutManager {

}
