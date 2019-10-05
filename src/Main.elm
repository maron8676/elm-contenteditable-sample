module Main exposing (main)

import Browser
import Html exposing (Html, div, label, text)
import Html.Attributes exposing (contenteditable, value)
import Html.Events exposing (on)
import Json.Decode as JD


main : Platform.Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    { text : String
    }


type Msg
    = UpdateText String


init =
    Model "init"


view : Model -> Html Msg
view model =
    div []
        [ div
            [ contenteditable True
            , on "input" <|
                JD.map UpdateText
                    (JD.at [ "target", "textContent" ] JD.string)
            ]
            [ text model.text ]
        , label [] [ text <| "edited: " ++ model.text ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateText newText ->
            { model | text = newText }
