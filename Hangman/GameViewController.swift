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
  @IBOutlet var letterButtons: [UIButton]!
  @IBOutlet var hangmanImageView: UIImageView!
  
  // MARK: - Properties

  private var words = [String]()
  private var wordToGuess = ""
  private var wordIndex = -1
  private var score = 0
  private var attempt = 0 {
    didSet {
      hangmanImageView.image = attempt == 0 ? UIImage(named: "base") : UIImage(named: "attempt\(attempt)")
    }
  }

  // MARK: - Computed Properties

  private var completed: Bool {
    return !maskedWord.contains("?")
  }

  private var maskedWord = "" {
    didSet { wordLabel.text = maskedWord }
  }

  // MARK: - View cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    startGame()
  }

  // MARK: - Actions

  @IBAction private func letterButtonTapped(_ sender: UIButton) {
    if let letterToSearch = sender.titleLabel?.text?.uppercased() {
      sender.isHidden = true
      search(letterToSearch)
    }
  }

  // MARK: - Methods

  private func getWords() {
    if let filePath = Bundle.main.url(forResource: "words", withExtension: "txt"),
      let wordsOfPath = try? String(contentsOf: filePath).trimmingCharacters(in: .whitespacesAndNewlines) {
      words = wordsOfPath.components(separatedBy: "\n").map { $0.uppercased() }
      print(words)
    } else {
      words.append("Apple")
    }
  }

  private func startGame(action: UIAlertAction? = nil) {
    getWords()
    restartButtonsStates()

    scoreLabel.text = String(score)
    attempt = 0
    words.shuffle()

    nextWord()

  }

  private func nextWord(action: UIAlertAction? = nil) {
    restartButtonsStates()
    wordIndex = (wordIndex < 0 || wordIndex + 1 == words.count) ? 0 : wordIndex + 1
    maskedWord = ""
    wordToGuess = words[wordIndex]
    print(wordToGuess)
    wordToGuess.forEach { _ in maskedWord.append(Character("?")) }
    wordLabel.text = maskedWord
  }

  private func restartButtonsStates() {
    for button in letterButtons {
      button.isHidden = false
    }
  }

  private func search(_ letter: String) {
    let positions = wordToGuess.enumerated().compactMap { String($1) == letter ? $0 : nil }
    if !maskedWord.replaceString(at: positions, with: Character(letter)) {
      attempt += 1
      if attempt == 6 {
        let ac = UIAlertController(title: "Bad news", message: "You have lost the word 😞", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default, handler: startGame)
        ac.addAction(restartAction)
        present(ac, animated: true)
      }
    }

    if completed {
      gameCompleted()
    }
  }

  private func gameCompleted() {
    let ac = UIAlertController(title: "Excellent", message: "You have found the word", preferredStyle: .alert)
    let nextAction = UIAlertAction(title: "Next", style: .default, handler: nextWord)
    ac.addAction(nextAction)
    present(ac, animated: true)
  }
}

