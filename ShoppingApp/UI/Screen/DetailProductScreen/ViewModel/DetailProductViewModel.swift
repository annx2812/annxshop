//
//  DetailProductViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation
import Firebase

class CommentsRequest {
    public static let shared = CommentsRequest()
    var firRef: DatabaseReference
    private init() {
        self.firRef = BaseRequestModel.shared.firRef.child("Comments")
    }
    
    func getAllComment(
        successBlock: @escaping ([Comment]) -> Void,
        failBlock: @escaping (_ message: String) -> Void) {
            let request = firRef
                .queryOrdered(byChild: "Comments")
            request.observe(.value) { (snapShot) in
                var comments = [Comment]()
                for child in snapShot.children {
                    if let snap = child as? DataSnapshot {
                        let key = snap.key
                        if let value = snap.value as? [String:Any],
                           var comment = Comment.init(JSON: value) {
                            comment.commentID = key
                            comments.append(comment)
                        }
                    }
                }
                guard !comments.isEmpty else {
                    failBlock("Không tìm thấy dữ liệu")
                    return
                }
                successBlock(comments)
            }
        }
    
    func addComment(comment: Comment, completionBlock: @escaping (Bool, Comment?)->Void) {
        var comment = comment
        let request: DatabaseReference = {
            if comment.commentID.isEmpty {
                return firRef.childByAutoId()
            } else {
                return firRef.child(comment.commentID)
            }
        }()
        
        let key = request.key ?? ""
        request.setValue(comment.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false, nil)
                return
            }
            comment.commentID = key
            completionBlock(true, comment)
        }
    }
}

class DetailProductViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    func getAllComment() {
        CommentsRequest.shared.getAllComment() { comments in
            self.comments = comments
        } failBlock: { message in
            //
        }
    }
    
    func addComment( productID: String,
                     userID: String,
                     comment: String,
                     completionBlock: @escaping (Bool) -> Void){
        var usercomment = Comment()
        usercomment.productID = productID
        usercomment.userID = userID
        usercomment.comment = comment
        CommentsRequest.shared.addComment(comment: usercomment) { isSuccess, _ in
            completionBlock(isSuccess)
        }
    }
}
