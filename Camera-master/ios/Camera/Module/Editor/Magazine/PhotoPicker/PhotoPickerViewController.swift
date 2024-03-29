
import UIKit
import Photos

public class PhotoPickerViewController: UIViewController {
    
    @objc public var delegate: PhotoPickerDelegate!
    @objc public var configuration: PhotoPickerConfiguration!
    
    private var topBarHeightLayoutConstraint: NSLayoutConstraint!
    private var bottomBarHeightLayoutConstraint: NSLayoutConstraint!
    
    private var albumListHeightLayoutConstraint: NSLayoutConstraint!
    private var albumListBottomLayoutConstraint: NSLayoutConstraint!
    
    private var albumListVisible = false
    
    // 默认给 1，避免初始化 albumListView 时读取到的高度为 0，无法判断是显示还是隐藏状态
    private var albumListHeight: CGFloat = 1 {
        didSet {
            
            guard albumListHeight != oldValue, albumListHeightLayoutConstraint != nil else {
                return
            }
            
            albumListHeightLayoutConstraint.constant = albumListHeight
            
            if albumListBottomLayoutConstraint.constant > 0 {
                albumListBottomLayoutConstraint.constant = albumListHeight
            }
            
        }
    }
    
    // 当前选中的相册
    private var currentAlbum: PHAssetCollection? {
        didSet {
            
            guard currentAlbum !== oldValue else {
                return
            }
            
            let title: String
            let fetchResult: PHFetchResult<PHAsset>
            
            if let album = currentAlbum {
                title = album.localizedTitle!
                fetchResult = PhotoPickerManager.shared.fetchAssetList(
                    album: album,
                    configuration: configuration
                )
            }
            else {
                title = ""
                fetchResult = PHFetchResult<PHAsset>()
            }
            
            topBar.titleButton.title = title
            assetGridView.fetchResult = fetchResult

        }
    }

    private lazy var albumListView: AlbumList = {
        
        let albumListView = AlbumList(configuration: configuration)

        albumListView.onAlbumClick = { album in
            self.currentAlbum = album.collection
            self.toggleAlbumList()
        }
        
        albumListView.isHidden = true
        
        albumListView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(albumListView, belowSubview: topBar)
        
        albumListBottomLayoutConstraint = NSLayoutConstraint(
            item: albumListView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: topBar,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )
        
        albumListHeightLayoutConstraint = NSLayoutConstraint(
            item: albumListView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: albumListHeight
        )
        
        view.addConstraints([
    
            NSLayoutConstraint(item: albumListView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: albumListView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            albumListBottomLayoutConstraint,
            albumListHeightLayoutConstraint
            
        ])
        
        return albumListView
        
    }()
    
    private lazy var assetGridView: AssetGrid = {
    
        let assetGridView = AssetGrid(configuration: configuration)
        
        assetGridView.translatesAutoresizingMaskIntoConstraints = false
        
        assetGridView.onSelectedAssetListChange = {
            self.bottomBar.selectedCount = assetGridView.selectedAssetList.count
            self.onSubmitClick()
        }
        
        assetGridView.onAssetClick = { asset in
            
            self.onSubmitClick()
            print("选择")
        }
        view.insertSubview(assetGridView, belowSubview: albumListView)
        
        
        
        view.addConstraints([
            
            NSLayoutConstraint(item: assetGridView, attribute: .top, relatedBy: .equal, toItem: topBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: assetGridView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: assetGridView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: assetGridView, attribute: .bottom, relatedBy: .equal, toItem: bottomBar, attribute: .top, multiplier: 1, constant: 0),
            
        ])
        
        return assetGridView
        
    }()
    
    private lazy var topBar: TopBar = {
        
        let topBar = TopBar(configuration: configuration)
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.cancelButton.addTarget(self, action: #selector(onCancelClick), for: .touchUpInside)
        
        topBar.titleButton.addTarget(self, action: #selector(onTitleClick), for: .touchUpInside)
        topBar.subTitleLable.text = "2/2 Selct a design"
        
        view.addSubview(topBar)
        
        topBarHeightLayoutConstraint = NSLayoutConstraint(
            item: topBar,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: configuration.topBarHeight
        )
        
        view.addConstraints([
            NSLayoutConstraint(item: topBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: topBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: topBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            topBarHeightLayoutConstraint
        ])
        
        return topBar
        
    }()
    
    private lazy var bottomBar: BottomBar = {
       
        let bottomBar = BottomBar(configuration: configuration)
        
        bottomBar.isRawChecked = false
        bottomBar.selectedCount = 0
        
        bottomBar.submitButton.onClick = {
            self.onSubmitClick()
        }
        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(bottomBar, belowSubview: albumListView)
        bottomBar.isHidden = true
        bottomBarHeightLayoutConstraint = NSLayoutConstraint(
            item: bottomBar,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: configuration.bottomBarHeight
        )
        
        view.addConstraints([
            NSLayoutConstraint(item: bottomBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bottomBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: bottomBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: CGFloat(UIDevice().kSafeBottomHeight())),
            bottomBarHeightLayoutConstraint
        ])
        
        return bottomBar
        
    }()
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()

        let manager = PhotoPickerManager.shared

        manager.requestPermissions {
            guard manager.scan() else {
                return
            }
            DispatchQueue.main.async {
                self.setup()
            }
        }
        
        manager.onPermissionsGranted = {
            self.delegate.photoPickerDidPermissionsGranted(self)
        }
        
        manager.onPermissionsDenied = {
            self.delegate.photoPickerDidPermissionsDenied(self)
        }
        
        manager.onPermissionsNotGranted = {
            self.delegate.photoPickerDidPermissionsNotGranted(self)
        }
        
        manager.onAlbumListChange = {
            self.updateAlbumList()
        }

    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard topBarHeightLayoutConstraint != nil else {
            return
        }
        
        var height = view.bounds.height
        
        if #available(iOS 11.0, *) {
            
            let top = view.safeAreaInsets.top
            let bottom = view.safeAreaInsets.bottom
            
            height -= bottom
            
            topBarHeightLayoutConstraint.constant = configuration.topBarHeight + top
            bottomBarHeightLayoutConstraint.constant = configuration.bottomBarHeight + bottom
            
        }
        
        height -= topBarHeightLayoutConstraint.constant
        
        albumListHeight = height
        
        view.setNeedsLayout()
        
    }
    
    private func setup() {

        updateAlbumList()
        
        let albumList = albumListView.albumList
        currentAlbum = albumList.count > 0 ? albumList[0].collection : nil
        
    }

    private func updateAlbumList() {
        
        albumListView.albumList = PhotoPickerManager.shared.fetchAlbumList(configuration: configuration)
        
    }
    
    private func toggleAlbumList() {
        
        let visible = !albumListVisible
        
        if visible {
            albumListView.isHidden = false
            topBar.subTitleLable.isHidden = true
        }
        
        // 位移动画
        albumListBottomLayoutConstraint.constant = visible ? albumListHeight : 0
        
        // 旋转动画
        // - 0.01 可以让动画更舒服，不信可去掉试试
        let pi = CGFloat.pi - 0.01
        let transform = visible ? topBar.titleButton.arrowView.transform.rotated(by: -pi) : CGAffineTransform.identity

        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.topBar.titleButton.arrowView.transform = transform
                self.view.layoutIfNeeded()
            },
            completion: { success in
                if !visible {
                    self.albumListView.isHidden = true
                    self.topBar.subTitleLable.isHidden = false
                }
            }
        )
        
        albumListVisible = visible
        
    }
    
