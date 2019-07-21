import UIKit
import Kingfisher
import Firebase

class BookDetailsViewController: UIViewController {
    
    @IBOutlet weak var titlestxt: UILabel!
    @IBOutlet weak var authorstxt: UILabel!
    @IBOutlet weak var bookscondition: UILabel!
    @IBOutlet weak var booksimg: UIImageView!
    @IBOutlet weak var bookscategory: UILabel!
    @IBOutlet weak var booksofferprice: UILabel!
    @IBOutlet weak var booksoriginalprice: UILabel!
    @IBOutlet weak var booksdesc: UILabel!
    @IBOutlet weak var booksgenre: UILabel!
    var bookimgs = UIImage()
    var booktitles = ""
    var bookconditions = ""
    var bookcategorys = ""
    var bookofferprices = ""
    var bookoriginalprices = ""
    var bookauthors = ""
    var bookgenres = ""
    var bookdescs = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titlestxt.text = "Book Title:\(booktitles)"
        authorstxt.text = "Book Author:\(bookauthors)"
        booksimg.image = bookimgs
        bookscondition.text = "Book Condition:\(bookconditions)"
        bookscategory.text = "Book Category:\(bookcategorys)"
        booksofferprice.text = "Book Offer Price:\(bookofferprices)"
        booksoriginalprice.text = "Book Original Price:\(bookoriginalprices)"
        booksdesc.text = "Book Desc:\(bookdescs)"
        booksgenre.text = "Book Genre:\(bookgenres)"
    }
    
    @IBAction func OnClickBuy(_ sender: Any) {
    }
}
