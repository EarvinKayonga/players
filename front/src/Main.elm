module Main exposing (..)

import Commands exposing (fetchPlayers)
import Html exposing (Html, div, text, program)
import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( initialModel, fetchPlayers )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }