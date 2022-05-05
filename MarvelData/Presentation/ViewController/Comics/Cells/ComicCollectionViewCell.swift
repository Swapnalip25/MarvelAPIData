//
//  ComicCollectionViewCell.swift
//  MarvelData
//
//  Created by Swapnali Patil on 02/05/22.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgComicThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    let cornerRadiusConstant: CGFloat = 10.0
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = cornerRadiusConstant
        self.imgComicThumbnail?.image = nil
        self.imgComicThumbnail?.clipsToBounds = true
        self.imgComicThumbnail?.contentMode = .scaleToFill
        self.imgComicThumbnail?.setNeedsDisplay()
        self.imgComicThumbnail?.layer.cornerRadius = cornerRadiusConstant
    }
    
    func configureComicData(result: ResultComic) {
        self.lblTitle.text = result.title
        
        if let http = URL(string: result.thumbnail.path + CellConstants.imageExtension), var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) {
            comps.scheme = CellConstants.httpsScheme
            if let https = comps.url {
                self.imgComicThumbnail?.image = nil
                self.imgComicThumbnail?.sd_setImage(with: https)//, placeholderImage: UIImage.init(named: "Placeholder"))
                self.imgComicThumbnail?.contentMode = .scaleToFill
                self.imgComicThumbnail?.clipsToBounds = true
                self.imgComicThumbnail?.setNeedsDisplay()
            }
        }
    }

}
