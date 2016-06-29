module Model exposing (..)


import Window exposing (..)
import Char exposing (fromCode, KeyCode) 
import String
import Navigation 
import Keyboard.Extra exposing (arrows) 
import Task exposing (perform)


import Presentation exposing (..)

-- MODEL


type alias Model =
  { menu : Menu
  , config : CssConfig 
  , keys : Keyboard.Extra.Model 
  , actualSlide : Int
  , presentationLength : Int
  , presentation : Presentation
  }


type alias CssConfig =
  { windowSize : Size 
  , smallSidebar : Bool
  }


type alias MenuElement =
  { title : String
  , href : String
  , icon : String
  , selected : Bool
  }


type alias MenuGroup =
  { title : String
  , elements : List MenuElement
  }


type alias Menu =
  { small : Bool 
  , def : List MenuGroup 
  }


model : Result String Int -> (Model, Cmd Msg)
model urlResult =
  let
    (keyModel, subs) = Keyboard.Extra.init
    model =
      { menu = menuDefinition
      , config = CssConfig (Size 0 0) False
      , keys = keyModel 
      , actualSlide =
        case urlResult of
          Ok urlSlide -> urlSlide
          _ -> 0
      , presentationLength = (List.length samplePresentation.slides) - 1
      , presentation = samplePresentation
      }
    exec = 
      perform (\_ -> (Resize (Size 0 0))) (Resize) Window.size 
  in
    (model, exec) 


-- UPDATE


type Msg
  = InitialWindowSize
  | Resize Size 
  | ToggleSideMenu Bool 
  | KeyState Keyboard.Extra.Msg 
  | None


update : Msg -> Model -> (Model, Cmd msg)
update action model =
  case action of
    Resize size ->
      let
        config = model.config
        cssConfig = { config | windowSize = size }
      in
        { model | config = cssConfig } ! []

    None -> model ! []

    InitialWindowSize -> model ! []

    ToggleSideMenu shorten -> 
      let
        config = model.config
      in
        { model | config = { config | smallSidebar = shorten } } ! []

    KeyState keyMessage ->
      let
        (keyState, commands) =
          Keyboard.Extra.update keyMessage model.keys
        arrow = (arrows keyState)
        newSlide =
          if
            arrow.x == -1 || arrow.y == -1
          then
            max 0 <| model.actualSlide - 1
          else
            if arrow.x == 1 || arrow.y == 1
          then
            min model.presentationLength <| model.actualSlide + 1
          else
            model.actualSlide
      in
        { model 
          | keys = keyState 
          , actualSlide = newSlide } ! 
          (if newSlide /= model.actualSlide
           then [ Navigation.newUrl (toUrl newSlide) ]
           else []
          )


toUrl : Int -> String
toUrl count =
  "#/" ++ toString count


menuDefinition : Menu 
menuDefinition =
  { small = False
  , def =
      [ { title = ""
        , elements = 
          [ { title = "Tablica główna"
            , href = "/#/main/dashboard"
            , icon = "dashboard"
            , selected = False
            }
          ] 
        }
      , { title = "Pacjent"
        , elements = 
          [ { title = "Wyszukiwanie"
            , href = "/#/patient/search"
            , icon = "search"
            , selected = False
            }
          ] 
        }
      , { title = "Usługi"
        , elements = 
          [ { title = "Wyszukiwanie"
            , href = "/#/service/list"
            , icon = "th-list"
            , selected = False
            }
          ] 
        }
      , { title = "Raporty"
        , elements = 
          [ { title = "Wykonanych usług"
            , href = "/#/report/servicesDelivered"
            , icon = "bar-chart"
            , selected = False
            }
          ] 
        }
      ]
  }


