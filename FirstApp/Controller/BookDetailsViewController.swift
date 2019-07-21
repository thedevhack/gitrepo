import UIKit
import Kingfisher
import Firebase

class BookDetailsViewController: UIViewController {

    
    @IBOutlet weak var titletxt: UILabel!
    
    @IBOutlet weak var authortxt: UILabel!
    
    @IBOutlet weak var conditiontxt: UILabel!
    
    @IBOutlet weak var bookoriginaltxt: UILabel!
    
    
    @IBOutlet weak var bookoffertxt: UILabel!
    
    
    @IBOutlet weak var boocategorytxt: UILabel!
    @IBOutlet weak var bookphoto: UIImageView!
    
    var bookimgs = UIImage()
    var booktitles = ""
    var bookconditions = ""
    var bookcategorys = ""
    var bookofferprices = ""
    var bookoriginalprices = ""
    var bookauthors = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titletxt.text = booktitles
        bookphoto.image = bookimgs
        authortxt.text = bookauthors
        conditiontxt.text = bookconditions
        bookoffertxt.text = bookofferprices
        bookoriginaltxt.text = bookoriginalprices
        boocategorytxt.text = bookcategorys
    }
    @IBAction func OnClickBuy(_ sender: Any) {
    }
}
