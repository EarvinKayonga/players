module  Players.Create exposing (..)

import Html.Attributes exposing (class)
import Html exposing (..)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onInput, onClick)
import Msgs exposing (Msg(..))
import Models exposing (Model, Player, latestId)

create : Model -> List Player -> Html Msg
create model players = 
        tr []
            [ td [] [ text (latestId players) ] 
            , td [] [ input [ type_ "text", class "border-none", placeholder "Name", onInput NewPlayersName ] [] ]
            , td [] [ input [ type_ "number", class "border-none", placeholder "Level", onInput NewPlayersLevel ] [] ]
            , td []
                [ createBtn model (latestId players) ]
            ]


createBtn : Model -> String -> Html Msg
createBtn model id =
    let
      player =  Player id model.newPlayer.name model.newPlayer.level
      message = SaveNewPlayer player
    in
      a 
        [ class "btn regular"
        , onClick message 
        ]
        [ i [ class "fa fa-plus mr1" ] [], text "Create" ]

