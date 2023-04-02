
import UIKit

public class TopBar: UIView {
    
    private var configuration: PhotoPickerConfiguration!
    
    lazy var titleButton: TitleButton = {
        
        let view = TitleButton(configuration: configuration)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: cancelButton, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40),
        ])
        
        return view
        
    }()
    
    lazy var subTitleLable: UILabel = {
        
        
        let view = UILabel()
        view.textColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        //            UIColor.init(red: 118, green: 118, blue: 118, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = NSTextAlignment.center
        addSubview(view)
        
        
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: titleButton, attribute: .bottom, multiplier: 1, constant: -5),
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 20),
            ])
        
        return view
        
    }()

    lazy var cancelButton: UIButton = {
        
        let view = UIButton()
        
        view.titleLabel?.font = configuration.cancelButtonTextFont
        view.setImage(UIImage(named: configuration.cancelButtonTitle), for: UIControl.State.normal)
//        view.setTitle(configuration.cancelButtonTitle, for: .normal)
        view.setTitleColor(configuration.cancelButtonTextColor, for: .normal)

        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: configuration.topBarPaddingHorizontal),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: bottomBorder, attribute: .top, multiplier: 1, constant: -(configuration.topBarHeight - configuration.cancelButtonHeight) / 2),
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .width, multiplier: 1, constant: configuration.cancelButtonMinWidth),
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: configuration.cancelButtonHeight),
        ])
        
        return view
        
    }()
    
    
    private lazy var bottomBorder: UIView = {
       
        let view = UIView()
        
        view.backgroundColor = configuration.topBarBorderColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        
        addConstraints([
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: configuration.topBarBorderWidth),
        ])
        
        return view
        
    }()

    public convenience init(configuration: PhotoPickerConfiguration) {
        
        self.init()
        self.configuration = configuration
        
        backgroundColor = configuration.topBarBackgroundColor
        
    }
    
}
