import UIKit

class AddCustomAnswerPopup: BaseViewController {

    // MARK: - @IBOutlets
    
    // Views
    @IBOutlet weak var popupBackgroundView: UIView!
    
    // Labels
    @IBOutlet weak var titleLabel: UILabel!
    
    // Buttons
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    // Text Fields
    @IBOutlet weak var textField: UITextField!
        
    // MARK: - Awake functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    // MARK: - Custom functions
    
    override func localize() {
        titleLabel.localize(with: "popup.label.title")
        saveButton.localize(with: "popup.button.save")
        cancelButton.localize(with: "popup.button.cancel")
    
    }
    
    override func configureUI() {
        popupBackgroundView.roundCorners(radius: 12, corners: .allCorners)
        saveButton.roundCorners(radius: 12, corners: .allCorners)
    }
    
    func animateIn() {
        popupBackgroundView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.popupBackgroundView.transform = .identity
        }
    }
    
    func animateOut() {
        self.view.alpha = 1
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseIn) {
            self.view.alpha = 0
            self.popupBackgroundView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
        } completion: { completed in
            self.view.removeFromSuperview()
        }
    }
        
    // MARK: - @IBActions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        animateOut()
    }
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
