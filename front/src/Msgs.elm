module Msgs exposing (..)

import Http
import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | ChangeName Player String
    | ChangeLevel Player Int
    | DeletePlayer Player
    | NewPlayersName String
    | NewPlayersLevel String
    | SaveNewPlayer Player
    | OnPlayerSave (Result Http.Error Player)
    | OnPlayerCreated (Result Http.Error Player)
    | OnPlayerDeleted (Result Http.Error Player)
    | OnLocationChange Location
    