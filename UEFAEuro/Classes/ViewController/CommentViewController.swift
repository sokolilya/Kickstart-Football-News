//
//  CommentViewController.swift
//  Euro2016
//
//  Created by Ngọc Toán on 2/7/18.
//  Copyright © 2018 Hicom Solution. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate, UITextViewDelegate {
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet var viewCustomToolBar: UIView!
    @IBOutlet weak var viewInputComment: UIView!
    @IBOutlet weak var lblTitleEdit: UILabel!
    @IBOutlet weak var viewEditName: UIView!
    var objMatch: MatchObj!
    var arrComment = [CommentObj]()
    var notScrollToBottom = false
    var numberOfMesShow = 20
    var userNameCurrent = ""
    @IBOutlet weak var tfNameEdit: UITextView!
    @IBOutlet weak var tfContentComment: UITextView!
    @IBOutlet weak var tbvComment: UITableView!
    @IBOutlet weak var tfCommentToolBar: UITextView!
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var constrainHeightMore: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSave.setTitle("SAVE".localized, for: .normal)
        btnCancel.setTitle("CANCEL".localized, for: .normal)
        self.hideKeyboardWhenTappedAround()
        let userDefault = UserDefaults.standard
        if let nameUser = userDefault.string(forKey: KEY_SAVE_USER_NAME) {
           tfNameEdit.text = nameUser
            userNameCurrent = nameUser
            lblTitleEdit.text = "kCommentTitleCreate".localized
        }else{
            lblTitleEdit.text = "kCommentTitleChange".localized
            viewEditName.isHidden = false
        }
        self.tfContentComment.inputAccessoryView = viewCustomToolBar
        self.tfContentComment.delegate = self
        self.tfCommentToolBar.delegate = self
        self.constrainHeightMore.constant = 0;
        self.btnMore.isHidden = true;
        tbvComment.delegate  = self
        tbvComment.dataSource  = self
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tbvComment.register(nib, forCellReuseIdentifier: "CommentTableViewCell")
        tbvComment.estimatedRowHeight = 40
        tbvComment.rowHeight = UITableView.automaticDimension
        ref = Database.database().reference()
        getListComment()
    }
    
    func getListComment(){
        ref.child("Room/\(objMatch.mId)/user").queryLimited(toLast: UInt(numberOfMesShow)).observe(DataEventType.value) { (snapshot) in
            if snapshot.exists() {
                self.arrComment.removeAll()
                for child in snapshot.children.allObjects as! [DataSnapshot] {
                    let objComment = CommentObj.init(dict: child)
                    self.arrComment.append(objComment)
                }
                self.tbvComment.reloadData()
                if !self.notScrollToBottom  {
                    self.scrollToBottom()
                }
            }
        }
    }
   
    func postCommentWithContent(_ content: NSString){
        self.notScrollToBottom = false
        tfContentComment.text = ""
        tfCommentToolBar.text = ""
        tfContentComment.endEditing(true)
        tfCommentToolBar.endEditing(true)
        let dateCurrent = String(format: "%.0f", NSDate().timeIntervalSince1970)
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let keyAuto = self.ref.child("Room/\(self.objMatch.mId)/user").childByAutoId()
        let updateChild = ["content":content,
                           "datepost":dateCurrent,
                           "userId": uuid,
                           "userName": userNameCurrent]
            as [String : Any]
        self.ref.child("Room/\(self.objMatch.mId)/user/\(keyAuto.key)").updateChildValues(updateChild)
    }
    //MARK: UITableviewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrComment.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let allVisibleCell = tableView.visibleCells.count + 1
        if indexPath.row < allVisibleCell  && arrComment.count >= numberOfMesShow {
            self.constrainHeightMore.constant = 30;
            self.btnMore.isHidden = false;
        }else{
            self.constrainHeightMore.constant = 0;
            self.btnMore.isHidden = true;
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        let comment = arrComment[indexPath.row]
        cell.lblName.text = comment.cmSenderName
        cell.lblContent.text = comment.cmContent
        let timeDouble = comment.cmDatePost?.toDouble()
        let date = Date(timeIntervalSince1970: timeDouble!)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let strDate =  formatter.string(from: date)
        cell.lblDatePost.text = strDate
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    //MARK: UITableviewDelegate
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let match = arrComment[indexPath.row]
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Utility
    @objc func tapViewEditName(_ sender: UITapGestureRecognizer) {
        viewEditName.isHidden = true
        self.tfNameEdit.endEditing(true)
        let userDefault = UserDefaults.standard
        if let nameUser = userDefault.string(forKey: KEY_SAVE_USER_NAME) {
            tfNameEdit.text = nameUser
        }
        
    }
    func scrollToBottom(){
        let numberOfRow = tbvComment.numberOfRows(inSection: 0)
        if numberOfRow > 0 {
            let index = IndexPath(row: numberOfRow - 1, section: 0)
            self.tbvComment.scrollToRow(at: index, at: .middle, animated: true)
        }
    }
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    //MARK: - textview delegate
    func textViewDidChange(_ textView: UITextView) {
        if (textView == tfCommentToolBar || textView == tfContentComment) {
            tfCommentToolBar.text = textView.text
            tfContentComment.text = textView.text
        }
    }
    //MARK: - Action
    @IBAction func onEditName(_ sender: Any) {
      viewEditName.isHidden = false
    }
    
    @IBAction func onSendComment(_ sender: Any) {
        
        if !(tfNameEdit.text.count > 0) {
            viewEditName.isHidden = false
         self.view.makeToast(message: "kCommentNeedUserName".localized)
           return
        }
        if !(tfContentComment.text.count > 0) {
            self.view.makeToast(message: "kCommentFillToContent".localized)
            return
        }
        postCommentWithContent(tfContentComment.text! as NSString)
    }
    @IBAction func onSave(_ sender: Any) {
        if !(tfNameEdit.text.count > 0) {
            self.view.makeToast(message: "kFillToName".localized)
            return
        }
        let defaults = UserDefaults.standard
        defaults.set(tfNameEdit.text, forKey: KEY_SAVE_USER_NAME)
        userNameCurrent = tfNameEdit.text
        self.tapViewEditName(UITapGestureRecognizer())
    }
    @IBAction func onCancel(_ sender: Any) {
        self.tapViewEditName(UITapGestureRecognizer())
    }
    @IBAction func onLoadMore(_ sender: Any) {
        self.notScrollToBottom = true
        numberOfMesShow += 20
        self.getListComment()
    }
    @IBAction func onDismissViewEditUser(_ sender: Any) {
        self.tapViewEditName(UITapGestureRecognizer())
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
