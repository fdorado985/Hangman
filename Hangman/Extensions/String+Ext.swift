//
//  String+Ext.swift
//  Hangman
//
//  Created by Juan Francisco Dorado Torres on 6/13/19.
//  Copyright © 2019 Juan Francisco Dorado Torres. All rights reserved.
//

import Foundation

extension String {

  mutating func replaceString(at positions: [Int], with character: Character) -> Bool {
    let oldString = self

    positions.forEach { position in
      self = (self.enumerated()
        .map { $0 == position ? String(character) : String($1) })
        .joined()
        .uppercased()
    }

    return oldString != self
  }
}
