//
//  CustomTextView.swift
//  NotesApp
//
//  Created by Alexander Altman on 13.03.2023.
//

import UIKit

class CustomtextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Theme.appcolor
        let font = UIFont.systemFont(ofSize: 20)
        self.font = font
        self.autocorrectionType = .no
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
