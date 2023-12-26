//
//  ViewController.swift
//  swiftui-study-again
//
//  Created by sudo.park on 2022/01/31.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupLabel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("will set text")
            
            var attrText = self.makeAttributeText()
            attrText = self.replaceEllipsisWithBadgeIfNeed(attrText)
            self.label.attributedText = attrText
        }
    }
    
    private func setupLabel() {
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        label.numberOfLines = 3
    }
    
    private var paragraphStyle: NSMutableParagraphStyle {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 24
        style.maximumLineHeight = 24
        style.firstLineHeadIndent = 50
        style.lineBreakMode = .byWordWrapping
        style.alignment = .natural
        return style
    }
    
    private func textAttribute(shouldTruncate: Bool) -> [NSAttributedString.Key: Any] {
        var attribute: [NSAttributedString.Key: Any] = [:]
        let font = UIFont.systemFont(ofSize: 16)
        let style = self.paragraphStyle
        if shouldTruncate {
            style.lineBreakMode = .byTruncatingTail
        }
        attribute[.paragraphStyle] = style
        attribute[.baselineOffset] = (24 - font.lineHeight) / 4
        attribute[.font] = font
        return attribute
    }

    private func makeAttributeText() -> NSAttributedString {
        let text = """
        I came across a requirement from the product team earlier today where they want to display a UTC date in the format: April 30th, 2021 (Vancouver Time), and it should be localized to the device’s active locale.
        After some research, it is clear that the Foundation framework already comes equipped with the common operations you would do with time zones.
        According to Apple’s documentation, you would use a TimeZone to:
        """
//        let text = """
//        I came across a requirement
//        """
//        let text = """
//        ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt1231234568906
//        """
        let sender = NSMutableAttributedString(string: text, attributes: self.textAttribute(shouldTruncate: false))
        sender.append(self.badge())
        return sender
    }
    
    private func badge() -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "n.square.fill")
        attachment.bounds = .init(x: 0, y: 0, width: 16, height: 16)
        let image = NSAttributedString(attachment: attachment)
        return image
    }
    
    private var ellipsis: NSAttributedString {
        return NSAttributedString(string: "...", attributes: self.textAttribute(shouldTruncate: true))
    }
    
    private func badgeWithEllipsis() -> NSAttributedString {
        
        let ellipsis = NSAttributedString(string: "...", attributes: self.textAttribute(shouldTruncate: true))
        
        let image = self.badge()
        
        let sender = NSMutableAttributedString()
        sender.append(ellipsis)
        sender.append(image)
        return sender
    }
    
    private func replaceEllipsisWithBadgeIfNeed(_ text: NSAttributedString) -> NSAttributedString  {
        let width = self.label.bounds.width
        
        let storage = NSTextStorage()
        storage.setAttributedString(text)
        
        let containerSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.size.width = width
        container.size.height = 0
        
        container.widthTracksTextView = true
        container.lineFragmentPadding = 0
        container.maximumNumberOfLines = 3
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(container)
        storage.addLayoutManager(layoutManager)
        layoutManager.glyphRange(for: container)
        
        
        let totalRect = layoutManager.usedRect(for: container)
        let lastPoint = CGPoint(x: totalRect.maxX, y: totalRect.maxY)
        let lastIndex = layoutManager.glyphIndex(for: lastPoint, in: container)
        let isOver = lastIndex < text.length-1
        guard isOver else { return text }
        print("total rect: \(totalRect)")

        let ellipsis = self.badgeWithEllipsis()
        let ellipsisSize = ellipsis.boundingRect(with: .init(width: width, height: 24), options: .usesLineFragmentOrigin, context: nil)
        print("ellipsisSize: \(ellipsisSize)")
    
        let lastGlypPointBeforeEllipsis = CGPoint(x: totalRect.maxX-ellipsisSize.width, y: totalRect.maxY-12)
        let lastGlypPointBeforeEllipsisIndex = layoutManager.glyphIndex(for: lastGlypPointBeforeEllipsis, in: container)
        
        let rangeBeforeEllipsis = NSRange(location: 0, length: lastGlypPointBeforeEllipsisIndex)
        let textWithTruncated = text.attributedSubstring(from: rangeBeforeEllipsis)
        
        print("lastGlypPointBeforeEllipsis: \(lastGlypPointBeforeEllipsis), lastGlypPointBeforeEllipsisIndex: \(lastGlypPointBeforeEllipsisIndex)")
        print("=> textWithTruncated: \(textWithTruncated.string)")
        
        let sender = self.replaceTruncateTailLinebreakMode(textWithTruncated)
        sender.append(ellipsis)
        
        print("final result: \(sender.string)")
        
        return sender
    }
    
    private func replaceTruncateTailLinebreakMode(_ text: NSAttributedString) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: text.length)
        let newAttribute = self.textAttribute(shouldTruncate: true)
        let newAttrText = NSMutableAttributedString(attributedString: text)
        newAttrText.setAttributes(newAttribute, range: range)
        return newAttrText
    }
    
}
