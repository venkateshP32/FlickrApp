//
//  HTMLString.swift
//  FlickrApp
//
//  Created by venkatesh peddigari on 9/17/21.
//

import UIKit

extension String {
   var html2AttributedString: String? {
   guard let data = data(using: .utf8) else { return nil }
   do {
       return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).string

   } catch let error as NSError {
       print(error.localizedDescription)
       return  nil
   }
 }
}
