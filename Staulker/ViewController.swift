import UIKit

class ViewController: UIViewController {


  @IBOutlet weak var bgDateLbl: UILabel!
  let BG_DATE_KEY: String = "bgDate"
  let userDefaults = UserDefaults.standard

  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("view did load")
    loadBGDateStringToUI()
  }

  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    print("view did appear")
    loadBGDateStringToUI()
  }
  
  
  @IBAction func loadBGString(_ sender: UIButton) {
    loadBGDateStringToUI()
  }
  
  @IBAction func updateBGDate(_ sender: UIButton) {

    print("Saving BG Date as String")
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d h:mm a"
    dateFormatter.locale = Locale(identifier: "en_US")       // US English Locale (en_US)

    let bgDate = dateFormatter.string(from: Date())
    print("Saving: \(bgDate)")
    self.userDefaults.set(bgDate, forKey: BG_DATE_KEY)

  } // updateBGDate
  
  func loadBGDateStringToUI() {
    print("Loading BG Date")
 
    if let dateBGStr = self.userDefaults.object(forKey: BG_DATE_KEY) as? String {
      bgDateLbl.text = dateBGStr
    } else {
      print("Could not load property for key \(BG_DATE_KEY)")
    }
  } // updateLastUsedLabelFormatted
  
} // vc
