import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        layer.borderWidth = 1
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.titleLabel.text = nil
        self.priceLabel.text = nil
    }

    func setProduct(_ product: Product) {
        self.titleLabel.text = product.title
        self.priceLabel.text = "£\(product.price)"
        self.imageView.sd_setImage(with: product.imagePath, placeholderImage: nil, options:.retryFailed ) { (image, _, _, _) in
            if let image = image {
                self.imageView.image = image
                let size = image.size
                if size.width / size.height == 1 {
                    self.imageView.contentMode = .scaleAspectFit
                } else {
                    self.imageView.contentMode = .scaleAspectFill
                }
            }
        }
    }
    
}
