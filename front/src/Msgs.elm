module Msgs exposing (..)

import Http
import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | NewPlayersName String
    | NewPlayersLevel String
    | SaveNewPlayer Player
    | OnPlayerCreated (Result Http.Error Player)