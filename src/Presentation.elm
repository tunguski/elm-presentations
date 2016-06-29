module Presentation exposing (..)


import Dict exposing (..)


type alias Presentation =
  { slides : List Slide
  , title : String 
  }

type alias Slide =
  { id : String
  , body : String
  }

parsePresentation : Dict String String -> String -> Presentation
parsePresentation config text =
  Presentation [] ""

samplePresentation : Presentation
samplePresentation =
  { title = "Sample Presentation"
  , slides =
    [ { id = "Start"
      , body = """# Sample Presentation

* First point
* Second point"""
      }
    , { id = "End"
      , body = """## Thank you for watching!

Created by [Marek Romanowski](https://tunguski.github.io)
"""
      }
    ]
  }

