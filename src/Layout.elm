module Layout exposing (..)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import List exposing (map, concatMap)
import String exposing (concat)
import Markdown exposing (..)
import List.Extra exposing (getAt)

import Window exposing (..)

import Css exposing (..)
import Model exposing (..)


-- VIEW

topMenu : Model -> Html Msg
topMenu model =
  div [] 
  [ nav [ class "navbar navbar-default navbar-static-top" ] 
      [ div [ class "navbar-header" ] 
        [ button [ class "navbar-toggle" ] 
          [ span [ class "sr-only" ] [ text "Toggle navigation" ]
          , span [ class "icon-bar" ] []
          , span [ class "icon-bar" ] []
          , span [ class "icon-bar" ] []
          ]
        , a [ class "navbar-brand" ] [ text "Portal Świadczeniodawcy" ]
        , a [ class "navbar-brand nav navbar-top-links pull-right visible-xs" ] 
          [ i [ class "fa fa-power-off fa-fw" ] []
          ]
        ]
      , a [ class "navbar-brand nav navbar-top-links navbar-right hidden-xs" ]
        [ i [ class "fa fa-power-off fa-fw" ] []
        ]
      , div [ class "navbar-default sidebar" ]
        [ div [ class "sidebar-nav navbar-collapse" ] [ generateMenu model ]
        ]
      ]
  ]


generateMenu : Model -> Html Msg
generateMenu model =
  let
    allElements = List.append (concatMap generateMenuGroup model.menu.def) 
      [ li
          [ class "text-center menu-collapse hidden-xs side-menu-toggler"
          , onClick (ToggleSideMenu (not model.config.smallSidebar)) ] 
          [ a [] [ text (if model.config.smallSidebar then ">" else "<") ] ] ]
  in
    ul [ class "nav in", id "side-menu" ] allElements 


menuElement : Bool -> MenuElement -> Html Msg
menuElement isLast element =
  li [ class (if isLast then "last-in-group" else "") ]
    [ a [ href element.href ]
        [ i [ class (concat [ "fa fa-", element.icon ]) ] []
        , span [] [ text element.title ]
        ]
    ]


mapMenuToHtml : List MenuElement -> List (Html Msg)
mapMenuToHtml elements =
  case elements of
    h :: [] -> [ menuElement True h ]
    h :: t -> (menuElement False h) :: (mapMenuToHtml t)
    [] -> []


generateMenuGroup : MenuGroup -> List (Html Msg)
generateMenuGroup group =
  let
    beginning = if group.title == "" then [] else 
      [ li [ class "menu-header" ] [ b [] [ text group.title ] ] ]
    tail = mapMenuToHtml group.elements
  in
    List.append beginning tail


view : Model -> Html Msg
view model =
  div [ class (if model.config.smallSidebar then "sidebar-small" else "")] 
    [ cssLink "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
    , cssLink "https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
    , cssLink "http://blackrockdigital.github.io/startbootstrap-sb-admin-2/dist/css/sb-admin-2.css"
--    , node "style" [] [ text (cssStyle model) ]
    , node "style" [ type' "text/css" ] [ text <| Css.slidesCss model.config ]
--    , topMenu model
    , recursiveDiv [ "container", "article", "slide" ] <| printRow [ toMarkdown model ]
    ]


cssLink : String -> Html Msg
cssLink cssHref =
  node "link" [ rel "stylesheet", href cssHref ] []


toMarkdown : Model -> Html Msg
toMarkdown model =
  let
    slide = getAt model.actualSlide model.presentation.slides
    body = case slide of
      Just s -> s.body
      Nothing -> "No slide found"
  in
    toHtml [] body


printRow : List (Html Msg) -> Html Msg
printRow content =
      div [ class "row" ] [ div [ class "col-md-12" ] content ]


recursiveDiv : List String -> Html Msg -> Html Msg
recursiveDiv classes body =
  case classes of
    h :: t -> div [ class h ] [ recursiveDiv t body ]
    _ -> body