    private func onSubmitClick() {

        var selectedList = [Asset]()
        
        // 先排序
        assetGridView.selectedAssetList.forEach { asset in
            selectedList.append(asset)
        }
        
        // 不计数就用照片原来的顺序
        if !configuration.countable {
            selectedList.sort { a, b in
                return a.index < b.index
            }
        }
        
        // 排序完成之后，转成 PickedAsset
        let isRawChecked = bottomBar.isRawChecked
        
        var count = 0
        let urlPrefix = "file://"
        
        var result = [PickedAsset]()
        
        result = selectedList.map { asset in
            
            let item = PickedAsset(path: "", width: asset.width, height: asset.height, size: 0, isVideo: asset.type == .video, isRaw: isRawChecked)
            
            saveToSandbox(asset: asset) { url in
                count += 1
                if let url = url {
                    
                    var path = url.absoluteString
                    if path.hasPrefix(urlPrefix) {
                        path = NSString(string: path).substring(from: urlPrefix.count)
                    }
                    
                    item.path = path
                    
                    let info = try! FileManager.default.attributesOfItem(atPath: path)
                    if let size = info[FileAttributeKey.size] as? Int {
                        item.size = size
                    }
                    
                }

                if count == result.count {
                    self.delegate.photoPickerDidSubmit(self, assetList: result)
                }
            }
            
            return item
            
        }
        
        // saveToSandbox 的回调貌似是同步执行完的
        // 为了确保最后会调 photoPickerDidSubmit，这里加一句
        if count == result.count {
            self.delegate.photoPickerDidSubmit(self, assetList: result)
        }
        
    }
    
    private func saveToSandbox(asset: Asset, callback: @escaping (URL?) -> Void) {
        
        let nativeAsset = asset.asset
        
        guard let originalVersion = PHAssetResource.assetResources(for: nativeAsset).first else {
            return callback(nil)
        }
        
        let dirname = NSTemporaryDirectory()
        
        let localIdentifier = nativeAsset.localIdentifier.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "-", with: "_")
        
        let format = DateFormatter()
        format.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        
        let filename = "\(format.string(from: Date()))_\(localIdentifier)_\(originalVersion.originalFilename)"
        
        let path = dirname.hasSuffix("/") ? (dirname + filename) : "\(dirname)/\(filename)"
        
        let url = URL(fileURLWithPath: path)
        
        // 这里不能判断 url 对应的本地文件是否存在，因为可能在同一张图片上修改，这样得出的 url 是相同的
        // 修改过的图片只能获取到最初的版本
        // 这里 canHandleAdjustmentData 返回 false 可获得最新版本
        
        if asset.type != .video {
            
            let options = PHContentEditingInputRequestOptions()
            options.isNetworkAccessAllowed = true
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return false
            }
            
            nativeAsset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
                guard let source = contentEditingInput?.fullSizeImageURL else {
                    return
                }
                do {
                    try FileManager.default.copyItem(at: source, to: url)
                    callback(url)
                }
                catch {
                    callback(nil)
                }
            })
        }
        else {
            
            let options = PHAssetResourceRequestOptions()
            options.isNetworkAccessAllowed = true
            
            PHAssetResourceManager.default().writeData(for: originalVersion, toFile: url, options: options) { error in
                if error == nil {
                    callback(url)
                }
                else {
                    callback(nil)
                }
            }
            
        }
        
    }
    
    @objc private func onCancelClick() {
        delegate.photoPickerDidCancel(self)
    }

    @objc private func onTitleClick() {
        toggleAlbumList()
    }
    
    @objc public func show() {

        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
        }
        
    }
    
}


