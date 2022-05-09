//
//  CharacterDetailsViewController.swift
//  MarvelData
//
//  Created by Swapnali Patil on 05/05/22.
//

import UIKit
import SDWebImage

class CharacterDetailsViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imgCharactersThumbnail: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDescription: UILabel!
    
    var presenter: CharacterDetailsPresenter?
    var configurator: CharacterDetailsConfigurator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(characterDetailsViewController: self)
        self.loadDataOnUI()
    }

}

extension CharacterDetailsViewController: CharacterDetailsOutput {
    func loadDataOnUI() {
        if let characterData = self.presenter?.getCharactersData() {
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
            self.lblTitle.text = characterData.name
            self.lblDescription.text = characterData.resultDescription
        }
    }    
}
