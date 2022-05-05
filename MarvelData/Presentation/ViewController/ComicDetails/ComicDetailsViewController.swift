//
//  ComicDetailsViewController.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import UIKit
import SDWebImage

class ComicDetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgCharactersThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var presenter: ComicDetailsPresenter?
    var configurator: ComicDetailsConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(comicDetailsViewController: self)
        self.loadDataOnUI()
    }

}

extension ComicDetailsViewController: ComicDetailsOutput {
    func loadDataOnUI() {
        if let characterData = self.presenter?.getComicData() {
            if let http = URL(string: characterData.thumbnail.path + CellConstants.imageExtension), var comps = URLComponents(url: http, resolvingAgainstBaseURL: false) {
                comps.scheme = CellConstants.httpsScheme
                if let https = comps.url {
                    self.imgCharactersThumbnail?.image = nil
                    self.imgCharactersThumbnail?.sd_setImage(with: https, placeholderImage: UIImage.init(named: CellConstants.placeholderImage))
                    self.imgCharactersThumbnail?.contentMode = .scaleToFill
                    self.imgCharactersThumbnail?.clipsToBounds = true
                    self.imgCharactersThumbnail?.setNeedsDisplay()
                }
            }
            self.lblTitle.text = characterData.title
            self.lblDescription.text = characterData.resultDescription
        }
    }
}
