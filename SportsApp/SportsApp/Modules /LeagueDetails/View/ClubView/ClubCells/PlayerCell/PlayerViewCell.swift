//
//  PlayerViewCell.swift
//  SportsApp
//
//  Created by Eyad waleed on 17/05/2026.
//

import UIKit
import SDWebImage
class PlayerViewCell: UICollectionViewCell {
    @IBOutlet weak var playerThirdStat: UILabel!
    @IBOutlet weak var playerThirdStateValue: UILabel!
    @IBOutlet weak var playerSecondStatValue: UILabel!
    @IBOutlet weak var playerStatSec: UILabel!
    @IBOutlet weak var playerFirstState: UILabel!
    @IBOutlet weak var playerFirstStateValue: UILabel!
    @IBOutlet weak var playerRedColors: UILabel!
    @IBOutlet weak var plaerYellowCards: UILabel!
    @IBOutlet weak var playerAssitsts: UILabel!
    @IBOutlet weak var playerGoals: UILabel!
    @IBOutlet weak var numberOfMatchPlayed: UILabel!
    @IBOutlet weak var iconOfAvlabiliuty: UIImageView!
    @IBOutlet weak var playerAvailability: UILabel!
    @IBOutlet weak var playerDOB: UILabel!
    @IBOutlet weak var playerAge: UILabel!
    @IBOutlet weak var arrowPostion: UIImageView!
    @IBOutlet weak var playerRating: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPostion: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private var cellHeight: CGFloat = 120

    func setExpanded(isExpanded: Bool) {
        cellHeight = isExpanded ? 280 : 120
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: cellHeight)
    }
    func config(player:Player , isExpand : Bool){
        playerName.text = player.playerName
        playerNumber .text = player.playerNumber
        playerAge.text = player.playerAge
        playerDOB.text = player.playerBirthdate
        playerRating.text =  player.playerRating.isEmpty ? "0" :  player.playerRating
        playerPostion.text = player.playerType
        playerGoals.text = player.playerGoals
        playerAssitsts.text = player.playerAssists
        playerRedColors.text = player.playerRedCards
        plaerYellowCards.text = player.playerYellowCards
        numberOfMatchPlayed.text = player.playerMatchPlayed
        checkPlayerAvlability(playerAvlability: player.playerInjured )
        playerImage.sd_setImage(with: URL(string: player.playerImage ?? ""), placeholderImage: UIImage(systemName: "person.fill"))
        checkPlayerStaticOnPostion(player:player)
        arrowPostion.image = isExpand ? UIImage(systemName: "chevron.up")  :
        UIImage(systemName: "chevron.down")
    }
    
    private func checkPlayerAvlability (playerAvlability:String){
        switch playerAvlability {
        case "Yes":
            self.playerAvailability.text = "Injured"
            self.playerAvailability.textColor =           UIColor(hex: "FFB4AB")
            self.iconOfAvlabiliuty.image =  UIImage(systemName:"exclamationmark.triangle" )
            self.iconOfAvlabiliuty.tintColor = UIColor(hex: "FFB4AB")
        
            
        default:
            break
        }
        
    }
    private func checkPlayerStaticOnPostion(player:Player){
        switch player.playerType {
            
        case "Goalkeepers":
            configureGoalkeeperStats(player: player)
       
            
        case "Defenders":
            configureDefenderStats(player: player)
           
        case "Midfielders":
            configureMidfielderStats(player: player)
        default:
            configureForwardStats(player: player)
            
        }
        
    }
    private func configureMidfielderStats(player: Player) {
        
        self.playerFirstState.text = "Duels Won"
        self.playerStatSec.text = "Dribbles"
        self.playerThirdStat.text = "Pass Acc"
        
        self.playerFirstStateValue.text = calculateDuelsWonPercentage(
            playerDuelsWon: player.playerDuelsWon,
            playerTotalDuels: player.playerDuelsTotal
        )
        
        self.playerSecondStatValue.text = calculateDribblesSuccessfulPercentage(
            playerSuccessDribbling: player.playerDribbleSucc ?? "",
            playerAttemptDribbling: player.playerDribbleAttempts ?? ""
        )
        
        self.playerThirdStateValue.text = player.playerPassesAccuracy
    }
    private func configureGoalkeeperStats(player: Player) {
        self.playerFirstState.text = "Saves"
        self.playerStatSec.text = "Conceded"
        self.playerThirdStat.text = "Clearance"
        self.playerFirstStateValue.text = player.playerSaves
        self.playerSecondStatValue.text = player.playerGoalsConceded
        self.playerThirdStateValue.text = player.playerClearances
    }
    private func configureDefenderStats(player: Player) {
        
        self.playerFirstState.text = "Duels Won"
        self.playerStatSec.text = "Tackles"
        self.playerThirdStat.text = "Pass Acc"
        
        self.playerFirstStateValue.text = calculateDuelsWonPercentage(
            playerDuelsWon: player.playerDuelsWon,
            playerTotalDuels: player.playerDuelsTotal
        )
        
        self.playerSecondStatValue.text = player.playerTackles
        self.playerThirdStateValue.text = player.playerPassesAccuracy
    }
    private func configureForwardStats(player: Player) {
        
        self.playerFirstState.text = "Goals"
        self.playerStatSec.text = "Dribbles"
        self.playerThirdStat.text = "Penlty"
        
        self.playerFirstStateValue.text = player.playerGoals
           
        self.playerSecondStatValue.text = calculateDribblesSuccessfulPercentage(
            playerSuccessDribbling: player.playerDribbleSucc ?? "",
            playerAttemptDribbling: player.playerDribbleAttempts ?? ""
        )
        
        self.playerThirdStateValue.text = player.playerPenScored
    }
    private func calculateDribblesSuccessfulPercentage(
        playerSuccessDribbling: String,
        playerAttemptDribbling: String
    ) -> String {
        
        let success = Double(playerSuccessDribbling) ?? 0
        let attempts = Double(playerAttemptDribbling) ?? 0
        
        if attempts == 0 {
            return "0%"
        }
        
        let percentage = (success / attempts) * 100
        
        return String(format: "%.0f%%", percentage)
    }
    private func calculateDuelsWonPercentage(
        playerDuelsWon: String?,
        playerTotalDuels: String?
    ) -> String {
        
        guard let wonText = playerDuelsWon,
              let totalText = playerTotalDuels,
              !wonText.isEmpty,
              !totalText.isEmpty
        else {
            return "0%"
        }
        
        let won = Double(wonText) ?? 0
        let total = Double(totalText) ?? 0
        
        if total == 0 {
            return "0%"
        }
        
        let percentage = (won / total) * 100
        
        return String(format: "%.0f%%", percentage)
    }
}
