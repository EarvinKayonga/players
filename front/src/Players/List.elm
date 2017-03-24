module  Players.List exposing (..)

import Players.Create exposing (create, deleteBtn)
import Html exposing (..)
import Html.Attributes exposing (class, href, title)
import Msgs exposing (Msg)
import Models exposing (Player, Model )
import RemoteData exposing (WebData)
import Routing exposing (playerPath)

maybeList : Model -> Html Msg
maybeList model =
    case model.players of
        RemoteData.NotAsked ->
            text ""
        
        RemoteData.Loading ->
            text "Loading..."
        
        RemoteData.Success players ->
            list model players
        
        RemoteData.Failure error ->
            text (toString error)


view : Model -> Html Msg
view model =
    div []
        [ nav
        , maybeList model
        ]

nav : Html Msg
nav = 
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ] ]

list : Model -> List Player -> Html Msg
list model players =
     div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id"]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ] 
                    ]
                ]
            , tbody []
                    (List.append ([ create model players ])  (List.map playerRow players))
            ]
        ]

playerRow : Player -> Html Msg
playerRow player  =
    tr []
        [ td [] [ text player.id ] 
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ (editBtn player), (deleteBtn player) ]
        ]

editBtn : Player -> Html.Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
        a
            [ class "btn regular"
            , href path
            , title "Edit"
            ]
            [ i [ class "fa fa-pencil mr1" ] [] ]

