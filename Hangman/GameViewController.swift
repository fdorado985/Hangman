//
//  GameViewController.swift
//  Hangman
//
//  Created by Juan Francisco Dorado Torres on 6/12/19.
//  Copyright © 2019 Juan Francisco Dorado Torres. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  // MARK: - Outlets

  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var wordLabel: UILabel!

  // MARK: - Properties

  private var words = [String]()
  private var wordToGuess = ""
  private var maskedWord = ""
  private var wordIndex = 0
  private var score = 0

  // MARK: - View cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    startGame()
  }

  // MARK: - Methods

  private func getWords() {
    if let filePath = Bundle.main.url(forResource: "words", withExtension: "txt"),
      let wordsOfPath = try? String(contentsOf: filePath).trimmingCharacters(in: .whitespacesAndNewlines) {
      words = wordsOfPath.components(separatedBy: "\n")
      print(words)
    } else {
      words.append("Apple")
    }
  }

  private func startGame() {
    getWords()
    scoreLabel.text = String(score)
    words.shuffle()
    wordToGuess = words[wordIndex]
    for _ in wordToGuess {
      maskedWord.append(Character("?"))
    }

    wordLabel.text = maskedWord
  }
}

