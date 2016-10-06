(defrule askVictoryType
  (initial-fact)
  =>
  (printout t "Welcome to the Civilisation V expert system for selecting a civilation." crlf)
  (printout t "NOTE: All responses should be fully lowercase." crlf crlf)
  (printout t "Which victory type are you aiming for? (domination, diplomatic, culture, science or flexible)" crlf)
  (assert (victoryType (read)))
)


; VICTORY TYPE RESPONSES

(defrule victoryType-domination
  (victoryType domination)
  =>
  (printout t "Are there a lot of sea/ocean tiles? (y or n)" crlf)
  (assert (abundantOceanTiles (read)))
)

(defrule victoryType-diplomatic
  (victoryType diplomatic)
  =>
  (printout t "Are there any other players going for a diplomatic victory? (y or n)" crlf)
  (assert (otherDiplomaticPlayers (read)))
)

(defrule victoryType-culture
  (victoryType culture)
  =>
  (printout t "Are there any aggressive civilisations or raging barbarians? (y or n)" crlf)
  (assert (aggressiveThreats (read)))
)

(defrule victoryType-science
  (victoryType science)
  =>
  (printout t "Is there room for expansion to 4+ cities? (y or n)" crlf)
  (assert (roomForExpansion (read)))
)

(defrule victoryType-flexible
  (victoryType flexible)
  =>
  (printout t "What type of resources are more abundant? (strategic or luxury)" crlf)
  (assert (abundantResourceType (read)))
)


; TIER 2 RESPONSES

(defrule domination-abundantOceanTiles
  (victoryType domination)
  (abundantOceanTiles y)
  =>
  (printout t "Are there any other naval civilisations? (y or n)" crlf)
  (assert (otherNavalCivs (read)))
)

(defrule domination-notAbundantOceanTiles
  (victoryType domination)
  (abundantOceanTiles n)
  =>
  (printout t "Are there raging barbarians? (y or n)" crlf)
  (assert (ragingBarbarians (read)))
)

(defrule culture-notAggressiveThreats
  (victoryType culture)
  (aggressiveThreats n)
  =>
  (printout t "Is there room for expansion to 4+ cities? (y or n)" crlf)
  (assert (roomForExpansion (read)))
)

(defrule flexible-strategicResources
  (victoryType flexible)
  (abundantResourceType strategic)
  =>
  (printout t "Are there a lot of sea/ocean tiles? (y or n)" crlf)
  (assert (abundantOceanTiles (read)))
)


; TIER 3 RESPONSES

(defrule domination-notAbundantOceanTiles-ragingBarbarians
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians y)
  =>
  (printout t "Do you want to save money or have a religion? (money or religion)" crlf)
  (assert (moneyOrReligion (read)))
)

(defrule domination-notAbundantOceanTiles-notRagingBarbarians
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians n)
  =>
  (printout t "Is there a lot of forest tiles? (y or n)" crlf)
  (assert (abundantForestTiles (read)))
)

; TIER 4 RESPONSES

(defrule domination-notAbundantOceanTiles-notRagingBarbarians-notAbundantForestTiles
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians n)
  (abundantForestTiles n)
  =>
  (printout t "How dense is the map? (sparse, average or crowded)" crlf)
  (assert (mapDensity (read)))
)

; CHOOSE RULES

(defrule chooseOttoman
  (victoryType domination)
  (abundantOceanTiles y)
  (otherNavalCivs y)
  =>
  (assert (decision "Ottoman"))
)

(defrule chooseEnglish
  (victoryType domination)
  (abundantOceanTiles y)
  (otherNavalCivs n)
  =>
  (assert (decision "English"))
)

(defrule chooseGerman
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians y)
  (moneyOrReligion money)
  =>
  (assert (decision "German"))
)

(defrule chooseSonghai
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians y)
  (moneyOrReligion religion)
  =>
  (assert (decision "Songhai"))
)

(defrule chooseIroquois
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians n)
  (abundantForestTiles y)
  =>
  (assert (decision "Iroquois"))
)

(defrule chooseChinese
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians n)
  (abundantForestTiles n)
  (mapDensity sparse)
  =>
  (assert (decision "Chinese"))
)

(defrule chooseAmerican
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians n)
  (abundantForestTiles n)
  (mapDensity average)
  =>
  (assert (decision "American"))
)

(defrule chooseJapanese
  (victoryType domination)
  (abundantOceanTiles n)
  (ragingBarbarians n)
  (abundantForestTiles n)
  (mapDensity crowded)
  =>
  (assert (decision "Japanese"))
)


(defrule chooseGreek
  (victoryType diplomatic)
  (otherDiplomaticPlayers y)
  =>
  (assert (decision "Greek"))
)

(defrule chooseSiamese
  (victoryType diplomatic)
  (otherDiplomaticPlayers n)
  =>
  (assert (decision "Siamese"))
)


(defrule chooseAztec
  (victoryType culture)
  (aggressiveThreats y)
  =>
  (assert (decision "Aztec"))
)

(defrule chooseFrench
  (victoryType culture)
  (aggressiveThreats n)
  (roomForExpansion y)
  =>
  (assert (decision "French"))
)

(defrule chooseCultureEgypt
  (victoryType culture)
  (aggressiveThreats n)
  (roomForExpansion n)
  =>
  (assert (decision "Egyptian"))
)


(defrule chooseIndian
  (victoryType science)
  (roomForExpansion y)
  =>
  (assert (decision "Indian"))
)

(defrule chooseScienceEgypt
  (victoryType science)
  (roomForExpansion n)
  =>
  (assert (decision "Egyptian"))
)


(defrule choosePersian
  (victoryType flexible)
  (abundantResourceType luxury)
  =>
  (assert (decision "Persian"))
)

(defrule chooseArabian
  (victoryType flexible)
  (abundantResourceType strategic)
  (abundantOceanTiles y)
  =>
  (assert (decision "Arabian"))
)

(defrule chooseRussian
  (victoryType flexible)
  (abundantResourceType strategic)
  (abundantOceanTiles n)
  =>
  (assert (decision "Russian"))
)


; DECISON OUTPUT MESSAGE RULE

(defrule decisionMesage
  (decision ?d)
  =>
  (printout t crlf "You should choose the " ?d " civilisation." crlf)
)
