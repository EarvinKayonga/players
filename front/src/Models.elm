module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { players : WebData (List Player)
    , route : Route
    , newPlayer: Player
    }

initialModel : Route -> Model
initialModel route = 
    { players = RemoteData.Loading
    , newPlayer = Player "" "" 1
    , route = route
    }

type alias PlayerId =
    String

type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }

type Route 
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute

latestId : List Player -> String
latestId players =
    (toString ((List.length players) + 1)) 