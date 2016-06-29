
import Html.App as Html
import Maybe exposing (..)

import Window exposing (..)
import Keyboard.Extra
import Navigation
import String 

import Layout exposing (..)
import Model exposing (..)


main =
  Navigation.program urlParser 
    { init = model
    , update = update
    , subscriptions = subscriptions 
    , view = view
    , urlUpdate = urlUpdate
    }


urlParser : Navigation.Parser (Result String Int)
urlParser =
  Navigation.makeParser (fromUrl << .hash)


fromUrl : String -> Result String Int
fromUrl url =
  String.toInt (String.dropLeft 2 url)


urlUpdate : Result String Int -> Model -> (Model, Cmd Msg)
urlUpdate result model =
  case result of
    Ok newCount ->
      ({ model | actualSlide = newCount }, Cmd.none)

    Err _ ->
      (model, Navigation.modifyUrl (toUrl model.actualSlide))


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
  [ resizes Resize
  , Sub.map KeyState Keyboard.Extra.subscriptions 
  ]

