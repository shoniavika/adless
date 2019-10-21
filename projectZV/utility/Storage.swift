//
//  Storage.swift
//  projectZV
//
//  Created by Vika on 10/12/19.
//  Copyright © 2019 Vika. All rights reserved.
//

import Foundation

final class Storage {
    // TODO: change list to set
    lazy var blackList = [String]()
    lazy var whiteList = [String]()
    
    static var instance = Storage()
    
    private init() {
        let white = UserDefaults.standard.array(forKey: Constants.whiteListKey)
        let black = UserDefaults.standard.array(forKey: Constants.blackListKey)
        if let whiteList = white as? [String] {
            self.whiteList = whiteList
        }
        if let blackList = black as? [String] {
            self.blackList = blackList
        }
    }
    
    // Rodesats daamateb items listshi, marto mashin shetsvlis userDefaults
    func addToBlackList(_ item: String) {
        blackList.append(item)
        persistBlackList()
    }
    
    func addToWhiteList(_ item: String) {
        whiteList.append(item)
        persistWhiteList()
    }
    
    func deleteFromWhiteList(at index: Int) {
        whiteList.remove(at: index)
        persistWhiteList()
    }
    
    func deleteFromBlackList(at index: Int) {
        blackList.remove(at: index)
        persistBlackList()
    }
    
    private func persistBlackList() {
        UserDefaults.standard.set(blackList, forKey: Constants.blackListKey)
    }
    
    private func persistWhiteList() {
        UserDefaults.standard.set(whiteList, forKey: Constants.whiteListKey)
    }
    
}

extension Storage {
    
    fileprivate struct Constants {
        static let blackListKey = "BlackList"
        static let whiteListKey = "WhiteList"
    }
}
