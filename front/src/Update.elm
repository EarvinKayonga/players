module Update exposing (..)

import Commands exposing (savePlayerCmd, createPlayerCmd, deletePlayerCmd)
import Msgs exposing (Msg)
import Models exposing (Model, Player)
import RemoteData
import Routing exposing (parseLocation)



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response}, Cmd.none )
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in 
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeName player name  ->
            let
                updatedPlayer =
                    if (String.length name) > 0 then
                        { player | name = name  }
                    else
                        player
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )

        Msgs.OnPlayerCreated (Ok player) ->
            ( addToPlayers model player, Cmd.none )
        
        Msgs.OnPlayerCreated (Err error) ->
            ( model, Cmd.none )

        Msgs.NewPlayersName name ->
            let 
                newPlayer = Player model.newPlayer.id name model.newPlayer.level
            in
            ( { model | newPlayer = newPlayer }, Cmd.none )
        
        Msgs.NewPlayersLevel level ->
            let 
                newPlayer = Player model.newPlayer.id  model.newPlayer.name (Result.withDefault 1(String.toInt level))
            in
            ( { model | newPlayer = newPlayer }, Cmd.none )

        Msgs.SaveNewPlayer player ->
            ( { model | newPlayer = player }, createPlayerCmd player )
        
        Msgs.DeletePlayer player ->
            ( model, deletePlayerCmd player )
        
        Msgs.OnPlayerDeleted (Ok player) ->
            ( rmFromPlayers model player, Cmd.none )
        
        Msgs.OnPlayerDeleted (Err error) ->
            ( model, Cmd.none )
        


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer
        

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
        
    in
        { model | players = updatedPlayers }

addToPlayers : Model -> Player -> Model
addToPlayers  model addedPlayer =
    let
        pick currentPlayer =
            if addedPlayer.id == currentPlayer.id then
                addedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.append (List.map pick players) [ addedPlayer ]

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }


rmFromPlayers : Model -> Player -> Model
rmFromPlayers model rmedPlayer =
    let
        pick currentPlayer =
            if rmedPlayer.id == currentPlayer.id then
                rmedPlayer
            else
                currentPlayer

        updatePlayerList players =
            (List.map pick players)
            |> List.filter(isNotPlayer rmedPlayer) 

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }

isNotPlayer : Player -> Player -> Bool 
isNotPlayer player p = 
    player.id == p.id