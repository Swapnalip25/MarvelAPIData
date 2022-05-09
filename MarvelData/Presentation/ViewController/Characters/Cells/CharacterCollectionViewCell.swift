//
//  CharacterCollectionViewCell.swift
//  MarvelData
//
//  Created by Swapnali Patil on 02/05/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell, ImageLoader {

    @IBOutlet private weak var imgCharactersThumbnail: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var containerView: UIView!
    private let cornerRadius: CGFloat = 10.0
    private let borderWidth: CGFloat = 0.5
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = borderWidth
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = cornerRadius
        self.imgCharactersThumbnail?.image = nil
        self.imgCharactersThumbnail?.clipsToBounds = true
        self.imgCharactersThumbnail?.contentMode = .scaleToFill
        self.imgCharactersThumbnail?.setNeedsDisplay()
        self.imgCharactersThumbnail.layer.cornerRadius = cornerRadius
    }
    
    func configureCharactersData(result: ResultCharacters) {
        self.lblTitle.text = result.name
        if let http = URL(string: result.thumbnail.path + CellConstants.imageExtension), var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) {
            comps.scheme = CellConstants.httpsScheme
            if let https = comps.url {
                self.setImage(imageView: self.imgCharactersThumbnail, url: https)
            }
        }
    }

}
